local addonName, addon = ...
addon.Traveler = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceHook-3.0", "AceEvent-3.0", "AceConsole-3.0")
addon.Locale = LibStub("AceLocale-3.0"):GetLocale(addonName)

local Traveler = addon.Traveler
local L = addon.Locale

Traveler.STEP_TYPE_UNDEFINED = "UNDEFINED"
Traveler.STEP_TYPE_ACCEPT_QUEST = "ACCEPT"
Traveler.STEP_TYPE_COMPLETE_QUEST = "COMPLETE"
Traveler.STEP_TYPE_TURNIN_QUEST = "TURNIN"
Traveler.STEP_TYPE_FLY_TO = "FLYTO"
Traveler.STEP_TYPE_BIND_HEARTHSTONE = "BIND"
Traveler.STEP_TYPE_USE_HEARTHSTONE = "HEARTH"
Traveler.STEP_TYPE_REACH_LEVEL = "LEVEL"
Traveler.ITEM_HEARTHSTONE = 6948
Traveler.SPELL_HEARTHSTONE = 8690
Traveler.SPELL_ASTRAL_RECALL = 556
Traveler.ICON_HUNTERS_MARK = 132212

local tinsert = table.insert

function Traveler:OnInitialize()
    self:InitializeDatabase()
    self:InitializeOptions()
    self.State:Initialize()
    self:InitializeHooks()
    self:InitializeEvents()
    self:InitializeJourney()
    self.Tracker:Initialize()
end

function Traveler:OnEnable()
    self.State:Reset(false, function(self)
        Traveler:UpdateTargetingMacro()
    end)
end

function Traveler:OnDisable()
    self.Tracker:Shutdown()
    self.State:Shutdown()
end

function Traveler:Debug(fmt, ...)
    if self.db.profile.advanced.debug then
        self:Print("[DEBUG] " .. string.format(fmt, ...))
    end
end

function Traveler:Error(fmt, ...)
    if self.db.profile.advanced.debug then
        local text = string.format(fmt, ...)
        self:Print("[ERROR] " .. text)
        error(text)
    end
end

function Traveler:IsStepTypeQuest(step)
    return step.type == self.STEP_TYPE_ACCEPT_QUEST or step.type == self.STEP_TYPE_COMPLETE_QUEST or step.type == self.STEP_TYPE_TURNIN_QUEST
end

function Traveler:IsStepDataNumber(step)
    return self:IsStepTypeQuest(step) or step.type == self.STEP_TYPE_REACH_LEVEL
end

function Traveler:GetQuestLogNumEntries()
    if C_QuestLog.GetNumQuestLogEntries ~= nil then
        return C_QuestLog.GetNumQuestLogEntries()
    else
        return GetNumQuestLogEntries()
    end
end

function Traveler:GetQuestLogInfo(questLogIndex)
    if C_QuestLog.GetInfo ~= nil then
        local info = C_QuestLog.GetInfo(questLogIndex)
        if info ~= nil then
            return {
                questId = info.questID,
                isHeader = info.isHeader,
                isComplete = info.isComplete
            }
        end
    else
        local title, level, suggestedGroup, isHeader, isCollapsed, isComplete, frequency, questID, startEvent, displayQuestID, isOnMap, hasLocalPOI, isTask, isBounty, isStory, isHidden, isScaling = GetQuestLogTitle(questLogIndex)
        return {
            questId = questID,
            isHeader = isHeader,
            isComplete = isComplete == 1
        }
    end
end

function Traveler:GetQuestLogIsComplete(questId)
    for i = 1, self:GetQuestLogNumEntries() do
        local info = self:GetQuestLogInfo(i)
        if info ~= nil and not info.isHeader and info.questId == questId then
            return info.isComplete
        end
    end
    return false
end

function Traveler:GetItemName(itemId, callback)
    if itemId and type(itemId) == "number" then
        local itemName = GetItemInfo(itemId)
        if itemName == nil then
            if callback and type(callback) == "function" then
                local item = Item:CreateFromItemID(itemId)
                item:ContinueOnItemLoad(callback)
            end
            return "item:" .. itemId
        end
        return itemName
    end
end

function Traveler:GetItemLink(itemId, callback)
    if itemId and type(itemId) == "number" then
        local itemName, itemLink = GetItemInfo(itemId)
        if itemName == nil then
            if callback and type(callback) == "function" then
                local item = Item:CreateFromItemID(itemId)
                item:ContinueOnItemLoad(callback)
            end
            return "item:" .. itemId
        end
        return itemLink
    end
end

function Traveler:SetWaypoint(step, force)
    if step then
        if TomTom and TomTom.AddWaypoint then
            if self.db.char.waypoint and TomTom.RemoveWaypoint then
                TomTom:RemoveWaypoint(self.db.char.waypoint)
            end

            local location = self.State:GetStepLocation(step)
            if location and (force or location.distance >= self.db.profile.autoSetWaypointMin) then
                self.db.char.waypoint = TomTom:AddWaypoint(location.mapId, location.x / 100.0, location.y / 100.0, { title = location.name, crazy = true })
            end
        end
    end
end

function Traveler:UpdateTargetingMacro()
    self.macroNeedUpdate = true

    if InCombatLockdown() then
        return
    end

    -- Find macro
    local macroId, macroIcon, macroBody
    for i = 1, GetNumMacros() do
        local name, icon, body, isLocal = GetMacroInfo(i)
        if name and name == addonName then
            macroId = i
            macroIcon = icon
            macroBody = body
            break
        end
    end

    -- Create macro if not found
    if macroId == nil then
        macroId = CreateMacro(addonName, Traveler.ICON_HUNTERS_MARK)
        if macroId then
            local name, icon, body, isLocal = GetMacroInfo(macroId)
            macroIcon = icon
            macroBody = body
        end
    end

    -- Early exit if we can't create a new macro
    if macroId == nil then
        Traveler:Error("Failed to create targeting macro.")
        return
    end

    -- Update macro body
    local body = ""
    local currentStep = self.State:GetCurrentStep()
    if currentStep and currentStep.type == self.STEP_TYPE_COMPLETE_QUEST then
        -- Get quest objectives
        local objectives = self.DataSource:GetQuestObjectives(currentStep.data)
        if objectives then
            -- Get NPC objective names
            local names = {}
            for i, objective in ipairs(objectives or {}) do
                if objective and objective.type == "NPC" and not objective.isComplete then
                    tinsert(names, objective.name)
                end
            end

            -- Append NPC names to macro
            for i, name in ipairs(names) do
                local append = string.format("/tar [noexists][dead][help] %s\n", name)
                if string.len(body) + string.len(append) <= 255 then
                    body = body .. append
                end
            end

            -- Clear target
            append = "/cleartarget [noexists][dead][help]\n"
            if string.len(body) > 0 and string.len(body) + string.len(append) <= 255 then
                body = body .. append
            end

            -- Target marker
            append = "/tm [exists] 8\n"
            if string.len(body) > 0 and string.len(body) + string.len(append) <= 255 then
                body = body .. append
            end
        end
    end

    -- Update macro
    if body ~= macroBody then
        EditMacro(macroId, addonName, macroIcon, body)
    end

    self.macroNeedUpdate = false
end

function Traveler:ReplaceAllItemStringToHyperlinks(input, callback)
    if input and type(input) == "string" then
        local result = input
        local itemString, itemId
        repeat
            itemString, itemId = string.match(result, "[^H](item:(%d+))")
            if itemString and itemId then
                local itemLink = Traveler:GetItemLink(tonumber(itemId), callback)
                if itemLink and itemLink ~= itemString then
                    result = string.gsub(result, itemString, itemLink)
                else
                    break
                end
            else
                break
            end
        until itemString == nil
        return result
    end
end

function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end
