local addonName, addon = ...
local Traveler = addon.Traveler
local L = addon.Locale

function Traveler:InitializeEvents()
    self.questTurnedIn = {}
    self.questProgress = {}

    -- This is too late to serialize data, doesn't work
    -- self:RegisterEvent("PLAYER_LOGOUT", function(event)
        -- self:SerializeDatabase()
    -- end)

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
        Traveler:UpdateTargetingMacro()
    end)

    self:RegisterEvent("QUEST_LOG_UPDATE", function(event)
        local completedQuests = {}
        if next(self.questProgress) then
            self.State:UpdateQuestLog()
            for questId, _ in pairs(self.questProgress) do
                local info = self.State:GetQuestLogInfo(questId)
                if info and info.isComplete then
                    self:OnQuestCompleted(questId)
                    completedQuests[questId] = true
                end
            end
        end
        if next(completedQuests) then
            for questId, _ in pairs(completedQuests) do
                self.questProgress[questId] = nil
            end
        else
            Traveler:Update()
        end
    end)

    self:RegisterEvent("CONFIRM_BINDER", function(event, location)
        local areaId = Traveler:GetAreaIdFromLocalizedName(location)
        if areaId then
            self.bindAreaId = areaId
        else
            Traveler:Error("Could not find areaId for location name '%s'.", location)
        end
    end)

    self:RegisterEvent("HEARTHSTONE_BOUND", function(event)
        if self.bindAreaId then
            self:OnHearthstoneBound(self.bindAreaId)
            self.bindAreaId = nil
        end
    end)

    self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED", function(event, unitTarget, castGUID, spellID)
        if spellID == Traveler.SPELL_HEARTHSTONE or spellID == Traveler.SPELL_ASTRAL_RECALL then
            local areaId = Traveler:GetAreaIdFromLocalizedName(GetBindLocation())
            if areaId then
                self:OnHearthstoneUsed(areaId)
            else
                Traveler:Error("Could not find areaId for location name '%s'.", location)
            end
        end
    end)

    self:RegisterEvent("PLAYER_REGEN_ENABLED", function(event)
        if Traveler.macroNeedUpdate then
            Traveler:UpdateTargetingMacro()
        end
    end)

    self:RegisterEvent("PLAYER_LEVEL_UP", function(event, level, healthDelta, powerDelta, numNewTalents, numNewPvpTalentSlots, strengthDelta, agilityDelta, staminaDelta, intellectDelta)
        self:OnLevelUp(level)
    end)
end

function Traveler:OnPlayerLeavingWorld()
    self:SerializeDatabase()
end

function Traveler:OnQuestAccepted(questId)
    self.State:OnQuestAccepted(questId)
    self.Journey:OnQuestAccepted(questId)
end

function Traveler:OnQuestCompleted(questId)
    self.State:OnQuestCompleted(questId)
    self.Journey:OnQuestCompleted(questId)
end

function Traveler:OnQuestTurnedIn(questId)
    self.State:OnQuestTurnedIn(questId)
    self.Journey:OnQuestTurnedIn(questId)
end

function Traveler:OnQuestAbandoned(questId)
    self.State:OnQuestAbandoned(questId)
    self.Journey:OnQuestAbandoned(questId)
end

function Traveler:OnHearthstoneBound(areaId)
    self.State:OnHearthstoneBound(areaId)
    self.Journey:OnHearthstoneBound(areaId)
end

function Traveler:OnHearthstoneUsed(areaId)
    self.State:OnHearthstoneUsed(areaId)
    self.Journey:OnHearthstoneUsed(areaId)
end

function Traveler:OnLevelUp(level)
    self.State:OnLevelUp(level)
    self.Journey:OnLevelUp(level)
end
