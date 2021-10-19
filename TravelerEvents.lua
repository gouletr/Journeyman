local addonName, addon = ...
local L = addon.Locale
local Traveler = addon.Traveler

function Traveler:InitializeEvents()
    self:RegisterEvent("QUEST_ACCEPTED", function(event, questLogIndex, questId) self:OnQuestAccepted(questId) end)
    self:RegisterEvent("QUEST_REMOVED", function(event, questId) self:OnQuestRemoved(questId) end)
    self:RegisterEvent("QUEST_TURNED_IN", function(event, questId) self:OnQuestTurnedIn(questId) end)
    --self:RegisterEvent("QUEST_LOG_UPDATE", function(event) self:OnQuestLogUpdate() end)
end

function Traveler:OnQuestAccepted(questId)
    self:Debug("OnQuestAccepted "..questId)
    self:JourneyAddQuestAccept(questId)
end

function Traveler:OnQuestTurnedIn(questId)
    self:Debug("OnQuestTurnedIn "..questId)
    self.questTurnedIn = questId
    self:JourneyAddQuestTurnIn(questId)
end

function Traveler:OnQuestRemoved(questId)
    if self.questTurnedIn == nil then
       self:OnQuestAbandoned(questId)
    else
        self:Debug("OnQuestRemoved "..questId)
        self.questTurnedIn = nil
    end
end

function Traveler:OnQuestAbandoned(questId)
    self:Debug("OnQuestAbandoned "..questId)
    self:JourneyRemoveQuest(questId)
end

function Traveler:OnQuestLogUpdate()
    self:Debug("OnQuestLogUpdate")
end
