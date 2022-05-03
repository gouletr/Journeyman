local addonName, addon = ...
local Journeyman = addon.Journeyman
local L = addon.Locale
local State = {}
Journeyman.State = State

local HBD = LibStub("HereBeDragons-2.0")

local function IsPreQuestGroupFulfilled(preQuestGroup)
    if not preQuestGroup or not next(preQuestGroup) then
        return true
    end

    -- If a quest is not complete and no exlusive quest is complete, the requirement is not fulfilled
    for _, preQuestId in pairs(preQuestGroup) do
        if not State:IsQuestTurnedIn(preQuestId) then
            local preQuestExclusiveQuestGroup = Journeyman.DataSource:GetQuestExclusiveTo(preQuestId)
            if preQuestExclusiveQuestGroup == nil then
                return false
            end

            local anyExlusiveFinished = false
            for _, exclusiveQuestId in ipairs(preQuestExclusiveQuestGroup) do
                if State:IsQuestTurnedIn(exclusiveQuestId) then
                    anyExlusiveFinished = true
                    break
                end
            end
            if not anyExlusiveFinished then
                return false
            end
        end
    end
    return true -- All preQuests are complete
end

local function IsPreQuestSingleFulfilled(preQuestSingle)
    if not preQuestSingle or not next(preQuestSingle) then
        return true
    end

    for _, preQuestId in pairs(preQuestSingle) do
        -- If a quest is complete the requirement is fulfilled
        if State:IsQuestTurnedIn(preQuestId) then
            return true
        else -- If one of the quests in the exclusive group is complete the requirement is fulfilled
            local preQuestExclusiveQuestGroup = Journeyman.DataSource:GetQuestExclusiveTo(preQuestId)
            if preQuestExclusiveQuestGroup then
                for _, exclusiveQuestId in ipairs(preQuestExclusiveQuestGroup) do
                    if State:IsQuestTurnedIn(exclusiveQuestId) then
                        return true
                    end
                end
            end
        end
    end
    return false -- No preQuest is complete
end

local function IsQuestDoable(questId)
    -- Check if quest exists
    if not Journeyman.DataSource:IsQuestAvailable(questId) then
        return false
    end

    -- Check if player has required race
    if not Journeyman.DataSource:GetQuestHasRequiredRace(questId) then
        return false
    end

    -- Check if player has required class
    if not Journeyman.DataSource:GetQuestHasRequiredClass(questId) then
        return false
    end

    -- Check if player has required profession and skill level
    if not Journeyman.DataSource:GetQuestHasProfessionAndSkillLevel(questId) then
        return false
    end

    -- Check if player has required reputation
    if not Journeyman.DataSource:GetQuestHasReputation(questId) then
        return false
    end

    -- Check if quest next quest in chain is complete or in quest log
    local nextInChainQuestId = Journeyman.DataSource:GetQuestNextQuestInChain(questId)
    if nextInChainQuestId and (State:IsQuestTurnedIn(nextInChainQuestId) or State:IsQuestInQuestLog(nextInChainQuestId)) then
        return false
    end

    -- Check if quest has exclusive quests completed or in quest log
    local exclusiveToQuestIds = Journeyman.DataSource:GetQuestExclusiveTo(questId)
    if exclusiveToQuestIds then
        for _, exclusiveQuestId in pairs(exclusiveToQuestIds) do
            if State:IsQuestTurnedIn(exclusiveQuestId) or State:IsQuestInQuestLog(exclusiveQuestId) then
                return false
            end
        end
    end

    return true
end

local function IsStepDoable(step)
    if Journeyman:IsStepTypeQuest(step) then
        -- Check if quest is doable
        if not IsQuestDoable(step.data.questId) then
            return false
        end

        -- Additional checks for npc drop quests
        if Journeyman.DataSource:IsQuestNPCDrop(step.data.questId) then
            if step.type == Journeyman.STEP_TYPE_COMPLETE_QUEST or step.type == Journeyman.STEP_TYPE_TURNIN_QUEST then
                return State:IsQuestInQuestLog(step.data.questId)
            end
        end

        -- Additional checks if step is going to be current step
        if State.currentStep == nil then
            -- Check if quest has parent quest and is in quest log
            local parentQuestId = Journeyman.DataSource:GetQuestParentQuest(step.data.questId)
            if parentQuestId then
                return State:IsQuestInQuestLog(parentQuestId)
            end

            -- Check if all pre quests are complete
            local preQuestGroup = Journeyman.DataSource:GetQuestPreQuestGroup(step.data.questId)
            if preQuestGroup then
                return IsPreQuestGroupFulfilled(preQuestGroup)
            end

            -- Check if single pre quest are complete
            local preQuestSingle = Journeyman.DataSource:GetQuestPreQuestSingle(step.data.questId)
            if preQuestSingle then
                return IsPreQuestSingleFulfilled(preQuestSingle)
            end
        end
    elseif step.type == Journeyman.STEP_TYPE_BIND_HEARTHSTONE or step.type == Journeyman.STEP_TYPE_USE_HEARTHSTONE then
        return Journeyman.DataSource:GetNearestInnkeeperLocation(step.data.areaId) ~= nil
    elseif step.type == Journeyman.STEP_TYPE_LEARN_FLIGHT_PATH or step.type == Journeyman.STEP_TYPE_FLY_TO then
        return Journeyman:IsTaxiNodeAvailable(step.data.taxiNodeId)
    end
    return true
end

local function IsStepQuestObjectivesComplete(step)
    local objectives = C_QuestLog.GetQuestObjectives(step.data.questId)
    if objectives == nil then
        return false
    end

    if step.data.objectives then
        for _, objectiveIndex in ipairs(step.data.objectives) do
            local objective = objectives[objectiveIndex]
            if objective and not objective.finished then
                return false
            end
        end
    else
        for objectiveIndex = 1, #objectives do
            local objective = objectives[objectiveIndex]
            if objective and not objective.finished then
                return false
            end
        end
    end

    return true
end

local function IsStepComplete(step)
    if Journeyman:IsStepTypeQuest(step) then
        -- Check if quest is already turned-in
        if State:IsQuestTurnedIn(step.data.questId) then
            return true
        end

        -- Check if quest is exclusive to some other quests
        local exclusiveToQuestIds = Journeyman.DataSource:GetQuestExclusiveTo(step.data.questId)
        if exclusiveToQuestIds ~= nil then
            for _, questId in ipairs(exclusiveToQuestIds) do
                -- Check if exclusive quest is in quest log or already turned-in
                if State:IsQuestInQuestLog(questId) or State:IsQuestTurnedIn(questId) then
                    return true -- Quest is unobtainable, consider complete
                end
            end
        end

        -- Per quest step type checks
        if step.type == Journeyman.STEP_TYPE_ACCEPT_QUEST then
            -- Check if quest is in quest log
            if State:IsQuestInQuestLog(step.data.questId) then
                return true
            end
        elseif step.type == Journeyman.STEP_TYPE_COMPLETE_QUEST then
            if IsStepQuestObjectivesComplete(step) then -- Check if quest specify objectives, and they are all complete
                return true
            elseif State:IsQuestInQuestLogAndComplete(step.data.questId) then -- Check if quest is in quest log and complete
                return true
            end
        elseif step.type == Journeyman.STEP_TYPE_TURNIN_QUEST then
            -- Check if quest is turned-in (redundancy)
            if State:IsQuestTurnedIn(step.data.questId) then
                return true
            end
        end

        -- Check if quest is repeatable
        if Journeyman.DataSource:IsQuestRepeatable(step.data.questId) then
            -- If next step is complete, consider this step complete
            local nextStep = State:GetNextDoableStep(step.index + 1)
            if nextStep and IsStepComplete(nextStep) then
                return true
            end
        end
        return false
    else
        if step.type == Journeyman.STEP_TYPE_GO_TO then
            if Journeyman.player.location then
                local distance = HBD:GetZoneDistance(Journeyman.player.location.mapId, Journeyman.player.location.x, Journeyman.player.location.y, step.data.mapId, step.data.x / 100.0, step.data.y / 100.0)
                if distance and distance <= 15 then
                    return true
                end
            end
        elseif step.type == Journeyman.STEP_TYPE_REACH_LEVEL then
            if step.data.xp then
                return Journeyman.player.level > step.data.level or (Journeyman.player.level == step.data.level and Journeyman.player.xp >= step.data.xp)
            else
                return Journeyman.player.level >= step.data.level
            end
        elseif step.type == Journeyman.STEP_TYPE_BIND_HEARTHSTONE then
            -- Check if current bind location match
            if GetBindLocation() == Journeyman:GetAreaName(step.data.areaId) then
                return true
            end
        elseif step.type == Journeyman.STEP_TYPE_USE_HEARTHSTONE then
            -- Check if current bind location match and hearthstone is on cooldown
            local startTime, duration, enable = GetItemCooldown(Journeyman.ITEM_HEARTHSTONE)
            local cooldownLeft = duration - (GetTime() - startTime)
            if cooldownLeft > 0 and GetBindLocation() == Journeyman:GetAreaName(step.data.areaId) then
                return true
            end
        elseif step.type == Journeyman.STEP_TYPE_LEARN_FLIGHT_PATH then
            -- Check if taxiNodeId has been unlocked
            return Journeyman.db.char.taxiNodeIds[step.data.taxiNodeId] == true
        elseif step.type == Journeyman.STEP_TYPE_FLY_TO then
            -- Check if we are currently flying to that taxiNodeId
            if Journeyman.flyingTo == step.data.taxiNodeId and Journeyman.player.onTaxi then
                return true
            end

            -- Check if we are in same map as taxiNodeId
            if Journeyman.player.location then
                local taxiNodeWorldCoords = Journeyman:GetTaxiNodeWorldCoordinates(step.data.taxiNodeId)
                if taxiNodeWorldCoords then
                    local x, y = HBD:GetZoneCoordinatesFromWorld(taxiNodeWorldCoords[1], taxiNodeWorldCoords[2], Journeyman.player.location.mapId, false)
                    if x and y then -- If we have coordinates, it means we are in same zone
                        return true
                    end
                end
            end
        end

        -- For step types that cannot be uniquely identified, check if next step is complete
        if not Journeyman:IsStepTypeUnique(step) then
            local nextStep = State:GetNextDoableStep(step.index + 1)
            if nextStep then
                return IsStepComplete(nextStep)
            else
                return false
            end
        end
    end

    Journeyman:Error("Step type %s not implemented.", step.type)
end

local function IsStepShown(step)
    -- Check if step is completed, or if we show completed steps
    local showStep = not step.isComplete or Journeyman.db.profile.window.showCompletedSteps

    -- Hide steps that are not doable
    if showStep then
        showStep = IsStepDoable(step)
    end

    return showStep
end

local function CompareStepData(step, data)
    if step.type == Journeyman.STEP_TYPE_ACCEPT_QUEST then
        return step.data.questId == data.questId
    elseif step.type == Journeyman.STEP_TYPE_COMPLETE_QUEST then
        if step.data.questId == data.questId then
            if step.data.objectives or data.objectives then
                if data.objectiveIndex then
                    return Journeyman.Utils:Contains(step.data.objectives, data.objectiveIndex)
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
    elseif step.type == Journeyman.STEP_TYPE_GO_TO then
        return step.data.mapId == data.mapId and step.data.x == data.x and step.data.y == data.y
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
    else
        Journeyman:Error("Step step.type %s not implemented.", step.step.type)
    end
end

local function FindStep(type, data)
    if not State.steps then
        return nil
    end

    for i = 1, #State.steps do
        local step = State.steps[i]
        if step.type == type and not step.isComplete and step.isShown and CompareStepData(step, data) then
            return step
        end
    end
end

function State:Initialize()
end

function State:Shutdown()
end

function State:CheckForUpdate()
    if self.needUpdate then
        self:UpdateImmediate()
    end
end

function State:Reset(immediate)
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

    -- Reset state
    self.turnedInQuests = {}

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
                        clonedStep.index = index
                        clonedStep.isComplete = false
                        clonedStep.isCompleteOverride = false
                        clonedStep.isShown = true
                        self.steps[index] = clonedStep
                        index = index + 1
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
    self.currentStep = nil
    if self.steps then
        for i = 1, #self.steps do
            local step = self.steps[i]

            -- Check if step is completed
            if step.isCompleteOverride then
                step.isComplete = true
            else
                step.isComplete = IsStepComplete(step)
            end

            -- Check if step is shown
            if Journeyman.db.profile.window.stepsShown > 0 and stepShownCount >= Journeyman.db.profile.window.stepsShown then
                step.isShown = false
            else
                step.isShown = IsStepShown(step)
            end

            if not step.isComplete and step.isShown then
                -- Store current step
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

    -- Update window immediate
    if Journeyman.db.char.window.show then
        Journeyman.Window:UpdateImmediate()
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
        if IsStepQuestObjectivesComplete(step) then
            self:OnStepCompleted(step)
        else
            Journeyman:Update()
        end
    end
end

function State:OnQuestTurnedIn(questId)
    local step = FindStep(Journeyman.STEP_TYPE_TURNIN_QUEST, { questId = questId })
    if step then
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

function State:OnLocationReached(location)
    local step = FindStep(Journeyman.STEP_TYPE_GO_TO, location)
    if step then
        self:OnStepCompleted(step)
    end
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

function State:OnStepCompleted(step)
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

function State:GetNextDoableStep(index)
    if self.steps and index <= #self.steps then
        for i = index, #self.steps do
            local step = self.steps[i]
            if IsStepDoable(step) then
                return step
            end
        end
    end
    return nil
end

function State:GetStepLocation(step)
    if step.type == Journeyman.STEP_TYPE_ACCEPT_QUEST then
        return Journeyman.DataSource:GetNearestQuestStarter(step.data.questId)
    elseif step.type == Journeyman.STEP_TYPE_COMPLETE_QUEST then
        if step.data.objectives and step.objectiveIndex == nil then
            local questInfo = self:GetQuestLogInfo(step.data.questId)
            if questInfo and questInfo.objectives then
                for _, objectiveIndex in ipairs(step.data.objectives) do
                    local objective = questInfo.objectives[objectiveIndex]
                    if objective and not objective.finished then
                        return Journeyman.DataSource:GetNearestQuestObjective(step.data.questId, objectiveIndex)
                    end
                end
            end
        end
        return Journeyman.DataSource:GetNearestQuestObjective(step.data.questId, step.objectiveIndex)
    elseif step.type == Journeyman.STEP_TYPE_TURNIN_QUEST then
        return Journeyman.DataSource:GetNearestQuestFinisher(step.data.questId)
    elseif step.type == Journeyman.STEP_TYPE_GO_TO then
        if Journeyman.player.location then
            local distance = HBD:GetZoneDistance(Journeyman.player.location.mapId, Journeyman.player.location.x, Journeyman.player.location.y, step.data.mapId, step.data.x / 100.0, step.data.y / 100.0)
            if distance then
                return { distance = distance, x = step.data.x, y = step.data.y, mapId = step.data.mapId, name = string.format("%s\n%s", step.data.desc, step.data.mapName) }
            end
        end
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
    else
        Journeyman:Error("Step type %s not implemented.", step.type)
    end
end

function State:IsQuestInQuestLog(questId)
    return self.questLog and self.questLog[questId] ~= nil
end

function State:IsQuestInQuestLogAndComplete(questId)
    if self.questLog == nil then
        return false
    end

    local questInfo = self.questLog[questId]
    if questInfo and questInfo.isComplete then
        return true
    end

    return false
end

function State:IsQuestTurnedIn(questId)
    if self.turnedInQuests == nil then
        self.turnedInQuests = {}
    end

    local turnedIn = self.turnedInQuests[questId]
    if turnedIn == nil then
        turnedIn = C_QuestLog.IsQuestFlaggedCompleted(questId) == true
        self.turnedInQuests[questId] = turnedIn
    end
    return turnedIn
end

function State:GetQuestLogInfo(questId)
    if self.questLog == nil then
        return nil
    end

    return self.questLog[questId]
end
