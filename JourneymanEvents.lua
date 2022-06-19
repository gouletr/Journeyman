local addonName, addon = ...
local Journeyman = addon.Journeyman
local L = addon.Locale
local HBD = LibStub("HereBeDragons-2.0")

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

    self:RegisterEvent("ZONE_CHANGED", function(event)
        if Journeyman:UpdatePosition() then
            Journeyman:OnLocationChanged()
        end
        Journeyman:Update()
    end)

    self:RegisterEvent("ZONE_CHANGED_NEW_AREA", function(event)
        if Journeyman:UpdatePosition() then
            Journeyman:OnLocationChanged()
        end
        Journeyman:Update()
    end)

    self:RegisterEvent("ZONE_CHANGED_INDOORS", function(event)
        if Journeyman:UpdatePosition() then
            Journeyman:OnLocationChanged()
        end
        Journeyman:Update()
    end)

    self:RegisterEvent("QUEST_ACCEPTED", function(event, questLogIndex, questId)
        self:OnQuestAccepted(questId)
    end)

    self:RegisterEvent("QUEST_TURNED_IN", function(event, questId)
        self.questTurnedIn[questId] = true
        self:OnQuestTurnedIn(questId)
    end)

    self:RegisterEvent("QUEST_WATCH_UPDATE", function(event, questId)
        Journeyman:SetMacro(Journeyman.State.currentStep)
    end)

    self:RegisterEvent("QUEST_LOG_UPDATE", function(event)
        Journeyman:Update()
    end)

    self:RegisterEvent("QUEST_REMOVED", function(event, questId)
        if self.questTurnedIn[questId] == nil then
           self:OnQuestAbandoned(questId)
        else
            self.questTurnedIn[questId] = nil
        end
    end)

    self:RegisterEvent("BAG_UPDATE_DELAYED", function(event)
        Journeyman:Update()
    end)

    self:RegisterEvent("PLAYER_LEVEL_UP", function(event, level, healthDelta, powerDelta, numNewTalents, numNewPvpTalentSlots, strengthDelta, agilityDelta, staminaDelta, intellectDelta)
        -- Delay level up so that it happens after quests turn-in
        C_Timer.After(1, function() self:OnLevelUp(level) end)
    end)

    self:RegisterEvent("PLAYER_XP_UPDATE", function(event, unit)
        if not Journeyman.db.char.window.show or Journeyman.State.steps == nil then
            return
        end

        -- Store some values
        local xp = UnitXP("player")
        Journeyman.player.level = UnitLevel("player")
        Journeyman.player.lastXP = Journeyman.player.xp
        Journeyman.player.xp = xp
        Journeyman.player.maxXP = UnitXPMax("player")
        Journeyman.player.greenRange = GetQuestGreenRange("player")

        for i = 1, #Journeyman.State.steps do
            local step = Journeyman.State.steps[i]
            if step and step.type == Journeyman.STEP_TYPE_REACH_LEVEL and not step.isComplete then
                if Journeyman.player.level == step.data.level and step.data.xp then
                    if Journeyman.player.xp >= step.data.xp then
                        self:OnLevelXPReached(step)
                    else
                        Journeyman:Update()
                    end
                elseif Journeyman.player.level == step.data.level - 1 then
                    Journeyman:Update()
                end
            end
        end
    end)

    self:RegisterEvent("CONFIRM_BINDER", function(event, location)
        local areaId = Journeyman:GetAreaIdFromLocalizedName(location)
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

    self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED", function(event, unitTarget, castGUID, spellId)
        if spellId == Journeyman.SPELL_HEARTHSTONE or spellId == Journeyman.SPELL_ASTRAL_RECALL then
            self.lastSpellCast = spellId
        else
            self:OnSpellCast(spellId)
        end
    end)

    self:RegisterEvent("LOADING_SCREEN_DISABLED", function(event)
        if self.lastSpellCast == Journeyman.SPELL_HEARTHSTONE or self.lastSpellCast == Journeyman.SPELL_ASTRAL_RECALL then
            local areaId = Journeyman:GetAreaIdFromLocalizedName(GetBindLocation())
            if areaId then
                self:OnHearthstoneUsed(areaId)
            else
                Journeyman:Error("Could not find areaId for bind location name '%s'.", location)
            end
            self.lastSpellCast = nil
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
        if Journeyman.db.char.window.show and not InCombatLockdown() then
            if not UnitOnTaxi("player") then
                Journeyman.flyingTo = nil
            end
            Journeyman.State.waypointNeedUpdate = Journeyman.db.profile.autoSetWaypoint
            Journeyman.State.macroNeedUpdate = true
            Journeyman:Update()
        end
    end)

    self:RegisterEvent("TRAINER_SHOW", function(event)
        self.trainerOpen = true
    end)

    self:RegisterEvent("TRAINER_CLOSED", function(event)
        if self.trainerOpen then
            self:OnTrainerClosed()
            self.trainerOpen = nil
        end
    end)

    self:RegisterEvent("LEARNED_SPELL_IN_TAB", function(event, spellId, skillInfoIndex, isGuildPerkSpell)
        self:OnSpellLearned(spellId)
    end)

    self:RegisterEvent("SKILL_LINES_CHANGED", function(event)
        Journeyman:Update()
    end)

    self:RegisterEvent("CONFIRM_XP_LOSS", function(event)
        self.confirmXPLoss = true
    end)

    self:RegisterEvent("PLAYER_UNGHOST", function(event)
        if self.confirmXPLoss then
            self:OnSpiritResurrection()
            self.confirmXPLoss = nil
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

function Journeyman:OnLocationChanged()
    if self.db.char.window.show then
        if Journeyman.State.steps == nil then
            return
        end

        local location = self.player.location
        if location == nil then
            return
        end

        if UnitOnTaxi("player") then
            return
        end

        local playerAreaId = nil
        for i = 1, #Journeyman.State.steps do
            local step = Journeyman.State.steps[i]
            if step and not step.isComplete and step.isShown then
                if step.type == Journeyman.STEP_TYPE_GO_TO_COORD then
                    local distance = HBD:GetZoneDistance(location.mapId, location.x, location.y, step.data.mapId, step.data.x / 100.0, step.data.y / 100.0)
                    if distance and distance <= 15 then
                        self.State:OnStepCompleted(step)
                    end
                elseif step.type == Journeyman.STEP_TYPE_GO_TO_AREA then
                    if playerAreaId == nil then
                        playerAreaId = Journeyman:GetPlayerAreaId()
                    end
                    if playerAreaId and playerAreaId == step.data.areaId then
                        self.State:OnStepCompleted(step)
                    end
                elseif step.type == Journeyman.STEP_TYPE_GO_TO_ZONE then
                    if location.mapId == step.data.mapId then
                        self.State:OnStepCompleted(step)
                    end
                end
            end
        end
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

function Journeyman:OnTrainerClosed()
    self.Journey:OnTrainerClosed()
    if self.db.char.window.show then
        self.State:OnTrainerClosed()
    end
end

function Journeyman:OnSpellLearned(spellId)
    if self.db.char.window.show then
        self.State:OnSpellLearned(spellId)
    end
end

function Journeyman:OnSpellCast(spellId)
    if self.db.char.window.show then
        self.State:OnSpellCast(spellId)
    end
end

function Journeyman:OnSpiritResurrection()
    if self.db.char.window.show then
        self.State:OnSpiritResurrection()
    end
end
