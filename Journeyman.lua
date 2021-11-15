local addonName, addon = ...
addon.Journeyman = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceHook-3.0", "AceEvent-3.0", "AceConsole-3.0")
addon.Locale = LibStub("AceLocale-3.0"):GetLocale(addonName)

local Journeyman = addon.Journeyman
local L = addon.Locale

Journeyman.STEP_TYPE_UNDEFINED = "UNDEFINED"
Journeyman.STEP_TYPE_ACCEPT_QUEST = "ACCEPT"
Journeyman.STEP_TYPE_COMPLETE_QUEST = "COMPLETE"
Journeyman.STEP_TYPE_TURNIN_QUEST = "TURNIN"
Journeyman.STEP_TYPE_REACH_LEVEL = "LEVEL"
Journeyman.STEP_TYPE_BIND_HEARTHSTONE = "BIND"
Journeyman.STEP_TYPE_USE_HEARTHSTONE = "HEARTH"
Journeyman.STEP_TYPE_LEARN_FLIGHT_PATH = "LEARNFP"
Journeyman.STEP_TYPE_FLY_TO = "FLYTO"
Journeyman.ITEM_HEARTHSTONE = 6948
Journeyman.SPELL_HEARTHSTONE = 8690
Journeyman.SPELL_ASTRAL_RECALL = 556
Journeyman.ICON_HUNTERS_MARK = 132212

local tinsert = table.insert

-- Some taxi nodes were never implemented in game, or are innacessible, or don't need to be considered (e.g. battlegrounds)
local taxiNodeIdsToSkip = {1, 3, 9, 15, 24, 34, 35, 36, 46, 47, 50, 51, 54, 57, 59, 60, 78, 84, 85, 86, 87}
local skipTaxiNodeIds = {}
for i = 1, #taxiNodeIdsToSkip do
    skipTaxiNodeIds[taxiNodeIdsToSkip[i]] = true
end

function Journeyman:OnInitialize()
    self:InitializeDatabase()
    self:InitializeOptions()
    self.State:Initialize()
    self:InitializeHooks()
    self:InitializeEvents()
    self.Journey:Initialize()
    self.Window:Initialize()
end

function Journeyman:OnEnable()
    self:Reset()
end

function Journeyman:OnDisable()
    self.Window:Shutdown()
    self:ShutdownEvents()
    self.State:Shutdown()
end

function Journeyman:Reset(immediate)
    if self.db.char.window.show then
        self:UpdateWaypoint()
        self:UpdateMacro()
        self.State:Reset(immediate)
    end
end

function Journeyman:Update(immediate)
    if self.db.char.window.show then
        self.State:Update(immediate)
    end
end

function Journeyman:UpdateWaypoint()
    self.waypointNeedUpdate = true
end

function Journeyman:UpdateMacro()
    self.macroNeedUpdate = true
end

function Journeyman:Debug(fmt, ...)
    if self.db.profile.advanced.debug then
        self:Print("[DEBUG] " .. string.format(fmt, ...))
    end
end

function Journeyman:Error(fmt, ...)
    if self.db.profile.advanced.debug then
        local text = string.format(fmt, ...)
        self:Print("[ERROR] " .. text)
        error(text)
    end
end

function Journeyman:GetQuestLogNumEntries()
    if C_QuestLog.GetNumQuestLogEntries ~= nil then
        return C_QuestLog.GetNumQuestLogEntries()
    else
        return GetNumQuestLogEntries()
    end
end

function Journeyman:GetQuestLogInfo(questLogIndex)
    if C_QuestLog.GetInfo then
        local info = C_QuestLog.GetInfo(questLogIndex)
        if info then
            return {
                title = info.title,
                level = info.level,
                suggestedGroup = info.suggestedGroup,
                isHeader = info.isHeader,
                isCollapsed = info.isCollapsed,
                isComplete = C_QuestLog.IsComplete(info.questID),
                isFailed = C_QuestLog.IsFailed(info.questID),
                frequency = info.frequency,
                questId = info.questID,
                questLogIndex = questLogIndex
            }
        end
    else
        local title, level, suggestedGroup, isHeader, isCollapsed, isComplete, frequency, questId = GetQuestLogTitle(questLogIndex)
        if title then
            return {
                title = title,
                level = level,
                suggestedGroup = suggestedGroup,
                isHeader = isHeader,
                isCollapsed = isCollapsed,
                isComplete = isComplete == 1,
                isFailed = isComplete == -1,
                frequency = frequency,
                questId = questId,
                questLogIndex = questLogIndex
            }
        end
    end
end

function Journeyman:GetQuestLog()
    local questLog = {}
    local entriesCount = self:GetQuestLogNumEntries()
    for i = 1, entriesCount do
        local info = self:GetQuestLogInfo(i)
        if info and not info.isHeader then
            questLog[info.questId] = info
        end
    end
    return questLog
end

function Journeyman:GetItemName(itemId, callback)
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

function Journeyman:GetItemLink(itemId, callback)
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

function Journeyman:GetMapName()
    local uiMapId = C_Map.GetBestMapForUnit("player")
    local mapInfo = uiMapId and C_Map.GetMapInfo(uiMapId) or nil
    if mapInfo then
        return mapInfo.name
    end
end

function Journeyman:GetAreaIdFromLocalizedName(name)
    if self.areaNameToAreaId == nil then
        self.areaNameToAreaId = {}
        for k, v in pairs(L.areaTable) do
            self.areaNameToAreaId[v.AreaName_lang] = k
        end
    end
    return self.areaNameToAreaId[name]
end

function Journeyman:GetAreaName(areaId)
    if areaId and type(areaId) == "number" then
        local info = L.areaTable[areaId]
        if info then
            return info.AreaName_lang
        end
    end
end

function Journeyman:GetAreaParentAreaId(areaId)
    if areaId and type(areaId) == "number" then
        local info = L.areaTable[areaId]
        if info then
            return info.ParentAreaID
        end
    end
end

function Journeyman:GetTaxiNodeIdFromLocalizedName(name)
    if self.taxiNodeNameToTaxiNodeId == nil then
        self.taxiNodeNameToTaxiNodeId = {}
        for k, v in pairs(L.taxiNodes) do
            self.taxiNodeNameToTaxiNodeId[v.Name_lang] = k
        end
    end
    return self.taxiNodeNameToTaxiNodeId[name]
end

function Journeyman:IsTaxiNodeAvailable(taxiNodeId)
    if skipTaxiNodeIds[taxiNodeId] then
        return false
    end

    local playerFaction = UnitFactionGroup("player")
    local taxiNodeFaction = Journeyman:GetTaxiNodeFaction(taxiNodeId)
    if playerFaction ~= taxiNodeFaction and taxiNodeFaction ~= "Neutral" then
        return false
    end

    return true
end

function Journeyman:GetTaxiNodeName(taxiNodeId)
    if taxiNodeId and type(taxiNodeId) == "number" then
        local info = L.taxiNodes[taxiNodeId]
        if info then
            return info.Name_lang
        end
    end
end

function Journeyman:GetTaxiNodeWorldCoordinates(taxiNodeId)
    if taxiNodeId and type(taxiNodeId) == "number" then
        local info = L.taxiNodes[taxiNodeId]
        if info then
            return { [1] = info.Pos[2], [2] = info.Pos[1] }
        end
    end
end

function Journeyman:GetTaxiNodeFaction(taxiNodeId)
    if taxiNodeId and type(taxiNodeId) == "number" then
        local info = L.taxiNodes[taxiNodeId]
        if info then
            if info.Flags == 1 then
                return "Alliance"
            elseif info.Flags == 2 then
                return "Horde"
            elseif info.Flags == 3 then
                return "Neutral"
            end
        end
    end
end

function Journeyman:IsStepTypeQuest(step)
    return step.type == self.STEP_TYPE_ACCEPT_QUEST or step.type == self.STEP_TYPE_COMPLETE_QUEST or step.type == self.STEP_TYPE_TURNIN_QUEST
end

function Journeyman:GetStepText(step, showQuestLevel, showId, callback)
    if self:IsStepTypeQuest(step) then
        local questName = self.DataSource:GetQuestName(step.data, showQuestLevel)
        if questName == nil then
            if step.data == nil then
                questName = string.format("<%s>", L["NO_VALUE"])
            elseif type(step.data) ~= "number" then
                questName = string.format("<%s>", L["NOT_A_NUMBER"])
            else
                questName = string.format("quest:%d", step.data)
            end
        end
        if showId then
            questName = string.format("%s (%d)", questName, step.data)
        end
        if step.type == Journeyman.STEP_TYPE_ACCEPT_QUEST then
            return string.format(L["STEP_ACCEPT_QUEST"], questName)
        elseif step.type == Journeyman.STEP_TYPE_COMPLETE_QUEST then
            return string.format(L["STEP_COMPLETE_QUEST"], questName)
        elseif step.type == Journeyman.STEP_TYPE_TURNIN_QUEST then
            return string.format(L["STEP_TURNIN_QUEST"], questName)
        else
            Journeyman:Error("Step type %s not implemented.", step.type)
        end
    else
        if step.type == Journeyman.STEP_TYPE_UNDEFINED then
            return string.format("<%s>", L["UNDEFINED"])
        elseif step.type == Journeyman.STEP_TYPE_REACH_LEVEL then
            local level = step.data
            if level == nil then
                level = string.format("<%s>", L["NO_VALUE"])
            elseif type(level) ~= "number" then
                level = string.format("<%s>", L["NOT_A_NUMBER"])
            end
            return string.format(L["STEP_REACH_LEVEL"], level)
        elseif step.type == Journeyman.STEP_TYPE_BIND_HEARTHSTONE or step.type == Journeyman.STEP_TYPE_USE_HEARTHSTONE then
            local itemLink = Journeyman:GetItemLink(Journeyman.ITEM_HEARTHSTONE, callback)
            if itemLink == nil then
                itemLink = string.format("<%s>", L["NO_VALUE"])
            elseif type(itemLink) ~= "string" then
                itemLink = string.format("<%s>", L["NOT_A_STRING"])
            end
            local areaName = self:GetAreaName(step.data)
            if areaName == nil then
                if step.data == nil then
                    areaName = string.format("<%s>", L["NO_VALUE"])
                elseif type(step.data) ~= "number" then
                    areaName = string.format("<%s>", L["NOT_A_NUMBER"])
                else
                    areaName = string.format("area:%d", step.data)
                end
            end
            if showId then
                areaName = string.format("%s (%s)", areaName, step.data)
            end
            if step.type == Journeyman.STEP_TYPE_BIND_HEARTHSTONE then
                return string.format(L["STEP_BIND_HEARTHSTONE"], itemLink, areaName)
            else
                return string.format(L["STEP_USE_HEARTHSTONE"], itemLink, areaName)
            end
        elseif step.type == Journeyman.STEP_TYPE_LEARN_FLIGHT_PATH or step.type == Journeyman.STEP_TYPE_FLY_TO then
            local taxiNodeName = self:GetTaxiNodeName(step.data)
            if taxiNodeName == nil then
                if step.data == nil then
                    taxiNodeName = string.format("<%s>", L["NO_VALUE"])
                elseif type(step.data) ~= "number" then
                    taxiNodeName = string.format("<%s>", L["NOT_A_NUMBER"])
                else
                    taxiNodeName = string.format("taxiNode:%d", step.data)
                end
            end
            if showId then
                taxiNodeName = string.format("%s (%s)", taxiNodeName, step.data)
            end
            if step.type == Journeyman.STEP_TYPE_LEARN_FLIGHT_PATH then
                return string.format(L["STEP_LEARN_FLIGHT_PATH"], taxiNodeName)
            else
                return string.format(L["STEP_FLY_TO"], taxiNodeName)
            end
        else
            Journeyman:Error("Step type %s not implemented.", step.type)
        end
    end
end

function Journeyman:SetWaypoint(step, force, neededObjectivesOnly)
    if TomTom then
        if self.db.char.waypoint and TomTom.RemoveWaypoint then
            TomTom:RemoveWaypoint(self.db.char.waypoint)
            self.db.char.waypoint = nil
        end

        if step and TomTom.AddWaypoint then
            local location
            if step.hasChildren then
                location = step.location
            else
                location = self.State:GetStepLocation(step, neededObjectivesOnly)
            end

            if location and (force or location.distance >= self.db.profile.autoSetWaypointMin) then
                self.db.char.waypoint = TomTom:AddWaypoint(location.mapId, location.x / 100.0, location.y / 100.0, { title = location.name, crazy = true })
            end
        end
    end
end

function Journeyman:SetMacro()
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
        macroId = CreateMacro(addonName, Journeyman.ICON_HUNTERS_MARK)
        if macroId then
            local name, icon, body, isLocal = GetMacroInfo(macroId)
            macroIcon = icon
            macroBody = body
        end
    end

    -- Early exit if we can't create a new macro
    if macroId == nil then
        Journeyman:Error("Failed to create targeting macro.")
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

function Journeyman:ReplaceAllItemStringToHyperlinks(input, callback)
    if input and type(input) == "string" then
        local result = input
        local itemString, itemId
        while true do
            itemString, itemId = string.match(result, "[^H](item:(%d+))")
            if itemString and itemId then
                local itemLink = Journeyman:GetItemLink(tonumber(itemId), callback)
                if itemLink and itemLink ~= itemString then
                    result = string.gsub(result, itemString, itemLink)
                else
                    break
                end
            else
                break
            end
        end
        return result
    end
end