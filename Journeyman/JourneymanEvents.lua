local addonName, addon = ...
local Events, Private = addon:NewModule("Events", "AceEvent-3.0"), {}
local L = addon.Locale

local String = LibStub("LibCollections-1.0").String
local List = LibStub("LibCollections-1.0").List
local HBD = LibStub("HereBeDragons-2.0")
local Database, DataSource, Journey, State, TaxiNodes

function Events:OnInitialize()
    Database = addon.Database
    DataSource = addon.DataSource
    Journey = addon.Journey
    State = addon.State
    TaxiNodes = addon.TaxiNodes
    self.questTurnedIn = {}
    self.questRemoved = {}
end

function Events:OnEnable()
    self:RegisterEvent("PLAYER_LOGIN", function(event)
        self.skipZoneChanged = true
    end)

    -- self:RegisterEvent("PLAYER_LOGOUT", function(event)
        -- Do not try to serialize data here, its too late
    -- end)

    self:RegisterEvent("PLAYER_ENTERING_WORLD", function(event)
        addon.worldLoaded = true
    end)

    self:RegisterEvent("PLAYER_LEAVING_WORLD", function(event)
        addon.worldLoaded = false
        Database:SerializeDatabase()
    end)

    self:RegisterEvent("ZONE_CHANGED", function(event)
        if self.skipZoneChanged then
            self.skipZoneChanged = nil
            return
        end
        if addon:UpdatePosition() then
            self:OnAreaChanged()
        end
        addon:Update()
    end)

    self:RegisterEvent("ZONE_CHANGED_NEW_AREA", function(event)
        if self.skipZoneChanged then
            self.skipZoneChanged = nil
            return
        end
        if addon:UpdatePosition() then
            self:OnZoneChanged()
        end
        addon:Update()
    end)

    self:RegisterEvent("ZONE_CHANGED_INDOORS", function(event)
        if self.skipZoneChanged then
            self.skipZoneChanged = nil
            return
        end
        if addon:UpdatePosition() then
            self:OnAreaChanged()
        end
        addon:Update()
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
        addon:SetMacro(State.currentStep)
    end)

    self:RegisterEvent("QUEST_LOG_UPDATE", function(event)
        addon:Update()
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
        addon:Update()
    end)

    self:RegisterEvent("PLAYER_LEVEL_UP", function(event, level, healthDelta, powerDelta, numNewTalents, numNewPvpTalentSlots, strengthDelta, agilityDelta, staminaDelta, intellectDelta)
        -- Store some values
        addon.player.level = UnitLevel("player")
        addon.player.xp = UnitXP("player")
        addon.player.maxXP = UnitXPMax("player")
        addon.player.greenRange = GetQuestGreenRange("player")

        -- Delay level up so that it happens after quests turn-in
        C_Timer.After(1, function() self:OnLevelUp(level) end)
    end)

    self:RegisterEvent("PLAYER_XP_UPDATE", function(event, unit)
        -- Store some values
        addon.player.level = UnitLevel("player")
        addon.player.xp = UnitXP("player")
        addon.player.maxXP = UnitXPMax("player")
        addon.player.greenRange = GetQuestGreenRange("player")

        if State.steps then
            List:ForEach(State.steps, function(step)
                if step.type == addon.STEP_TYPE_REACH_LEVEL and not step.isComplete then
                    if addon.player.level == step.data.level and step.data.xp then
                        if addon.player.xp >= step.data.xp then
                            self:OnLevelXPReached(step)
                        else
                            addon:Update()
                        end
                    elseif addon.player.level == step.data.level - 1 then
                        addon:Update()
                    end
                end
            end)
        end
    end)

    self:RegisterEvent("CHAT_MSG_COMBAT_XP_GAIN", function(event, text, playerName, languageName, channelName, playerName2, specialFlags, zoneChannelID, channelIndex, channelBaseName, languageID, lineID, guid, bnSenderID, isMobile, isSubtitle, hideSenderInLetterbox, supressRaidIcons)
        local npcName, xpGained = string.match(text, L["REGEX_COMBAT_XP_GAIN"])
        if npcName and xpGained then
            npcName = String:Trim(npcName)
            xpGained = tonumber(xpGained)
            if xpGained and xpGained > 0 then
                addon.player.xpGained = xpGained
            end
        end
    end)

    self:RegisterEvent("CHAT_MSG_COMBAT_FACTION_CHANGE", function(event, text, playerName, languageName, channelName, playerName2, specialFlags, zoneChannelID, channelIndex, channelBaseName, languageID, lineID, guid, bnSenderID, isMobile, isSubtitle, hideSenderInLetterbox, supressRaidIcons)
        local factionName, factionGained = string.match(text, L["REGEX_COMBAT_FACTION_CHANGE"])
        if factionName and factionGained then
            factionName = String:Trim(factionName)
            factionGained = tonumber(factionGained)
            local factionId = addon:GetFactionId(factionName)
            if factionId and factionGained > 0 then
                addon.player.factionGained[factionId] = factionGained
            end
        end
    end)

    self:RegisterEvent("UPDATE_FACTION", function(event)
        if not addon.db.char.window.show or State.steps == nil then
            return
        end

        List:ForEach(State.steps, function(step)
            if step.type == addon.STEP_TYPE_REACH_REPUTATION and not step.isComplete then
                local name, _, standingId = GetFactionInfoByID(step.data.factionId)
                if name and standingId and standingId >= step.data.standingId then
                    self:OnReputationReached(step)
                end
            end
        end)
    end)

    self:RegisterEvent("CONFIRM_BINDER", function(event, location)
        local areaId = addon:GetAreaIdFromLocalizedName(location)
        if areaId then
            self.bindAreaId = areaId
        else
            addon:Error("Could not find areaId for bind location name '%s'.", location)
        end
    end)

    self:RegisterEvent("HEARTHSTONE_BOUND", function(event)
        if self.bindAreaId then
            self:OnHearthstoneBound(self.bindAreaId)
            self.bindAreaId = nil
        end
    end)

    self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED", function(event, unitTarget, castGUID, spellId)
        if spellId == addon.SPELL_HEARTHSTONE or spellId == addon.SPELL_ASTRAL_RECALL then
            self.lastSpellCast = spellId
        else
            self:OnSpellCast(spellId)
        end
    end)

    self:RegisterEvent("LOADING_SCREEN_DISABLED", function(event)
        if self.lastSpellCast == addon.SPELL_HEARTHSTONE or self.lastSpellCast == addon.SPELL_ASTRAL_RECALL then
            self.skipZoneChanged = true
            local areaId = addon:GetAreaIdFromLocalizedName(GetBindLocation())
            if areaId then
                self:OnHearthstoneUsed(areaId)
            else
                addon:Error("Could not find areaId for bind location name '%s'.", location)
            end
            self.lastSpellCast = nil
        end
        addon:Update()
    end)

    self:RegisterEvent("TAXIMAP_OPENED", function(event, uiMapSystem)
        if uiMapSystem == Enum.UIMapSystem.Taxi then
            self:OnTaxiMapOpened()
        end
    end)

    self:RegisterEvent("UI_INFO_MESSAGE", function(event, errorType, message)
        if message == ERR_NEWTAXIPATH then
            local location = DataSource:GetNearestFlightMasterLocation()
            if location then
                local taxiNodeId = DataSource:GetNPCTaxiNodeId(location.id)
                if taxiNodeId then
                    self:OnLearnFlightPath(taxiNodeId)
                else
                    addon:Error("Could not find taxiNodeId for npcId %d.", location.id)
                end
            else
                addon:Error("Could not find nearest flight master location.")
            end
        end
    end)

    self:RegisterEvent("PLAYER_CONTROL_GAINED", function(event)
        if addon.db.char.window.show and not InCombatLockdown() then
            if not UnitOnTaxi("player") then
                addon.flyingTo = nil
            end
            State.waypointNeedUpdate = addon.db.profile.autoSetWaypoint
            State.macroNeedUpdate = true
            addon:Update()
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
        addon:Update()
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

function Events:OnDisable()
    --self:UnregisterAllEvents()
end

function Events:OnQuestAccepted(questId)
    if addon:IsMyJourneyEnabled() and addon.db.profile.myJourney.stepTypeAcceptQuest then
        Journey:OnQuestAccepted(questId)
    end
    if addon.db.char.window.show then
        State:OnQuestAccepted(questId)
    end
end

function Events:OnQuestCompleted(questId)
    if addon:IsMyJourneyEnabled() and addon.db.profile.myJourney.stepTypeCompleteQuest then
        Journey:OnQuestCompleted(questId)
    end
    if addon.db.char.window.show then
        State:OnQuestCompleted(questId)
    end
end

function Events:OnQuestObjectiveCompleted(questId, objectiveIndex)
    if addon:IsMyJourneyEnabled() and addon.db.profile.myJourney.stepTypeCompleteQuest then
        Journey:OnQuestObjectiveCompleted(questId, objectiveIndex)
    end
    if addon.db.char.window.show then
        State:OnQuestObjectiveCompleted(questId, objectiveIndex)
    end
end

function Events:OnQuestTurnedIn(questId)
    if addon:IsMyJourneyEnabled() and addon.db.profile.myJourney.stepTypeTurnInQuest then
        Journey:OnQuestTurnedIn(questId)
    end
    if addon.db.char.window.show then
        State:OnQuestTurnedIn(questId)
    end
end

function Events:OnQuestAbandoned(questId)
    if addon:IsMyJourneyEnabled() and addon.db.profile.myJourney.abandonedQuests then
        Journey:OnQuestAbandoned(questId)
    end
    if addon.db.char.window.show then
        State:OnQuestAbandoned(questId)
    end
end

function Events:OnZoneChanged()
    if addon:IsMyJourneyEnabled() and addon.db.profile.myJourney.stepTypeGoToZone then
        if addon.player.location and not UnitOnTaxi("player") then
            Journey:OnZoneChanged(addon.player.location)
        end
    end
    self:OnLocationChanged()
end

function Events:OnAreaChanged()
    self:OnLocationChanged()
end

function Events:OnLocationChanged()
    if addon.db.char.window.show then
        if State.steps == nil then
            return
        end

        local location = addon.player.location
        if location == nil then
            return
        end

        if UnitOnTaxi("player") then
            return
        end

        local playerAreaId = nil
        local step = State.currentStep
        if step and not step.isComplete and step.isShown then
            if step.type == addon.STEP_TYPE_GO_TO_COORD then
                local distance = HBD:GetZoneDistance(location.mapId, location.x, location.y, step.data.mapId, step.data.x / 100.0, step.data.y / 100.0)
                if distance and distance <= 15 then
                    State:OnStepCompleted(step)
                end
            elseif step.type == addon.STEP_TYPE_GO_TO_AREA then
                if playerAreaId == nil then
                    playerAreaId = addon:GetPlayerAreaId()
                end
                if playerAreaId and playerAreaId == step.data.areaId then
                    State:OnStepCompleted(step)
                end
            elseif step.type == addon.STEP_TYPE_GO_TO_ZONE then
                if location.mapId == step.data.mapId then
                    State:OnStepCompleted(step)
                end
            end
        end
    end
end

function Events:OnLevelUp(level)
    if addon:IsMyJourneyEnabled() and addon.db.profile.myJourney.stepTypeReachLevel then
        Journey:OnLevelUp(level)
    end
    if addon.db.char.window.show then
        State:OnLevelUp(level)
    end
end

function Events:OnLevelXPReached(step)
    if addon.db.char.window.show then
        State:OnLevelXPReached(step)
    end
end

function Events:OnReputationReached(step)
    if addon.db.char.window.show then
        State:OnReputationReached(step)
    end
end

function Events:OnHearthstoneBound(areaId)
    if addon:IsMyJourneyEnabled() and addon.db.profile.myJourney.stepTypeBindHearthstone then
        Journey:OnHearthstoneBound(areaId)
    end
    if addon.db.char.window.show then
        State:OnHearthstoneBound(areaId)
    end
end

function Events:OnHearthstoneUsed(areaId)
    if addon:IsMyJourneyEnabled() and addon.db.profile.myJourney.stepTypeUseHearthstone then
        Journey:OnHearthstoneUsed(areaId)
    end
    if addon.db.char.window.show then
        State:OnHearthstoneUsed(areaId)
    end
end

function Events:OnTaxiMapOpened()
    local taxiNodeCount = NumTaxiNodes()
    for i = 1, taxiNodeCount do
        local taxiNodeId = TaxiNodes:GetTaxiNodeIdFromSlot(i)
        if taxiNodeId then
            addon.db.char.taxiNodeIds[taxiNodeId] = true
        end
    end
end

function Events:OnLearnFlightPath(taxiNodeId)
    addon.db.char.taxiNodeIds[taxiNodeId] = true
    if addon:IsMyJourneyEnabled() and addon.db.profile.myJourney.stepTypeLearnFlightPath then
        Journey:OnLearnFlightPath(taxiNodeId)
    end
    if addon.db.char.window.show then
        State:OnLearnFlightPath(taxiNodeId)
    end
end

function Events:OnClassTrainerClosed()
    if addon:IsMyJourneyEnabled() and addon.db.profile.myJourney.stepTypeTrainClass then
        Journey:OnClassTrainerClosed()
    end
    if addon.db.char.window.show then
        State:OnClassTrainerClosed()
    end
end

function Events:OnSpellLearned(spellId)
    if addon:IsMyJourneyEnabled() and addon.db.profile.myJourney.stepTypeTrainSpells then
        Journey:OnSpellLearned(spellId)
    end
    if addon.db.char.window.show then
        State:OnSpellLearned(spellId)
    end
end

function Events:OnSpellCast(spellId)
    if addon.db.char.window.show then
        State:OnSpellCast(spellId)
    end
end

function Events:OnSpiritResurrection()
    if addon:IsMyJourneyEnabled() and addon.db.profile.myJourney.stepTypeDieAndRes then
        Journey:OnSpiritResurrection()
    end
    if addon.db.char.window.show then
        State:OnSpiritResurrection()
    end
end
