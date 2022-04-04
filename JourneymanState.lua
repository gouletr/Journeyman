local addonName, addon = ...
local Journeyman = addon.Journeyman
local L = addon.Locale
local State = {}
Journeyman.State = State

local HBD = LibStub("HereBeDragons-2.0")

local function IsStepQuestObjectivesComplete(step)
    local objectives = C_QuestLog.GetQuestObjectives(step.data.questId)
    if objectives == nil then
        return false
    end

    for _, objectiveIndex in ipairs(step.data.objectives) do
        local objective = objectives[objectiveIndex]
        if objective and not objective.finished then
            return false
        end
    end

    return true
end

local function IsStepComplete(step)
    if Journeyman:IsStepTypeQuest(step) then
        -- Check if quest is already turned-in
        if C_QuestLog.IsQuestFlaggedCompleted(step.data.questId) then
            return true
        end

        -- Check if quest is exclusive to some other quests
        local exclusiveTo = Journeyman.DataSource:GetQuestExclusiveTo(step.data.questId)
        if exclusiveTo ~= nil then
            for _, questId in ipairs(exclusiveTo) do
                -- Check if exclusive quest is in quest log or already turned-in
                if State.lastQuestLog[questId] ~= nil or C_QuestLog.IsQuestFlaggedCompleted(questId) then
                    return true -- Quest is unobtainable, consider complete
                end
            end
        end

        -- Per quest step type checks
        local questInfo = State.lastQuestLog[step.data.questId]
        if step.type == Journeyman.STEP_TYPE_ACCEPT_QUEST then
            -- Check if quest is in quest log
            if questInfo ~= nil then
                return true
            end
        elseif step.type == Journeyman.STEP_TYPE_COMPLETE_QUEST then
            if step.data.objectives and IsStepQuestObjectivesComplete(step) then -- Check if quest specify objectives, and they are all complete
                return true
            elseif questInfo ~= nil and questInfo.isComplete then -- Check if quest is in quest log and complete
                return true
            end
        elseif step.type == Journeyman.STEP_TYPE_TURNIN_QUEST then
            -- Check if quest is turned-in (redundancy)
            if C_QuestLog.IsQuestFlaggedCompleted(step.data.questId) then
                return true
            end
        end

        -- Check if quest is repeatable
        if Journeyman.DataSource:IsQuestRepeatable(step.data.questId) then
            -- If next step is complete, consider this step complete
            local nextStep = State.steps[step.index + 1]
            if nextStep and IsStepComplete(nextStep) then
                return true
            end
        end
        return false
    else
        if step.type == Journeyman.STEP_TYPE_GO_TO then
            if State.playerLocation then
                local distance = HBD:GetZoneDistance(State.playerLocation.mapId, State.playerLocation.x, State.playerLocation.y, step.data.mapId, step.data.x / 100.0, step.data.y / 100.0)
                if distance and distance <= 15 then
                    return true
                end
            end
        elseif step.type == Journeyman.STEP_TYPE_REACH_LEVEL then
            if step.data.xp then
                return State.playerLevel > step.data.level or (State.playerLevel == step.data.level and State.playerXP >= step.data.xp)
            else
                return State.playerLevel >= step.data.level
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
        elseif step.type == Journeyman.STEP_TYPE_FLY_TO then
            -- Check if we are currently flying to that taxiNodeId
            if Journeyman.flyingTo == step.data.taxiNodeId and State.playerOnTaxi then
                return true
            end

            -- Check if we are in same map as taxiNodeId
            local taxiNodeWorldCoords = Journeyman:GetTaxiNodeWorldCoordinates(step.data.taxiNodeId)
            if taxiNodeWorldCoords then
                local x, y = HBD:GetZoneCoordinatesFromWorld(taxiNodeWorldCoords[1], taxiNodeWorldCoords[2], State.playerLocation.mapId, false)
                if x and y then -- If we have coordinates, it means we are in same zone
                    return true
                end
            end
        end

        -- If next step is complete, consider this step complete
        if step.type == Journeyman.STEP_TYPE_GO_TO or step.type == Journeyman.STEP_TYPE_BIND_HEARTHSTONE or step.type == Journeyman.STEP_TYPE_USE_HEARTHSTONE or step.type == Journeyman.STEP_TYPE_LEARN_FLIGHT_PATH or step.type == Journeyman.STEP_TYPE_FLY_TO then
            local nextStep = State.steps[step.index + 1]
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

    -- Hide quest steps that originate from an NPC drop, that isn't in the quest log or flagged completed
    if showStep and Journeyman:IsStepTypeQuest(step) then
        local questId = Journeyman.DataSource:GetQuestChainStartQuest(step.data.questId)
        if Journeyman.DataSource:IsQuestNPCDrop(questId) and not State:IsQuestInQuestLog(questId) and not C_QuestLog.IsQuestFlaggedCompleted(questId) then
            showStep = false
        end
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
        if step.type == type then
            if CompareStepData(step, data) then
                -- For step types that are not unique, also check if they are complete
                if step.type == Journeyman.STEP_TYPE_GO_TO or step.type == Journeyman.STEP_TYPE_BIND_HEARTHSTONE or step.type == Journeyman.STEP_TYPE_USE_HEARTHSTONE or step.type == Journeyman.STEP_TYPE_FLY_TO then
                    if not step.isCompleteOverride then
                        return step
                    end
                else
                    return step
                end
            end
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
    if not Journeyman.worldLoaded or not Journeyman.DataSource:IsInitialized() then return end
    local now = GetTimePreciseSec()

    -- Store some values
    local playerX, playerY, playerMapId = HBD:GetPlayerZonePosition()
    if playerMapId and playerX and playerY then
        self.playerLocation = { mapId = playerMapId, x = playerX, y = playerY }
    else
        self.playerLocation = nil
    end
    self.playerLevel = UnitLevel("player")
    self.playerXP = UnitXP("player")
    self.playerMaxXP = UnitXPMax("player")
    self.playerOnTaxi = UnitOnTaxi("player")
    self.playerGreenRange = GetQuestGreenRange("player")

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
                    -- Check if step is ever doable
                    local data = Journeyman:GetStepData(step)
                    if data then
                        local doable = true
                        if Journeyman:IsStepTypeQuest(step) then
                            doable = doable and Journeyman.DataSource:IsQuestAvailable(data.questId)
                            doable = doable and Journeyman.DataSource:GetQuestHasRequiredRace(data.questId)
                            doable = doable and Journeyman.DataSource:GetQuestHasRequiredClass(data.questId)
                        elseif step.type == Journeyman.STEP_TYPE_BIND_HEARTHSTONE or step.type == Journeyman.STEP_TYPE_USE_HEARTHSTONE then
                            doable = doable and Journeyman.DataSource:GetNearestInnkeeperLocation(data.areaId) ~= nil
                        elseif step.type == Journeyman.STEP_TYPE_LEARN_FLIGHT_PATH or step.type == Journeyman.STEP_TYPE_FLY_TO then
                            doable = doable and Journeyman:IsTaxiNodeAvailable(data.taxiNodeId)
                        end

                        -- Clone step only if ever doable
                        if doable then
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
    end

    -- Update quest log
    local questLog = Journeyman:GetQuestLog()
    if questLog then
        if self.lastQuestLog then
            -- Compare new quest log with last
            for questId, questInfo in pairs(questLog) do
                local lastQuestInfo = self.lastQuestLog[questId]
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
        self.lastQuestLog = questLog
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
                step.isComplete = IsStepComplete(step)
            end

            -- Check if step is shown
            if Journeyman.db.profile.window.stepsShown > 0 and stepShownCount >= Journeyman.db.profile.window.stepsShown then
                step.isShown = false
            else
                step.isShown = IsStepShown(step)
            end

            -- Count shown steps
            if not step.isComplete and step.isShown then
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
        if step.data.objectives and IsStepQuestObjectivesComplete(step) then
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
    if self.steps then
        for i = 1, #self.steps do
            local step = self.steps[i]
            if step then
                if not step.isComplete and step.isShown then
                    return step
                end
            end
        end
    end
end

function State:GetStepLocation(step)
    if step.type == Journeyman.STEP_TYPE_ACCEPT_QUEST then
        return Journeyman.DataSource:GetNearestQuestStarter(step.data.questId)
    elseif step.type == Journeyman.STEP_TYPE_COMPLETE_QUEST then
        if step.data.objectives and step.objectiveIndex == nil then
            local questInfo = self.lastQuestLog[step.data.questId]
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
        if step.data.mapId and step.data.x and step.data.y then
            local playerX, playerY, playerMapId = HBD:GetPlayerZonePosition()
            if playerMapId and playerX and playerY then
                local distance = HBD:GetZoneDistance(playerMapId, playerX, playerY, step.data.mapId, step.data.x / 100.0, step.data.y / 100.0)
                if distance then
                    return { distance = distance, x = step.data.x, y = step.data.y, mapId = step.data.mapId, name = string.format("%s\n%s", step.data.desc, step.data.mapName) }
                end
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
    else
        Journeyman:Error("Step type %s not implemented.", step.type)
    end
end

function State:GetQuestLogInfo(questId)
    return self.lastQuestLog[questId]
end

function State:IsQuestInQuestLog(questId)
    return self.lastQuestLog[questId] ~= nil
end
