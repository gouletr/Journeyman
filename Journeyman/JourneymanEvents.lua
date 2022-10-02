local addonName, addon = ...
local Journeyman = addon.Journeyman
local L = addon.Locale

local Journey = Journeyman.Journey
local State = Journeyman.State
local TaxiNodes = Journeyman.TaxiNodes
local String = LibStub("LibCollections-1.0").String
local List = LibStub("LibCollections-1.0").List
local HBD = LibStub("HereBeDragons-2.0")

function Journeyman:InitializeEvents()
    Journey = Journeyman.Journey
    State = Journeyman.State
    TaxiNodes = Journeyman.TaxiNodes

    self.questTurnedIn = {}
    self.questRemoved = {}

    self:RegisterEvent("PLAYER_LOGIN", function(event)
        self.skipZoneChanged = true
    end)

    -- self:RegisterEvent("PLAYER_LOGOUT", function(event)
        -- Do not try to serialize data here, its too late
    -- end)

    self:RegisterEvent("PLAYER_ENTERING_WORLD", function(event)
        self.worldLoaded = true
    end)

    self:RegisterEvent("PLAYER_LEAVING_WORLD", function(event)
        self.worldLoaded = false
        Journeyman:SerializeDatabase()
    end)

    self:RegisterEvent("ZONE_CHANGED", function(event)
        if self.skipZoneChanged then
            self.skipZoneChanged = nil
            return
        end
        if Journeyman:UpdatePosition() then
            Journeyman:OnAreaChanged()
        end
        Journeyman:Update()
    end)

    self:RegisterEvent("ZONE_CHANGED_NEW_AREA", function(event)
        if self.skipZoneChanged then
            self.skipZoneChanged = nil
            return
        end
        if Journeyman:UpdatePosition() then
            Journeyman:OnZoneChanged()
        end
        Journeyman:Update()
    end)

    self:RegisterEvent("ZONE_CHANGED_INDOORS", function(event)
        if self.skipZoneChanged then
            self.skipZoneChanged = nil
            return
        end
        if Journeyman:UpdatePosition() then
            Journeyman:OnAreaChanged()
        end
        Journeyman:Update()
    end)

    self:RegisterEvent("QUEST_ACCEPTED", function(event, questLogIndex, questId)
        self:OnQuestAccepted(questId)
    end)

    self:RegisterEvent("QUEST_TURNED_IN", function(event, questId, xpReward, moneyReward)
        self.questRemoved[questId] = nil
        self.questTurnedIn[questId] = true
        self:OnQuestTurnedIn(questId)
    end)

    self:RegisterEvent("QUEST_WATCH_UPDATE", function(event, questId)
        Journeyman:SetMacro(State.currentStep)
    end)

    self:RegisterEvent("QUEST_LOG_UPDATE", function(event)
        Journeyman:Update()
    end)

    self:RegisterEvent("QUEST_REMOVED", function(event, questId)
        if not self.questTurnedIn[questId] then
            self.questRemoved[questId] = true
            -- Check later if quest was turned-in
            C_Timer.After(1, function()
                if self.questTurnedIn[questId] then
                    self.questTurnedIn[questId] = nil
                elseif self.questRemoved[questId] then
                    self:OnQuestAbandoned(questId)
                    self.questRemoved[questId] = nil
                end
            end)
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
        if not Journeyman.db.char.window.show or State.steps == nil then
            return
        end

        -- Store some values
        local xp = UnitXP("player")
        Journeyman.player.level = UnitLevel("player")
        Journeyman.player.xp = xp
        Journeyman.player.maxXP = UnitXPMax("player")
        Journeyman.player.greenRange = GetQuestGreenRange("player")

        List:ForEach(State.steps, function(step)
            if step.type == Journeyman.STEP_TYPE_REACH_LEVEL and not step.isComplete then
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
        end)
    end)

    self:RegisterEvent("CHAT_MSG_COMBAT_XP_GAIN", function(event, text, playerName, languageName, channelName, playerName2, specialFlags, zoneChannelID, channelIndex, channelBaseName, languageID, lineID, guid, bnSenderID, isMobile, isSubtitle, hideSenderInLetterbox, supressRaidIcons)
        local npcName, xpGained = string.match(text, L["REGEX_COMBAT_XP_GAIN"])
        if npcName and xpGained then
            npcName = String:Trim(npcName)
            xpGained = tonumber(xpGained)
            if xpGained and xpGained > 0 then
                Journeyman.player.xpGained = xpGained
            end
        end
    end)

    self:RegisterEvent("CHAT_MSG_COMBAT_FACTION_CHANGE", function(event, text, playerName, languageName, channelName, playerName2, specialFlags, zoneChannelID, channelIndex, channelBaseName, languageID, lineID, guid, bnSenderID, isMobile, isSubtitle, hideSenderInLetterbox, supressRaidIcons)
        local factionName, factionGained = string.match(text, L["REGEX_COMBAT_FACTION_CHANGE"])
        if factionName and factionGained then
            factionName = String:Trim(factionName)
            factionGained = tonumber(factionGained)
            local factionId = Journeyman:GetFactionId(factionName)
            if factionId and factionGained > 0 then
                Journeyman.player.factionGained[factionId] = factionGained
            end
        end
    end)

    self:RegisterEvent("UPDATE_FACTION", function(event)
        if not Journeyman.db.char.window.show or State.steps == nil then
            return
        end

        List:ForEach(State.steps, function(step)
            if step.type == Journeyman.STEP_TYPE_REACH_REPUTATION and not step.isComplete then
                local name, _, standingId = GetFactionInfoByID(step.data.factionId)
                if name and standingId and standingId >= step.data.standingId then
                    self:OnReputationReached(step)
                end
            end
        end)
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
            self.skipZoneChanged = true
            local areaId = Journeyman:GetAreaIdFromLocalizedName(GetBindLocation())
            if areaId then
                self:OnHearthstoneUsed(areaId)
            else
                Journeyman:Error("Could not find areaId for bind location name '%s'.", location)
            end
            self.lastSpellCast = nil
        end
        Journeyman:Update()
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
            State.waypointNeedUpdate = Journeyman.db.profile.autoSetWaypoint
            State.macroNeedUpdate = true
            Journeyman:Update()
        end
    end)

    self:RegisterEvent("TRAINER_SHOW", function(event)
        self.trainerOpen = true
    end)

    self:RegisterEvent("TRAINER_CLOSED", function(event)
        if self.trainerOpen then
            if IsTradeskillTrainer() then
                -- todo: profession trainer
            else
                self:OnClassTrainerClosed()
            end
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

function Journeyman:OnQuestAccepted(questId)
    if Journeyman:IsCharacterJourneyEnabled() and Journeyman.db.profile.myJourney.stepTypeAcceptQuest then
        Journey:OnQuestAccepted(questId)
    end
    if Journeyman.db.char.window.show then
        State:OnQuestAccepted(questId)
    end
end

function Journeyman:OnQuestCompleted(questId)
    if Journeyman:IsCharacterJourneyEnabled() and Journeyman.db.profile.myJourney.stepTypeCompleteQuest then
        Journey:OnQuestCompleted(questId)
    end
    if Journeyman.db.char.window.show then
        State:OnQuestCompleted(questId)
    end
end

function Journeyman:OnQuestObjectiveCompleted(questId, objectiveIndex)
    if Journeyman:IsCharacterJourneyEnabled() and Journeyman.db.profile.myJourney.stepTypeCompleteQuest then
        Journey:OnQuestObjectiveCompleted(questId, objectiveIndex)
    end
    if Journeyman.db.char.window.show then
        State:OnQuestObjectiveCompleted(questId, objectiveIndex)
    end
end

function Journeyman:OnQuestTurnedIn(questId)
    if Journeyman:IsCharacterJourneyEnabled() and Journeyman.db.profile.myJourney.stepTypeTurnInQuest then
        Journey:OnQuestTurnedIn(questId)
    end
    if Journeyman.db.char.window.show then
        State:OnQuestTurnedIn(questId)
    end
end

function Journeyman:OnQuestAbandoned(questId)
    if Journeyman:IsCharacterJourneyEnabled() and Journeyman.db.profile.myJourney.abandonedQuests then
        Journey:OnQuestAbandoned(questId)
    end
    if Journeyman.db.char.window.show then
        State:OnQuestAbandoned(questId)
    end
end

function Journeyman:OnZoneChanged()
    if Journeyman:IsCharacterJourneyEnabled() and Journeyman.db.profile.myJourney.stepTypeGoToZone then
        if Journeyman.player.location and not UnitOnTaxi("player") then
            Journey:OnZoneChanged(Journeyman.player.location)
        end
    end
    Journeyman:OnLocationChanged()
end

function Journeyman:OnAreaChanged()
    Journeyman:OnLocationChanged()
end

function Journeyman:OnLocationChanged()
    if Journeyman.db.char.window.show then
        if State.steps == nil then
            return
        end

        local location = Journeyman.player.location
        if location == nil then
            return
        end

        if UnitOnTaxi("player") then
            return
        end

        local playerAreaId = nil
        local step = State.currentStep
        if step and not step.isComplete and step.isShown then
            if step.type == Journeyman.STEP_TYPE_GO_TO_COORD then
                local distance = HBD:GetZoneDistance(location.mapId, location.x, location.y, step.data.mapId, step.data.x / 100.0, step.data.y / 100.0)
                if distance and distance <= 15 then
                    State:OnStepCompleted(step)
                end
            elseif step.type == Journeyman.STEP_TYPE_GO_TO_AREA then
                if playerAreaId == nil then
                    playerAreaId = Journeyman:GetPlayerAreaId()
                end
                if playerAreaId and playerAreaId == step.data.areaId then
                    State:OnStepCompleted(step)
                end
            elseif step.type == Journeyman.STEP_TYPE_GO_TO_ZONE then
                if location.mapId == step.data.mapId then
                    State:OnStepCompleted(step)
                end
            end
        end
    end
end

function Journeyman:OnLevelUp(level)
    if Journeyman:IsCharacterJourneyEnabled() and Journeyman.db.profile.myJourney.stepTypeReachLevel then
        Journey:OnLevelUp(level)
    end
    if Journeyman.db.char.window.show then
        State:OnLevelUp(level)
    end
end

function Journeyman:OnLevelXPReached(step)
    if Journeyman.db.char.window.show then
        State:OnLevelXPReached(step)
    end
end

function Journeyman:OnReputationReached(step)
    if Journeyman.db.char.window.show then
        State:OnReputationReached(step)
    end
end

function Journeyman:OnHearthstoneBound(areaId)
    if Journeyman:IsCharacterJourneyEnabled() and Journeyman.db.profile.myJourney.stepTypeBindHearthstone then
        Journey:OnHearthstoneBound(areaId)
    end
    if Journeyman.db.char.window.show then
        State:OnHearthstoneBound(areaId)
    end
end

function Journeyman:OnHearthstoneUsed(areaId)
    if Journeyman:IsCharacterJourneyEnabled() and Journeyman.db.profile.myJourney.stepTypeUseHearthstone then
        Journey:OnHearthstoneUsed(areaId)
    end
    if Journeyman.db.char.window.show then
        State:OnHearthstoneUsed(areaId)
    end
end

function Journeyman:OnTaxiMapOpened()
    local taxiNodeCount = NumTaxiNodes()
    for i = 1, taxiNodeCount do
        local taxiNodeId = TaxiNodes:GetTaxiNodeIdFromSlot(i)
        if taxiNodeId then
            Journeyman.db.char.taxiNodeIds[taxiNodeId] = true
        end
    end
end

function Journeyman:OnLearnFlightPath(taxiNodeId)
    Journeyman.db.char.taxiNodeIds[taxiNodeId] = true
    if Journeyman:IsCharacterJourneyEnabled() and Journeyman.db.profile.myJourney.stepTypeLearnFlightPath then
        Journey:OnLearnFlightPath(taxiNodeId)
    end
    if Journeyman.db.char.window.show then
        State:OnLearnFlightPath(taxiNodeId)
    end
end

function Journeyman:OnClassTrainerClosed()
    if Journeyman:IsCharacterJourneyEnabled() and Journeyman.db.profile.myJourney.stepTypeTrainClass then
        Journey:OnClassTrainerClosed()
    end
    if Journeyman.db.char.window.show then
        State:OnClassTrainerClosed()
    end
end

function Journeyman:OnSpellLearned(spellId)
    if Journeyman:IsCharacterJourneyEnabled() and Journeyman.db.profile.myJourney.stepTypeTrainSpells then
        Journey:OnSpellLearned(spellId)
    end
    if Journeyman.db.char.window.show then
        State:OnSpellLearned(spellId)
    end
end

function Journeyman:OnSpellCast(spellId)
    if Journeyman.db.char.window.show then
        State:OnSpellCast(spellId)
    end
end

function Journeyman:OnSpiritResurrection()
    if Journeyman:IsCharacterJourneyEnabled() and Journeyman.db.profile.myJourney.stepTypeDieAndRes then
        Journey:OnSpiritResurrection()
    end
    if Journeyman.db.char.window.show then
        State:OnSpiritResurrection()
    end
end
