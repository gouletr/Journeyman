local addonName, addon = ...
local Journeyman = addon.Journeyman
local L = addon.Locale

function Journeyman:InitializeEvents()
    self.questTurnedIn = {}

    -- This is too late to serialize data, doesn't work
    -- self:RegisterEvent("PLAYER_LOGOUT", function(event)
        -- self:SerializeDatabase()
    -- end)

    self:RegisterEvent("PLAYER_ENTERING_WORLD", function(event)
        Journeyman.worldLoaded = true
    end)

    self:RegisterEvent("PLAYER_LEAVING_WORLD", function(event)
        Journeyman.worldLoaded = false
        self:SerializeDatabase()
    end)

    self:RegisterEvent("PLAYER_REGEN_ENABLED", function(event)
        if Journeyman.macroNeedUpdate then
            Journeyman:SetMacro()
        end
    end)

    self:RegisterEvent("QUEST_ACCEPTED", function(event, questLogIndex, questId)
        self:OnQuestAccepted(questId)
    end)

    self:RegisterEvent("QUEST_TURNED_IN", function(event, questId)
        self.questTurnedIn[questId] = true
        self:OnQuestTurnedIn(questId)
    end)

    self:RegisterEvent("QUEST_WATCH_UPDATE", function(event, questId)
        Journeyman:UpdateMacro()
    end)

    self:RegisterEvent("QUEST_LOG_UPDATE", function(event)
        Journeyman.State:Update()
    end)

    self:RegisterEvent("QUEST_REMOVED", function(event, questId)
        if self.questTurnedIn[questId] == nil then
           self:OnQuestAbandoned(questId)
        else
            self.questTurnedIn[questId] = nil
        end
    end)

    self:RegisterEvent("PLAYER_LEVEL_UP", function(event, level, healthDelta, powerDelta, numNewTalents, numNewPvpTalentSlots, strengthDelta, agilityDelta, staminaDelta, intellectDelta)
        -- Delay level up so that it happens after quests turn-in
        C_Timer.After(2, function() self:OnLevelUp(level) end)
    end)

    self:RegisterEvent("CONFIRM_BINDER", function(event, location)
        local areaId = Journeyman:GetAreaIdFromLocalizedName(location)
        if areaId then
            self.bindAreaId = areaId
        else
            Journeyman:Error("Could not find areaId for location name '%s'.", location)
        end
    end)

    self:RegisterEvent("HEARTHSTONE_BOUND", function(event)
        if self.bindAreaId then
            self:OnHearthstoneBound(self.bindAreaId)
            self.bindAreaId = nil
        end
    end)

    self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED", function(event, unitTarget, castGUID, spellID)
        if spellID == Journeyman.SPELL_HEARTHSTONE or spellID == Journeyman.SPELL_ASTRAL_RECALL then
            local areaId = Journeyman:GetAreaIdFromLocalizedName(GetBindLocation())
            if areaId then
                self:OnHearthstoneUsed(areaId)
            else
                Journeyman:Error("Could not find areaId for location name '%s'.", location)
            end
        end
    end)

    self:RegisterEvent("UI_INFO_MESSAGE", function(event, errorType, message)
        if message == ERR_NEWTAXIPATH then
            local location = Journeyman.DataSource:GetNearestFlightMasterLocation()
            if location then
                local taxiNodeId = Journeyman.DataSource:GetNPCTaxiNodeId(location.id)
                if taxiNodeId then
                    self:OnLearnFlightPath(taxiNodeId)
                else
                    Journeyman:Error("Could not find taxiNodeId for npcId %d.", location.id)
                end
            else
                Journeyman:Error("Could not find nearest flight master location.")
            end
        end
    end)

    self:RegisterEvent("PLAYER_CONTROL_GAINED", function(event)
        if not InCombatLockdown() then
            Journeyman:UpdateWaypoint()
            Journeyman:UpdateMacro()
            Journeyman:Update()
        end
    end)
end

function Journeyman:ShutdownEvents()
    self:UnregisterAllEvents()
end

function Journeyman:OnPlayerLeavingWorld()
    self:SerializeDatabase()
end

function Journeyman:OnQuestAccepted(questId)
    self.State:OnQuestAccepted(questId)
    self.Journey:OnQuestAccepted(questId)
end

function Journeyman:OnQuestCompleted(questId)
    self.State:OnQuestCompleted(questId)
    self.Journey:OnQuestCompleted(questId)
end

function Journeyman:OnQuestTurnedIn(questId)
    self.State:OnQuestTurnedIn(questId)
    self.Journey:OnQuestTurnedIn(questId)
end

function Journeyman:OnQuestAbandoned(questId)
    self.State:OnQuestAbandoned(questId)
    self.Journey:OnQuestAbandoned(questId)
end

function Journeyman:OnLearnFlightPath(areaId)
    self.State:OnLearnFlightPath(areaId)
    self.Journey:OnLearnFlightPath(areaId)
end

function Journeyman:OnHearthstoneBound(areaId)
    self.State:OnHearthstoneBound(areaId)
    self.Journey:OnHearthstoneBound(areaId)
end

function Journeyman:OnHearthstoneUsed(areaId)
    self.State:OnHearthstoneUsed(areaId)
    self.Journey:OnHearthstoneUsed(areaId)
end

function Journeyman:OnLevelUp(level)
    self.State:OnLevelUp(level)
    self.Journey:OnLevelUp(level)
end
