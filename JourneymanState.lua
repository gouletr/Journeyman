local addonName, addon = ...
local Journeyman = addon.Journeyman
local L = addon.Locale

local State = {}
Journeyman.State = State

local List = LibStub("LibCollections-1.0").List
local HBD = LibStub("HereBeDragons-2.0")

local function CompareStepData(step, data)
    if step.type == Journeyman.STEP_TYPE_ACCEPT_QUEST then
        return step.data.questId == data.questId
    elseif step.type == Journeyman.STEP_TYPE_COMPLETE_QUEST then
        if step.data.questId == data.questId then
            if step.data.objectives or data.objectives then
                if data.objectiveIndex then
                    return List:Contains(step.data.objectives, data.objectiveIndex)
                else
                    return true -- If no objectiveIndex, it means quest complete event triggered early
                end
            else
                return true
            end
        end
        return false
    elseif step.type == Journeyman.STEP_TYPE_TURNIN_QUEST then
        return step.data.questId == data.questId
    elseif step.type == Journeyman.STEP_TYPE_GO_TO_COORD then
        return step.data.mapId == data.mapId and step.data.x == data.x and step.data.y == data.y
    elseif step.type == Journeyman.STEP_TYPE_GO_TO_ZONE then
        return step.data.mapId == data.mapId
    elseif step.type == Journeyman.STEP_TYPE_GO_TO_AREA then
        return step.data.areaId == data.areaId and step.data.x == data.x and step.data.y == data.y
    elseif step.type == Journeyman.STEP_TYPE_REACH_LEVEL then
        if step.data.level == data.level then
            if step.data.xp then
                return step.data.xp == data.xp
            else
                return true
            end
        end
        return false
    elseif step.type == Journeyman.STEP_TYPE_BIND_HEARTHSTONE or step.type == Journeyman.STEP_TYPE_USE_HEARTHSTONE then
        return step.data.areaId == data.areaId
    elseif step.type == Journeyman.STEP_TYPE_LEARN_FLIGHT_PATH or step.type == Journeyman.STEP_TYPE_FLY_TO then
        return step.data.taxiNodeId == data.taxiNodeId
    elseif step.type == Journeyman.STEP_TYPE_TRAIN_CLASS then
        return true
    elseif step.type == Journeyman.STEP_TYPE_TRAIN_SPELLS then
        return List:Contains(step.data.spells, data.spellId)
    elseif step.type == Journeyman.STEP_TYPE_LEARN_FIRST_AID then
        return true
    elseif step.type == Journeyman.STEP_TYPE_LEARN_COOKING then
        return true
    elseif step.type == Journeyman.STEP_TYPE_LEARN_FISHING then
        return true
    elseif step.type == Journeyman.STEP_TYPE_DIE_AND_RES then
        return true
    else
        Journeyman:Error("Step step.type %s not implemented.", step.step.type)
    end
end

local function FindStep(type, data)
    if not State.steps then
        return nil
    end

    if State.currentStep then
        local step = State.currentStep
        if step.type == type and CompareStepData(step, data) then
            if Journeyman:IsStepTypeUnique(step) or step.isComplete == false then
                return step
            end
        end
    end

    for i = 1, #State.steps do
        local step = State.steps[i]
        if step.type == type and CompareStepData(step, data) then
            if Journeyman:IsStepTypeUnique(step) or step.isComplete == false then
                return step
            end
        end
    end

    --Journeyman:Debug("Could not find step type=%s data=%s", dump(type), dump(data))
end

function State:Initialize()
end

function State:Shutdown()
end

function State:CheckForUpdate()
    if self.needUpdate or self.waypointNeedUpdate or self.macroNeedUpdate then
        self:UpdateImmediate()
    end
end

function State:Reset(immediate)
    self.waypointNeedUpdate = Journeyman.db.profile.autoSetWaypoint
    self.macroNeedUpdate = true
    self.steps = nil
    self:Update(immediate)
end

function State:Update(immediate)
    self.needUpdate = true
    if immediate then
        self:UpdateImmediate()
    end
end

function State:UpdateImmediate()
    if not Journeyman.worldLoaded or not Journeyman.DataSource:IsInitialized() then
        return
    end

    local now = GetTimePreciseSec()

    -- Store some values
    Journeyman.player.level = UnitLevel("player")
    Journeyman.player.xp = UnitXP("player")
    Journeyman.player.maxXP = UnitXPMax("player")
    Journeyman.player.greenRange = GetQuestGreenRange("player")

    -- Reset state
    self.currentStep = nil
    self.startedQuestChains = {}

    -- Clone steps
    if self.steps == nil then
        self.steps = {}
        local journey = Journeyman.Journey:GetActiveJourney()
        local chapter = Journeyman.Journey:GetActiveChapter(journey)
        if chapter and chapter.steps then
            local index = 1
            for i = 1, #chapter.steps do
                local step = chapter.steps[i]
                if step.type and step.type ~= Journeyman.STEP_TYPE_UNDEFINED and step.data then
                    local data = Journeyman:GetStepData(step)
                    if data then
                        local clonedStep = Journeyman.Utils:Clone(step)
                        clonedStep.data = data

                        local isAvailable, reason = self:IsStepAvailable(clonedStep)
                        if isAvailable then
                            clonedStep.index = index
                            clonedStep.originalIndex = i
                            clonedStep.isComplete = false
                            clonedStep.isCompleteOverride = false
                            clonedStep.isShown = true
                            self.steps[index] = clonedStep
                            index = index + 1
                        else
                            --Journeyman:Debug("Step %s %s not available: %s", step.type, step.data, reason)
                        end
                    end
                end
            end
        end
    end

    -- Update quest log
    local questLog = Journeyman:GetQuestLog()
    if questLog then
        if self.questLog then
            -- Compare new quest log with last
            for questId, questInfo in pairs(questLog) do
                local lastQuestInfo = self.questLog[questId]
                if lastQuestInfo then
                    -- Check if objectives got completed
                    for objectiveIndex, questObjective in ipairs(questInfo.objectives) do
                        local lastQuestObjective = lastQuestInfo.objectives[objectiveIndex]
                        if lastQuestObjective then
                            if questObjective.finished and not lastQuestObjective.finished then
                                Journeyman:OnQuestObjectiveCompleted(questId, objectiveIndex)
                            end
                        end
                    end
                    -- Check if quest got completed
                    if (questInfo.isComplete and not questInfo.isFailed) and (not lastQuestInfo.isComplete and not lastQuestInfo.isFailed) then
                        Journeyman:OnQuestCompleted(questId)
                    end
                end
            end
        end
        self.questLog = questLog
    end

    -- Update steps state
    local stepShownCount = 0
    if self.steps then
        for i = 1, #self.steps do
            local step = self.steps[i]

            -- Check if step is completed
            if step.isCompleteOverride then
                step.isComplete = true
            else
                local isComplete = self:IsStepComplete(step)
                if isComplete and not step.isComplete then
                    -- Step got completed without OnStepCompleted called
                    self.waypointNeedUpdate = Journeyman.db.profile.autoSetWaypoint
                    self.macroNeedUpdate = true
                end
                step.isComplete = isComplete
            end

            -- Check if step is shown
            if Journeyman.db.profile.window.stepsShown > 0 and stepShownCount >= Journeyman.db.profile.window.stepsShown then
                step.isShown = false
            else
                step.isShown = self:IsStepShown(step)
            end

            if not step.isComplete and step.isShown then
                -- Reset location for step that we will show
                step.location = nil

                -- Set current step
                if self.currentStep == nil then
                    self.currentStep = step
                end

                -- Count shown steps
                stepShownCount = stepShownCount + 1
            end
        end
    end
    self.needUpdate = false

    local elapsed = (GetTimePreciseSec() - now) * 1000
    if elapsed > 20 then
        Journeyman:Debug("State update took %.2fms", elapsed)
    end

    -- Update window, waypoint and macro immediate
    if Journeyman.db.char.window.show then
        Journeyman.Window:UpdateImmediate()
        if self.waypointNeedUpdate then
            if Journeyman:SetWaypoint(self.currentStep, false) then
                self.waypointNeedUpdate = false
            end
        end
        if self.macroNeedUpdate then
            if Journeyman:SetMacro(self.currentStep) then
                self.macroNeedUpdate = false
            end
        end
    end
end

function State:OnQuestAccepted(questId)
    local step = FindStep(Journeyman.STEP_TYPE_ACCEPT_QUEST, { questId = questId })
    if step then
        self:OnStepCompleted(step)
    end
end

function State:OnQuestCompleted(questId)
    local step = FindStep(Journeyman.STEP_TYPE_COMPLETE_QUEST, { questId = questId })
    if step then
        self:OnStepCompleted(step)
    end
end

function State:OnQuestObjectiveCompleted(questId, objectiveIndex)
    local step = FindStep(Journeyman.STEP_TYPE_COMPLETE_QUEST, { questId = questId, objectiveIndex = objectiveIndex })
    if step then
        if self:IsStepQuestObjectivesComplete(step) then
            self:OnStepCompleted(step)
        else
            self.waypointNeedUpdate = Journeyman.db.profile.autoSetWaypoint
            self.macroNeedUpdate = true
            Journeyman:Update()
        end
    end
end

function State:OnQuestTurnedIn(questId)
    local step = FindStep(Journeyman.STEP_TYPE_TURNIN_QUEST, { questId = questId })
    if step then
        if self.turnedInQuests == nil then
            self.turnedInQuests = {}
        end
        self.turnedInQuests[questId] = true
        self:OnStepCompleted(step)
    end
end

function State:OnQuestAbandoned(questId)
    -- Reset isCompleteOverride for all steps related to this quest
    if self.steps then
        for i = 1, #self.steps do
            local step = self.steps[i]
            if step and Journeyman:IsStepTypeQuest(step) and step.data.questId == questId then
                step.isCompleteOverride = false
            end
        end
    end
    Journeyman:Update()
end

function State:OnLevelUp(level)
    local step = FindStep(Journeyman.STEP_TYPE_REACH_LEVEL, { level = level })
    if step then
        self:OnStepCompleted(step)
    end
end

function State:OnLevelXPReached(step)
    self:OnStepCompleted(step)
end

function State:OnHearthstoneBound(areaId)
    local step = FindStep(Journeyman.STEP_TYPE_BIND_HEARTHSTONE, { areaId = areaId })
    if step then
        self:OnStepCompleted(step)
    end
end

function State:OnHearthstoneUsed(areaId)
    local step = FindStep(Journeyman.STEP_TYPE_USE_HEARTHSTONE, { areaId = areaId })
    if step then
        self:OnStepCompleted(step)
    end
end

function State:OnLearnFlightPath(taxiNodeId)
    local step = FindStep(Journeyman.STEP_TYPE_LEARN_FLIGHT_PATH, { taxiNodeId = taxiNodeId })
    if step then
        self:OnStepCompleted(step)
    end
end

function State:OnTakeFlightPath(taxiNodeId)
    local step = FindStep(Journeyman.STEP_TYPE_FLY_TO, { taxiNodeId = taxiNodeId })
    if step then
        self:OnStepCompleted(step)
    end
end

function State:OnTrainerClosed()
    local step = FindStep(Journeyman.STEP_TYPE_TRAIN_CLASS, {})
    if step then
        self:OnStepCompleted(step)
    end
end

function State:OnSpellLearned(spellId)
    local step = nil
    if spellId == Journeyman.SPELL_FIRST_AID_APPRENTICE then
        step = FindStep(Journeyman.STEP_TYPE_LEARN_FIRST_AID, {})
    elseif spellId == Journeyman.SPELL_COOKING_APPRENTICE then
        step = FindStep(Journeyman.STEP_TYPE_LEARN_COOKING, {})
    elseif spellId == Journeyman.SPELL_FISHING_APPRENTICE then
        step = FindStep(Journeyman.STEP_TYPE_LEARN_FISHING, {})
    else
        step = FindStep(Journeyman.STEP_TYPE_TRAIN_SPELLS, { spellId = spellId })
    end
    if step then
        self:OnStepCompleted(step)
    end
end

function State:OnSpellCast(spellId)
end

function State:OnSpiritResurrection()
    local step = FindStep(Journeyman.STEP_TYPE_DIE_AND_RES, {})
    if step then
        self:OnStepCompleted(step)
    end
end

function State:OnStepCompleted(step)
    self.waypointNeedUpdate = Journeyman.db.profile.autoSetWaypoint
    self.macroNeedUpdate = true

    -- Mark step as completed
    step.isCompleteOverride = true
    step.isComplete = true
    step.isShown = false

    if self:IsChapterComplete() then
        -- Advance chapter and reset state
        local journey = Journeyman.Journey:GetActiveJourney()
        if journey then
            Journeyman.Journey:AdvanceChapter(journey)
            Journeyman:Reset()
        end
    else
        Journeyman:Update()
    end
end

function State:IsStepAvailable(step)
    if Journeyman.db.char.hardcoreMode and step.type == Journeyman.STEP_TYPE_DIE_AND_RES then
        return false
    end

    if step.requiredRaces and bit.band(step.requiredRaces, Journeyman.player.raceMask) == 0 then
        return false
    end

    if step.requiredClasses and bit.band(step.requiredClasses, Journeyman.player.classMask) == 0 then
        return false
    end

    if Journeyman:IsStepTypeQuest(step) then
        return self:IsQuestAvailable(step.data.questId)
    end

    return true
end

function State:IsStepDoable(step)
    if Journeyman:IsStepTypeQuest(step) then
        return self:IsQuestDoable(step.data.questId, step.type == Journeyman.STEP_TYPE_COMPLETE_QUEST)
    elseif step.type == Journeyman.STEP_TYPE_BIND_HEARTHSTONE or step.type == Journeyman.STEP_TYPE_USE_HEARTHSTONE then
        return Journeyman.DataSource:GetNearestInnkeeperLocation(step.data.areaId) ~= nil
    elseif step.type == Journeyman.STEP_TYPE_LEARN_FLIGHT_PATH then
        return Journeyman:IsTaxiNodeAvailable(step.data.taxiNodeId)
    elseif step.type == Journeyman.STEP_TYPE_FLY_TO then
        return Journeyman:IsTaxiNodeAvailable(step.data.taxiNodeId) and Journeyman.db.char.taxiNodeIds[step.data.taxiNodeId] == true
    end
    return true
end

function State:IsStepShown(step)
    -- Check if step is completed, or if we show completed steps
    local showStep = not step.isComplete or Journeyman.db.profile.window.showCompletedSteps

    -- Additional checks if step is going to become current step
    if showStep and not step.isComplete and self.currentStep == nil then
        local doable, reason = self:IsStepDoable(step)
        if doable then
            if Journeyman:IsStepTypeQuest(step) then
                -- Additional checks if step is going to become current step
                local questId = step.data.questId
                if step.type == Journeyman.STEP_TYPE_COMPLETE_QUEST then
                    if not self:IsQuestInQuestLog(questId) then
                        -- Check if there's any objectives that can be completed even if quest is not in quest log
                        doable = self:IterateStepQuestObjectives(step, function(objective, objectiveIndex)
                            if not objective.finished then
                                return true
                            end
                        end)
                        if not doable then
                            return false, string.format("Quest %s not in quest log", questId)
                        end
                    end
                elseif step.type == Journeyman.STEP_TYPE_TURNIN_QUEST then
                    if Journeyman.DataSource:IsQuestRepeatable(questId) then
                        if not self:IsQuestObjectivesComplete(questId) then
                            doable, reason = false, string.format("Quest %s is not complete", questId)
                        end
                    else
                        if not self:IsQuestInQuestLogAndComplete(questId) then
                            doable, reason = false, string.format("Quest %s is not in quest log or not complete", questId)
                        end
                    end
                end
            end
        end

        if not doable then
            --Journeyman:Debug("Step %s %s is not doable: %s", step.type, dump(step.data), dump(reason))
        end

        showStep = doable -- Hide steps that are not doable
    end

    return showStep
end

function State:IsStepComplete(step)
    if Journeyman:IsStepTypeQuest(step) then
        local questId = step.data.questId

        -- Check if quest is already turned-in
        if self:IsQuestTurnedIn(questId) then
            return true
        end

        -- Check if quest is exclusive to some other quests
        local exclusiveToQuestIds = Journeyman.DataSource:GetQuestExclusiveTo(questId)
        if exclusiveToQuestIds ~= nil then
            -- Check if exclusive quest is in quest log or already turned-in
            if List:Any(exclusiveToQuestIds, function(exclusiveQuestId) return self:IsQuestInQuestLogOrTurnedIn(exclusiveQuestId) end) then
                return true -- Quest is unobtainable, consider complete
            end
        end

        -- Per quest step type checks
        if step.type == Journeyman.STEP_TYPE_ACCEPT_QUEST then
            -- Check if quest is in quest log
            if self:IsQuestInQuestLog(questId) then
                return true
            end
        elseif step.type == Journeyman.STEP_TYPE_COMPLETE_QUEST then
            if self:IsQuestInQuestLogAndComplete(questId) then -- Check if quest is in quest log and complete
                return true
            elseif self:IsStepQuestObjectivesComplete(step) then -- Check if quest objectives are all complete
                return true
            end
        elseif step.type == Journeyman.STEP_TYPE_TURNIN_QUEST then
            -- Check if quest is turned-in (redundancy)
            if self:IsQuestTurnedIn(questId) then
                return true
            end
        end

        -- Check if quest is repeatable
        if Journeyman.DataSource:IsQuestRepeatable(questId) then
            -- If next step is complete, consider this step complete
            local nextStep = self:GetNextStep(step)
            if nextStep then
                return nextStep.isCompleteOverride or self:IsStepComplete(nextStep)
            else
                return false
            end
        end

        -- Step is not complete
        return false
    else
        if step.type == Journeyman.STEP_TYPE_GO_TO_COORD then
            if Journeyman.player.location then
                local distance = HBD:GetZoneDistance(Journeyman.player.location.mapId, Journeyman.player.location.x, Journeyman.player.location.y, step.data.mapId, step.data.x / 100.0, step.data.y / 100.0)
                if distance and distance <= 15 then
                    return true
                end
            end
        elseif step.type == Journeyman.STEP_TYPE_GO_TO_ZONE then
            -- Can't verify
        elseif step.type == Journeyman.STEP_TYPE_GO_TO_AREA then
            -- Can't verify
        elseif step.type == Journeyman.STEP_TYPE_REACH_LEVEL then
            if step.data.xp then
                return Journeyman.player.level > step.data.level or (Journeyman.player.level == step.data.level and Journeyman.player.xp >= step.data.xp)
            else
                return Journeyman.player.level >= step.data.level
            end
        elseif step.type == Journeyman.STEP_TYPE_BIND_HEARTHSTONE then
            -- Check if current bind location match
            if GetBindLocation() == Journeyman:GetAreaNameById(step.data.areaId) then
                return true
            end
            -- Check if next bind step is complete
            local nextBindStep = self:GetNextStep(step, Journeyman.STEP_TYPE_BIND_HEARTHSTONE)
            if nextBindStep then
                return nextBindStep.isCompleteOverride or self:IsStepComplete(nextBindStep)
            end
            return false
        elseif step.type == Journeyman.STEP_TYPE_USE_HEARTHSTONE then
            -- Can't verify
        elseif step.type == Journeyman.STEP_TYPE_LEARN_FLIGHT_PATH then
            -- Check if taxiNodeId has been unlocked
            return Journeyman.db.char.taxiNodeIds[step.data.taxiNodeId] == true
        elseif step.type == Journeyman.STEP_TYPE_FLY_TO then
            -- Can't verify
        elseif step.type == Journeyman.STEP_TYPE_TRAIN_CLASS then
            -- Can't verify
        elseif step.type == Journeyman.STEP_TYPE_TRAIN_SPELLS then
            return List:All(step.data.spells, function(spellId) return Journeyman:IsSpellKnown(spellId) end)
        elseif step.type == Journeyman.STEP_TYPE_LEARN_FIRST_AID then
            return Journeyman:IsSpellKnown(Journeyman.SPELL_FIRST_AID_APPRENTICE)
        elseif step.type == Journeyman.STEP_TYPE_LEARN_COOKING then
            return Journeyman:IsSpellKnown(Journeyman.SPELL_COOKING_APPRENTICE)
        elseif step.type == Journeyman.STEP_TYPE_LEARN_FISHING then
            return Journeyman:IsSpellKnown(Journeyman.SPELL_FISHING_APPRENTICE)
        elseif step.type == Journeyman.STEP_TYPE_DIE_AND_RES then
            -- Can't verify
        end

        -- For step types that cannot be uniquely identified, check if next step is complete
        if not Journeyman:IsStepTypeUnique(step) then
            local nextStep = self:GetNextStep(step)
            if nextStep then
                return nextStep.isCompleteOverride or self:IsStepComplete(nextStep)
            else
                return false
            end
        end
    end

    Journeyman:Error("Step type %s not implemented.", step.type)
end

function State:IsChapterComplete()
    if self.steps and #self.steps > 0 then
        for i = 1, #self.steps do
            local step = self.steps[i]
            if step then
                if not step.isComplete and step.isShown then
                    return false
                end
            end
        end
        return true
    end
    return false
end

function State:GetCurrentStep()
    return self.currentStep
end

function State:GetNextStep(step, type)
    for i = step.index + 1, #self.steps do
        local nextStep = self.steps[i]
        if nextStep and (type == nil or nextStep.type == type) then
            return nextStep
        end
    end
end

function State:GetStepLocation(step)
    if step.type == Journeyman.STEP_TYPE_ACCEPT_QUEST then
        return Journeyman.DataSource:GetNearestQuestStarter(step.data.questId)
    elseif step.type == Journeyman.STEP_TYPE_COMPLETE_QUEST then
        local index = step.objectiveIndex
        if index == nil then
            index = self:IterateStepQuestObjectives(step, function(objective, objectiveIndex)
                if not objective.finished then
                    return objectiveIndex
                end
            end)
        end
        return Journeyman.DataSource:GetNearestQuestObjective(step.data.questId, index)
    elseif step.type == Journeyman.STEP_TYPE_TURNIN_QUEST then
        return Journeyman.DataSource:GetNearestQuestFinisher(step.data.questId)
    elseif step.type == Journeyman.STEP_TYPE_GO_TO_COORD then
        if Journeyman.player.location then
            local distance = HBD:GetZoneDistance(Journeyman.player.location.mapId, Journeyman.player.location.x, Journeyman.player.location.y, step.data.mapId, step.data.x / 100.0, step.data.y / 100.0)
            if distance then
                return { distance = distance, mapId = step.data.mapId, x = step.data.x, y = step.data.y, name = string.format("%s\n%s", step.data.desc, step.data.mapName), type = "Event" }
            end
        end
    elseif step.type == Journeyman.STEP_TYPE_GO_TO_ZONE then
        if Journeyman.player.location and step.data.x and step.data.y then -- coords are optional, so they can be nil
            local distance = HBD:GetZoneDistance(Journeyman.player.location.mapId, Journeyman.player.location.x, Journeyman.player.location.y, step.data.mapId, step.data.x / 100.0, step.data.y / 100.0)
            if distance then
                return { distance = distance, mapId = step.data.mapId, x = step.data.x, y = step.data.y, name = string.format("%s", step.data.mapName), type = "Event" }
            end
        end
    elseif step.type == Journeyman.STEP_TYPE_GO_TO_AREA then
        return nil -- todo
    elseif step.type == Journeyman.STEP_TYPE_REACH_LEVEL then
        return nil
    elseif step.type == Journeyman.STEP_TYPE_BIND_HEARTHSTONE then
        return Journeyman.DataSource:GetNearestInnkeeperLocation(step.data.areaId)
    elseif step.type == Journeyman.STEP_TYPE_USE_HEARTHSTONE then
        return nil
    elseif step.type == Journeyman.STEP_TYPE_LEARN_FLIGHT_PATH then
        return Journeyman.DataSource:GetFlightMasterLocation(step.data.taxiNodeId)
    elseif step.type == Journeyman.STEP_TYPE_FLY_TO then
        return Journeyman.DataSource:GetNearestFlightMasterLocation()
    elseif step.type == Journeyman.STEP_TYPE_TRAIN_CLASS then
        return Journeyman.DataSource:GetNearestClassTrainerLocation()
    elseif step.type == Journeyman.STEP_TYPE_TRAIN_SPELLS then
        local spellId = step.data.spells[1] -- Always use trainer location of first spell in list
        if spellId == Journeyman.SPELL_TELEPORT_TO_STORMWIND or spellId == Journeyman.SPELL_PORTAL_TO_STORMWIND then
            return Journeyman.DataSource:GetNPCLocation(Journeyman.NPC_STORMWIND_PORTAL_TRAINER)
        elseif spellId == Journeyman.SPELL_TELEPORT_TO_IRONFORGE or spellId == Journeyman.SPELL_PORTAL_TO_IRONFORGE then
            return Journeyman.DataSource:GetNPCLocation(Journeyman.NPC_IRONFORGE_PORTAL_TRAINER)
        elseif spellId == Journeyman.SPELL_TELEPORT_TO_DARNASSUS or spellId == Journeyman.SPELL_PORTAL_TO_DARNASSUS then
            return Journeyman.DataSource:GetNPCLocation(Journeyman.NPC_DARNASSUS_PORTAL_TRAINER)
        end
        return Journeyman.DataSource:GetNearestClassTrainerLocation()
    elseif step.type == Journeyman.STEP_TYPE_LEARN_FIRST_AID then
        return Journeyman.DataSource:GetNearestFirstAidTrainerLocation()
    elseif step.type == Journeyman.STEP_TYPE_LEARN_COOKING then
        return Journeyman.DataSource:GetNearestCookingTrainerLocation()
    elseif step.type == Journeyman.STEP_TYPE_LEARN_FISHING then
        return Journeyman.DataSource:GetNearestFishingTrainerLocation()
    elseif step.type == Journeyman.STEP_TYPE_DIE_AND_RES then
        return nil
    else
        Journeyman:Error("Step type %s not implemented.", step.type)
    end
end

function State:IsQuestAvailable(questId)
    -- Check if quest exists in game
    if not Journeyman.DataSource:IsQuestAvailable(questId) then
        return false, "Invalid quest ID"
    end

    -- Check if player has required race
    if not Journeyman.DataSource:GetQuestHasRequiredRace(questId) then
        return false, "Missing race requirement"
    end

    -- Check if player has required class
    if not Journeyman.DataSource:GetQuestHasRequiredClass(questId) then
        return false, "Missing class requirement"
    end

    -- Quest should be available now or later
    return true
end

function State:IsQuestDoable(questId, isStepTypeComplete)
    -- Check if player has required level
    if Journeyman.player.level < Journeyman.DataSource:GetQuestRequiredLevel(questId) then
        return false, "Missing level requirement"
    end

    -- Check if player has required profession and skill level
    if not Journeyman.DataSource:GetQuestHasProfessionAndSkillLevel(questId) then
        return false, "Missing profession or skill level requirement"
    end

    -- Check if player has required reputation
    if not Journeyman.DataSource:GetQuestHasReputation(questId) then
        return false, "Missing reputation requirement"
    end

    -- For complete quest steps: if quest is not in quest log yet, assume it will become doable
    if isStepTypeComplete and not self:IsQuestInQuestLog(questId) then
        return true
    end

    -- Check if quest next quest in chain is complete or in quest log
    local nextInChainQuestId = Journeyman.DataSource:GetQuestNextQuestInChain(questId)
    if nextInChainQuestId and State:IsQuestInQuestLogOrTurnedIn(nextInChainQuestId) then
        return false, string.format("Next quest in chain %s is in quest log or has been turned-in", nextInChainQuestId)
    end

    -- Check if quest has exclusive quests completed or in quest log
    local exclusiveToQuestIds = Journeyman.DataSource:GetQuestExclusiveTo(questId)
    if exclusiveToQuestIds then
        if List:Any(exclusiveToQuestIds, function(exclusiveQuestId) return exclusiveQuestId and State:IsQuestInQuestLogOrTurnedIn(exclusiveQuestId) end) then
            return false, string.format("Exclusive quest %s is in quest log or has been turned-in", exclusiveQuestId)
        end
    end

    -- Check if quest has parent quest and is in quest log
    local parentQuestId = Journeyman.DataSource:GetQuestParentQuest(questId)
    if parentQuestId and not State:IsQuestInQuestLog(parentQuestId) then
        return false, string.format("Parent quest %s is not in quest log", parentQuestId)
    end

    -- Check if all pre quests are complete
    local preQuestGroup = Journeyman.DataSource:GetQuestPreQuestGroup(questId)
    if preQuestGroup then
        return self:IsQuestPreQuestGroupFulfilled(preQuestGroup)
    end

    -- Check if single pre quest are complete
    local preQuestSingle = Journeyman.DataSource:GetQuestPreQuestSingle(questId)
    if preQuestSingle then
        return self:IsPreQuestSingleFulfilled(preQuestSingle)
    end

    -- Quest is doable now
    return true
end

function State:IsQuestPreQuestGroupFulfilled(preQuestGroup)
    -- If a quest is not complete and no exlusive quest is complete, the requirement is not fulfilled
    for _, preQuestId in pairs(preQuestGroup) do
        if not self:IsQuestTurnedIn(preQuestId) then
            local exclusiveToQuestIds = Journeyman.DataSource:GetQuestExclusiveTo(preQuestId)
            if exclusiveToQuestIds == nil then
                return false, string.format("Pre quest %s is not turned-in and there is no exclusive quests", preQuestId)
            end
            if not List:Any(exclusiveToQuestIds, function(exclusiveQuestId) return exclusiveQuestId and self:IsQuestTurnedIn(exclusiveQuestId) end) then
                return false, string.format("None of the exclusive quests of pre quest %s have been turned-in", preQuestId)
            end
        end
    end

    -- All pre quests are complete
    return true
end

function State:IsPreQuestSingleFulfilled(preQuestSingle)
    for _, preQuestId in pairs(preQuestSingle) do
        -- If a quest is complete the requirement is fulfilled
        if self:IsQuestTurnedIn(preQuestId) then
            return true
        end

        -- If one of the quests in the exclusive group is complete, the requirement is fulfilled
        local exclusiveToQuestIds = Journeyman.DataSource:GetQuestExclusiveTo(preQuestId)
        if exclusiveToQuestIds then
            if List:Any(exclusiveToQuestIds, function(exclusiveQuestId) return exclusiveQuestId and self:IsQuestTurnedIn(exclusiveQuestId) end) then
                return true
            end
        end
    end

    -- No pre quest is complete
    return false, "No pre quest have been turned-in"
end

function State:IsStepQuestObjectivesComplete(step)
    local result = self:IterateStepQuestObjectives(step, function(objective, objectiveIndex)
        if not objective.finished then
            return false
        end
    end)
    return result == nil -- No result means all objectives are complete
end

function State:IsQuestObjectivesComplete(questId)
    local result = self:IterateQuestObjectives(questId, function(objective, objectiveIndex)
        if not objective.finished then
            return false
        end
    end)
    return result == nil -- No result means all objectives are complete
end

function State:IsQuestInQuestLog(questId)
    return self.questLog and self.questLog[questId] ~= nil
end

function State:IsQuestInQuestLogAndComplete(questId)
    if self.questLog then
        local questInfo = self.questLog[questId]
        if questInfo and (questInfo.isComplete or self:IsQuestObjectivesComplete(questId)) then
            return true
        end
    end
    return false
end

function State:IsQuestInQuestLogOrTurnedIn(questId)
    return self:IsQuestInQuestLog(questId) or self:IsQuestTurnedIn(questId)
end

function State:IsQuestTurnedIn(questId)
    if self.turnedInQuests == nil then
        self.turnedInQuests = {}
    end

    if self.turnedInQuests[questId] == true then
        return true
    end

    -- Force update if nil or false
    local isQuestTurnedIn = C_QuestLog.IsQuestFlaggedCompleted(questId) == true
    self.turnedInQuests[questId] = isQuestTurnedIn
    return isQuestTurnedIn
end

function State:IsQuestChainStarted(questId)
    if self.startedQuestChains == nil then
        self.startedQuestChains = {}
    end

    if self.startedQuestChains[questId] == true then
        return true
    end

    local isQuestChainStarted = self:_IsQuestChainStarted(questId)
    self.startedQuestChains[questId] = isQuestChainStarted
    return isQuestChainStarted
end

function State:GetQuestLogInfo(questId)
    if self.questLog then
        return self.questLog[questId]
    end
end

function State:IterateStepQuestObjectives(step, callback)
    local objectives = C_QuestLog.GetQuestObjectives(step.data.questId)
    if objectives == nil then
        return
    end

    if step.data.objectives then
        for _, objectiveIndex in ipairs(step.data.objectives) do
            local objective = objectives[objectiveIndex]
            if objective then
                local result = callback(objective, objectiveIndex)
                if result ~= nil then
                    return result
                end
            end
        end
    else
        for objectiveIndex = 1, #objectives do
            local objective = objectives[objectiveIndex]
            if objective then
                local result = callback(objective, objectiveIndex)
                if result ~= nil then
                    return result
                end
            end
        end
    end
end

function State:IterateQuestObjectives(questId, callback)
    local objectives = C_QuestLog.GetQuestObjectives(questId)
    if objectives == nil then
        return
    end

    for objectiveIndex = 1, #objectives do
        local objective = objectives[objectiveIndex]
        if objective then
            local result = callback(objective, objectiveIndex)
            if result ~= nil then
                return result
            end
        end
    end
end

function State:_IsQuestChainStarted(questId)
    if self:IsQuestInQuestLogOrTurnedIn(questId) then
        return true
    end

    -- Check parent quest
    local parentQuestId = Journeyman.DataSource:GetQuestParentQuest(questId)
    if parentQuestId and self:IsQuestChainStarted(parentQuestId) then
        return true
    end

    -- Check pre quest group
    local preQuestGroup = Journeyman.DataSource:GetQuestPreQuestGroup(questId)
    if preQuestGroup and next(preQuestGroup) then
        if List:Any(preQuestGroup, function(preQuestId) return preQuestId and self:IsQuestChainStarted(preQuestId) end) then
            return true
        end
    end

    -- Check pre quest single
    local preQuestSingle = Journeyman.DataSource:GetQuestPreQuestSingle(questId)
    if preQuestSingle and next(preQuestSingle) then
        if List:Any(preQuestSingle, function(preQuestId) return preQuestId and self:IsQuestChainStarted(preQuestId) end) then
            return true
        end
    end

    return false
end
