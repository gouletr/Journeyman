local addonName, addon = ...
local Traveler = addon.Traveler
local L = addon.Locale

function Traveler:InitializeEvents()
    self.questTurnedIn = {}
    self.questProgress = {}

    -- This is too late to serialize data, doesn't work
    --self:RegisterEvent("PLAYER_LOGOUT", function(event)
    --    self:SerializeDatabase()
    --end)

    self:RegisterEvent("PLAYER_LEAVING_WORLD", function(event)
        self:SerializeDatabase()
    end)

    self:RegisterEvent("QUEST_ACCEPTED", function(event, questLogIndex, questId)
        self:OnQuestAccepted(questId)
    end)

    self:RegisterEvent("QUEST_TURNED_IN", function(event, questId)
        self.questTurnedIn[questId] = true
        self:OnQuestTurnedIn(questId)
    end)

    self:RegisterEvent("QUEST_REMOVED", function(event, questId)
        if self.questTurnedIn[questId] == nil then
           self:OnQuestAbandoned(questId)
        else
            self.questTurnedIn[questId] = nil
        end
    end)

    self:RegisterEvent("QUEST_WATCH_UPDATE", function(event, questId)
        self.questProgress[questId] = true
    end)

    self:RegisterEvent("QUEST_LOG_UPDATE", function(event)
        self.State:UpdateQuestLog()

        -- Fire OnQuestCompleted event
        local completedQuests = {}
        for questId, _ in ipairs(self.questProgress) do
            local info = self.State:GetQuestLogInfo(questId)
            if info and info.isComplete then
                completedQuests[questId] = true
                self:OnQuestCompleted(questId)
            end
        end

        -- Remove completed quests from watch
        for questId, _ in ipairs(completedQuests) do
            self.questProgress[questId] = nil
        end
    end)

    self:RegisterEvent("CONFIRM_BINDER", function(event, location)
        self.bindLocation = location
    end)

    self:RegisterEvent("HEARTHSTONE_BOUND", function(event)
        if self.bindLocation ~= nil then
            self:OnHearthstoneBound(self.bindLocation)
            self.bindLocation = nil
        end
    end)
end

function Traveler:OnPlayerLeavingWorld()
    self:SerializeDatabase()
end

function Traveler:OnQuestAccepted(questId)
    self.State:OnQuestAccepted(questId)
    self:JourneyAddQuestAccept(questId)
end

function Traveler:OnQuestCompleted(questId)
    self.State:OnQuestCompleted(questId)
    self:JourneyAddQuestComplete(questId)
end

function Traveler:OnQuestTurnedIn(questId)
    self.State:OnQuestTurnedIn(questId)
    self:JourneyAddQuestTurnIn(questId)
end

function Traveler:OnQuestAbandoned(questId)
    self.State:OnQuestAbandoned(questId)
    self:JourneyRemoveQuest(questId)
end

function Traveler:OnHearthstoneBound(location)
    self.State:OnHearthstoneBound(location)
    self:JourneyAddBindHearthstone(location)
end
