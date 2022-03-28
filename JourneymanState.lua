local addonName, addon = ...
local Journeyman = addon.Journeyman
local L = addon.Locale
local State = {}
Journeyman.State = State

local HBD = LibStub("HereBeDragons-2.0")

local function IsStepQuestObjectivesComplete(step, data)
    if data == nil then
        data = Journeyman:GetStepData(step)
    end
    if data and data.questId and data.objectives then
        local questInfo = State.lastQuestLog[data.questId]
        if questInfo and questInfo.objectives then
            for _, i in ipairs(data.objectives) do
                local objective = questInfo.objectives[i]
                if objective == nil or not objective.finished then
                    return false
                end
            end
            return true
        end
    end
    return false
end

local function IsStepComplete(step)
    local data = Journeyman:GetStepData(step)
    if data == nil then
        return false
    end

    if Journeyman:IsStepTypeQuest(step) then
        -- Check if quest is already turned-in
        if C_QuestLog.IsQuestFlaggedCompleted(data.questId) then
            return true
        end

        -- Check if quest is exclusive to some other quests
        local exclusiveTo = Journeyman.DataSource:GetQuestExclusiveTo(data.questId)
        if exclusiveTo ~= nil then
            for _, questId in ipairs(exclusiveTo) do
                -- Check if exclusive quest is in quest log or already turned-in
                if State.lastQuestLog[questId] ~= nil or C_QuestLog.IsQuestFlaggedCompleted(questId) then
                    return true -- Quest is unobtainable, consider complete
                end
            end
        end

        -- Per quest step type checks
        local questInfo = State.lastQuestLog[data.questId]
        if step.type == Journeyman.STEP_TYPE_ACCEPT_QUEST then
            -- Check if quest is in quest log
            if questInfo ~= nil then
                return true
            end
        elseif step.type == Journeyman.STEP_TYPE_COMPLETE_QUEST then
            if IsStepQuestObjectivesComplete(step, data) then -- Check if quest specify objectives, and they are all complete
                return true
            elseif questInfo ~= nil and questInfo.isComplete then -- Check if quest is in quest log and complete
                return true
            end
        elseif step.type == Journeyman.STEP_TYPE_TURNIN_QUEST then
            -- Check if quest is turned-in (redundancy)
            if C_QuestLog.IsQuestFlaggedCompleted(data.questId) then
                return true
            end
        end

        -- Check if quest is repeatable
        if Journeyman.DataSource:IsQuestRepeatable(data.questId) then
            -- If next step is complete, consider this step complete
            local nextStep = State.steps[step.index + 1]
            if nextStep and IsStepComplete(nextStep) then
                return true
            end
        end
        return false
    else
        if step.type == Journeyman.STEP_TYPE_GO_TO then
            if data.x and data.y and data.mapId then
                local playerX, playerY, playerMapId = HBD:GetPlayerZonePosition()
                local distance = HBD:GetZoneDistance(playerMapId, playerX, playerY, data.mapId, data.x / 100.0, data.y / 100.0)
                if distance and distance <= 15 then
                    return true
                end
            end
        elseif step.type == Journeyman.STEP_TYPE_REACH_LEVEL then
            return UnitLevel("player") >= data.level
        elseif step.type == Journeyman.STEP_TYPE_BIND_HEARTHSTONE then
            -- Check if current bind location match
            if GetBindLocation() == Journeyman:GetAreaName(data.areaId) then
                return true
            end
        elseif step.type == Journeyman.STEP_TYPE_USE_HEARTHSTONE then
            -- Check if current bind location match and hearthstone is on cooldown
            local startTime, duration, enable = GetItemCooldown(Journeyman.ITEM_HEARTHSTONE)
            local cooldownLeft = duration - (GetTime() - startTime)
            if cooldownLeft > 0 and GetBindLocation() == Journeyman:GetAreaName(data.areaId) then
                return true
            end
        elseif step.type == Journeyman.STEP_TYPE_FLY_TO then
            -- Check if we are currently flying to that taxiNodeId
            if Journeyman.flyingTo == data.taxiNodeId and UnitOnTaxi("player") then
                return true
            end

            -- Check if we are in same map as taxiNodeId
            local taxiNodeWorldCoords = Journeyman:GetTaxiNodeWorldCoordinates(data.taxiNodeId)
            if taxiNodeWorldCoords then
                local x, y = HBD:GetZoneCoordinatesFromWorld(taxiNodeWorldCoords[1], taxiNodeWorldCoords[2], C_Map.GetBestMapForUnit("player"), false)
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
    if showStep then
        if Journeyman:IsStepTypeQuest(step) then
            local data = Journeyman:GetStepData(step)
            if data then
                local questId = Journeyman.DataSource:GetQuestChainStartQuest(data.questId)
                if Journeyman.DataSource:IsQuestNPCDrop(questId) and not State:IsQuestInQuestLog(questId) and not C_QuestLog.IsQuestFlaggedCompleted(questId) then
                    showStep = false
                end
            end
        end
    end

    return showStep
end

local function CompareStepData(type, lhs, rhs)
    if type == Journeyman.STEP_TYPE_ACCEPT_QUEST then
        return lhs.questId == rhs.questId
    elseif type == Journeyman.STEP_TYPE_COMPLETE_QUEST then
        if lhs.questId == rhs.questId then
            if lhs.objectives or rhs.objectives then
                if rhs.objectiveIndex then
                    return Journeyman.Utils:Contains(lhs.objectives, rhs.objectiveIndex)
                elseif lhs.objectiveIndex then
                    return Journeyman.Utils:Contains(rhs.objectives, lhs.objectiveIndex)
                else
                    Journeyman:Error("Expected objective index.")
                end
            else
                return true
            end
        end
    elseif type == Journeyman.STEP_TYPE_TURNIN_QUEST then
        return lhs.questId == rhs.questId
    elseif type == Journeyman.STEP_TYPE_GO_TO then
        return lhs.mapId == rhs.mapId and lhs.x == rhs.x and lhs.y == rhs.y
    elseif type == Journeyman.STEP_TYPE_REACH_LEVEL then
        return lhs.level == rhs.level
    elseif type == Journeyman.STEP_TYPE_BIND_HEARTHSTONE or type == Journeyman.STEP_TYPE_USE_HEARTHSTONE then
        return lhs.areaId == rhs.areaId
    elseif type == Journeyman.STEP_TYPE_LEARN_FLIGHT_PATH or type == Journeyman.STEP_TYPE_FLY_TO then
        return lhs.taxiNodeId == rhs.taxiNodeId
    else
        Journeyman:Error("Step type %s not implemented.", step.type)
    end
end

local function FindStep(type, data)
    if not State.steps then
        return nil
    end

    for i = 1, #State.steps do
        local step = State.steps[i]
        if step.type == type then
            if CompareStepData(step.type, Journeyman:GetStepData(step), data) then
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
                    local doable = true
                    local data = Journeyman:GetStepData(step)
                    if data then
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
                            self.steps[index] = Journeyman.Utils:Clone(step)
                            self.steps[index].index = index
                            self.steps[index].isCompleteOverride = false
                            self.steps[index].isComplete = false
                            self.steps[index].isShown = true
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
            if step and Journeyman:IsStepTypeQuest(step) then
                local data = Journeyman:GetStepData(step)
                if data and data.questId == questId then
                    step.isCompleteOverride = false
                end
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
    local data = Journeyman:GetStepData(step)
    if data == nil then
        return nil
    end

    if step.type == Journeyman.STEP_TYPE_ACCEPT_QUEST then
        return Journeyman.DataSource:GetNearestQuestStarter(data.questId)
    elseif step.type == Journeyman.STEP_TYPE_COMPLETE_QUEST then
        if data.objectives and step.objectiveIndex == nil then
            local questInfo = self.lastQuestLog[data.questId]
            if questInfo and questInfo.objectives then
                for _, i in ipairs(data.objectives) do
                    local objective = questInfo.objectives[i]
                    if objective and not objective.finished then
                        return Journeyman.DataSource:GetNearestQuestObjective(data.questId, i)
                    end
                end
            end
        end
        return Journeyman.DataSource:GetNearestQuestObjective(data.questId, step.objectiveIndex)
    elseif step.type == Journeyman.STEP_TYPE_TURNIN_QUEST then
        return Journeyman.DataSource:GetNearestQuestFinisher(data.questId)
    elseif step.type == Journeyman.STEP_TYPE_GO_TO then
        if data.mapId and data.x and data.y then
            local playerX, playerY, playerMapId = HBD:GetPlayerZonePosition()
            local distance = HBD:GetZoneDistance(playerMapId, playerX, playerY, data.mapId, data.x / 100.0, data.y / 100.0)
            if distance then
                local desc = data.desc
                if desc == nil then
                    desc = data.x..", "..data.y
                end
                local mapName = Journeyman:GetMapNameById(data.mapId)
                local name
                if mapName then
                    name = string.format("%s\n%s", desc, mapName)
                else
                    name = desc
                end
                return { distance = distance, x = data.x, y = data.y, mapId = data.mapId, name = name }
            end
        end
    elseif step.type == Journeyman.STEP_TYPE_REACH_LEVEL then
        return nil
    elseif step.type == Journeyman.STEP_TYPE_BIND_HEARTHSTONE then
        return Journeyman.DataSource:GetNearestInnkeeperLocation(data.areaId)
    elseif step.type == Journeyman.STEP_TYPE_USE_HEARTHSTONE then
        return nil
    elseif step.type == Journeyman.STEP_TYPE_LEARN_FLIGHT_PATH then
        return Journeyman.DataSource:GetFlightMasterLocation(data.taxiNodeId)
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
