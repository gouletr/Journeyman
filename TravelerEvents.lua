local addonName, addon = ...
local L = addon.Locale
local Traveler = addon.Traveler

if C_QuestLog.IsComplete == nil then
    C_QuestLog.IsComplete = function(questId)
        local entriesCount, questCount = GetNumQuestLogEntries()
        for i=1,entriesCount do
            local _, _, _, isHeader, _, isComplete, _, id = GetQuestLogTitle(i)
            if not isHeader and id == questId then
                return isComplete == 1
            end
        end
        return false
    end
end

function Traveler:InitializeEvents()
    self:RegisterEvent("PLAYER_LEAVING_WORLD", function(event) self:OnPlayerLeavingWorld(questId) end)
    --self:RegisterEvent("PLAYER_LOGOUT", function(event) self:OnPlayerLogOut(questId) end)
    self:RegisterEvent("QUEST_ACCEPTED", function(event, questLogIndex, questId) self:OnQuestAccepted(questId) end)
    self:RegisterEvent("QUEST_WATCH_UPDATE", function(event, questId) self:OnQuestProgress(questId) end)
    self:RegisterEvent("QUEST_REMOVED", function(event, questId) self:OnQuestRemoved(questId) end)
    self:RegisterEvent("QUEST_TURNED_IN", function(event, questId) self:OnQuestTurnedIn(questId) end)
    self:RegisterEvent("QUEST_LOG_UPDATE", function(event) self:OnQuestLogUpdate() end)
end

-- CONFIRM_BINDER location
-- HEARTHSTONE_BOUND

function Traveler:OnPlayerLeavingWorld()
    self:SerializeDatabase()
end

function Traveler:OnPlayerLogOut()
    self:SerializeDatabase()
end

function Traveler:OnQuestAccepted(questId)
    self:JourneyAddQuestAccept(questId)
    self.Tracker:Update()
end

function Traveler:OnQuestProgress(questId)
    if self.questProgress == nil then
        self.questProgress = {}
    end
    self.questProgress[questId] = false
end

function Traveler:OnQuestTurnedIn(questId)
    self.questTurnedIn = questId
    self:JourneyAddQuestTurnIn(questId)
    self.Tracker:Update()
end

function Traveler:OnQuestRemoved(questId)
    if self.questTurnedIn == nil then
       self:OnQuestAbandoned(questId)
    else
        self.questTurnedIn = nil
    end
end

function Traveler:OnQuestAbandoned(questId)
    self:JourneyRemoveQuest(questId)
    self.Tracker:Update()
end

function Traveler:OnQuestLogUpdate()
    if self.questProgress == nil then
        self.questProgress = {}
    end

    -- Check if progress quest is complete
    local hasChanges = false
    for questId,_ in pairs(self.questProgress) do
        if C_QuestLog.IsComplete(questId) then
            self:JourneyAddQuestComplete(questId)
            self.questProgress[questId] = true
            hasChanges = true
        end
    end

    -- Remove completed quests
    for questId,isComplete in pairs(self.questProgress) do
        if isComplete then
            self.questProgress[questId] = nil
        end
    end

    -- Update Tracker if there's any changes
    if hasChanges then self.Tracker:Update() end
end
