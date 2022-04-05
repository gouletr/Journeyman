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

    self:RegisterEvent("BAG_UPDATE_DELAYED", function(event)
        Journeyman.State:Update()
    end)

    self:RegisterEvent("PLAYER_LEVEL_UP", function(event, level, healthDelta, powerDelta, numNewTalents, numNewPvpTalentSlots, strengthDelta, agilityDelta, staminaDelta, intellectDelta)
        -- Delay level up so that it happens after quests turn-in
        C_Timer.After(2, function() self:OnLevelUp(level) end)
    end)

    self:RegisterEvent("PLAYER_XP_UPDATE", function(event, unit)
        if not Journeyman.db.char.window.show or Journeyman.State.steps == nil then
            return
        end

        local now = GetTimePreciseSec()

        local playerLevel = UnitLevel("player")
        local playerXP = UnitXP("player")
        for i = 1, #Journeyman.State.steps do
            local step = Journeyman.State.steps[i]
            if step and step.type == Journeyman.STEP_TYPE_REACH_LEVEL and not step.isComplete then
                if playerLevel == step.data.level and step.data.xp then
                    if playerXP >= step.data.xp then
                        self:OnLevelXPReached(step)
                    else
                        Journeyman.State:Update()
                    end
                elseif playerLevel == step.data.level - 1 then
                    Journeyman.State:Update()
                end
            end
        end

        local elapsed = (GetTimePreciseSec() - now) * 1000
        if elapsed > 1 then
            Journeyman:Debug("XP update took %.2fms", elapsed)
        end
    end)

    self:RegisterEvent("CONFIRM_BINDER", function(event, location)
        local areaId = Journeyman:GetAreaIdFromBindLocationLocalizedName(location)
        if areaId then
            self.bindAreaId = areaId
        else
            Journeyman:Error("Could not find areaId for bind location name '%s'.", location)
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
            local areaId = Journeyman:GetAreaIdFromBindLocationLocalizedName(GetBindLocation())
            if areaId then
                self:OnHearthstoneUsed(areaId)
            else
                Journeyman:Error("Could not find areaId for bind location name '%s'.", location)
            end
        end
    end)

    self:RegisterEvent("TAXIMAP_OPENED", function(event, uiMapSystem)
        if uiMapSystem == Enum.UIMapSystem.Taxi then
            self:OnTaxiMapOpened()
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
        if not InCombatLockdown() and Journeyman.db.char.window.show then
            if not UnitOnTaxi("player") then
                Journeyman.flyingTo = nil
            end
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
    self.Journey:OnQuestAccepted(questId)
    if self.db.char.window.show then
        self.State:OnQuestAccepted(questId)
    end
end

function Journeyman:OnQuestCompleted(questId)
    self.Journey:OnQuestCompleted(questId)
    if self.db.char.window.show then
        self.State:OnQuestCompleted(questId)
    end
end

function Journeyman:OnQuestObjectiveCompleted(questId, objectiveIndex)
    if self.db.char.window.show then
        self.State:OnQuestObjectiveCompleted(questId, objectiveIndex)
    end
end

function Journeyman:OnQuestTurnedIn(questId)
    self.Journey:OnQuestTurnedIn(questId)
    if self.db.char.window.show then
        self.State:OnQuestTurnedIn(questId)
    end
end

function Journeyman:OnQuestAbandoned(questId)
    self.Journey:OnQuestAbandoned(questId)
    if self.db.char.window.show then
        self.State:OnQuestAbandoned(questId)
    end
end

function Journeyman:OnLocationReached(location)
    if self.db.char.window.show then
        self.State:OnLocationReached(location)
    end
end

function Journeyman:OnLevelUp(level)
    self.Journey:OnLevelUp(level)
    if self.db.char.window.show then
        self.State:OnLevelUp(level)
    end
end

function Journeyman:OnLevelXPReached(step)
    if self.db.char.window.show then
        self.State:OnLevelXPReached(step)
    end
end

function Journeyman:OnHearthstoneBound(areaId)
    self.Journey:OnHearthstoneBound(areaId)
    if self.db.char.window.show then
        self.State:OnHearthstoneBound(areaId)
    end
end

function Journeyman:OnHearthstoneUsed(areaId)
    self.Journey:OnHearthstoneUsed(areaId)
    if self.db.char.window.show then
        self.State:OnHearthstoneUsed(areaId)
    end
end

function Journeyman:OnTaxiMapOpened()
    local taxiNodeCount = NumTaxiNodes()
    for i = 1, taxiNodeCount do
        local taxiNodeId = self:GetTaxiNodeId(i)
        if taxiNodeId then
            self.db.char.taxiNodeIds[taxiNodeId] = true
        end
    end
end

function Journeyman:OnLearnFlightPath(taxiNodeId)
    self.db.char.taxiNodeIds[taxiNodeId] = true
    self.Journey:OnLearnFlightPath(taxiNodeId)
    if self.db.char.window.show then
        self.State:OnLearnFlightPath(taxiNodeId)
    end
end
