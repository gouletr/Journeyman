local addonName, addon = ...

addon.Traveler = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceHook-3.0", "AceEvent-3.0", "AceConsole-3.0")
addon.Locale = LibStub("AceLocale-3.0"):GetLocale(addonName)

local L = addon.Locale
local Traveler = addon.Traveler

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
