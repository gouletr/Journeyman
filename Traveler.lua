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

Traveler.ITEM_HEARTHSTONE = 6948

Traveler.SPELL_HEARTHSTONE = 8690
Traveler.SPELL_ASTRAL_RECALL = 556

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
    self.State:Reset()
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
    local itemName, itemLink, itemQuality = GetItemInfo(itemId)

    if itemName == nil then
        local item = Item:CreateFromItemID(itemId)
        item:ContinueOnItemLoad(function() callback() end)
        return string.format("item:%s", itemId)
    end

    return itemName
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
