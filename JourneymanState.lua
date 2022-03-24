local addonName, addon = ...
local Journeyman = addon.Journeyman
local L = addon.Locale
local State = {}
Journeyman.State = State

local HBD = LibStub("HereBeDragons-2.0")

local function IsStepComplete(step)
    if Journeyman:IsStepTypeQuest(step) then
        -- Check if quest is already turned-in
        if C_QuestLog.IsQuestFlaggedCompleted(step.data) then
            return true
        end

        -- Check if quest is exclusive to some other quests
        local exclusiveTo = Journeyman.DataSource:GetQuestExclusiveTo(step.data)
        if exclusiveTo ~= nil then
            for _, questId in ipairs(exclusiveTo) do
                -- Check if exclusive quest is in quest log or already turned-in
                if State.currentQuestLog[questId] ~= nil or C_QuestLog.IsQuestFlaggedCompleted(questId) then
                    return true -- Quest is unobtainable, consider complete
                end
            end
        end

        -- Per quest step type checks
        local questInfo = State.currentQuestLog[step.data]
        if step.type == Journeyman.STEP_TYPE_ACCEPT_QUEST then
            -- Check if quest is in quest log
            if questInfo ~= nil then
                return true
            end
        elseif step.type == Journeyman.STEP_TYPE_COMPLETE_QUEST then
            -- Check if quest is in quest log and complete
            if questInfo ~= nil and questInfo.isComplete then
                return true
            end
        elseif step.type == Journeyman.STEP_TYPE_TURNIN_QUEST then
            -- Check if quest is turned-in (redundancy)
            if C_QuestLog.IsQuestFlaggedCompleted(step.data) then
                return true
            end
        end

        -- Check if quest is repeatable
        if Journeyman.DataSource:IsQuestRepeatable(step.data) then
            -- If next step is complete, consider this step complete
            local nextStep = State.steps[step.index + 1]
            if nextStep and IsStepComplete(nextStep) then
                return true
            end
        end

        return false
    else
        if step.type == Journeyman.STEP_TYPE_REACH_LEVEL then
            return UnitLevel("player") >= step.data
        elseif step.type == Journeyman.STEP_TYPE_BIND_HEARTHSTONE then
            -- Check if current bind location match
            if GetBindLocation() == Journeyman:GetAreaName(step.data) then
                return true
            end
        elseif step.type == Journeyman.STEP_TYPE_USE_HEARTHSTONE then
            -- Check if current bind location match and hearthstone is on cooldown
            local startTime, duration, enable = GetItemCooldown(Journeyman.ITEM_HEARTHSTONE)
            local cooldownLeft = duration - (GetTime() - startTime)
            if cooldownLeft > 0 and GetBindLocation() == Journeyman:GetAreaName(step.data) then
                return true
            end
        elseif step.type == Journeyman.STEP_TYPE_FLY_TO then
            -- Check if we are currently flying to that taxiNodeId
            if Journeyman.flyingTo == step.data and UnitOnTaxi("player") then
                return true
            end

            -- Check if we are in same map as taxiNodeId
            local taxiNodeWorldCoords = Journeyman:GetTaxiNodeWorldCoordinates(step.data)
            if taxiNodeWorldCoords then
                local x, y = HBD:GetZoneCoordinatesFromWorld(taxiNodeWorldCoords[1], taxiNodeWorldCoords[2], C_Map.GetBestMapForUnit("player"), false)
                if x and y then -- If we have coordinates, it means we are in same zone
                    return true
                end
            end
        end

        -- If next step is complete, consider this step complete
        if step.type == Journeyman.STEP_TYPE_BIND_HEARTHSTONE or step.type == Journeyman.STEP_TYPE_USE_HEARTHSTONE or step.type == Journeyman.STEP_TYPE_LEARN_FLIGHT_PATH or step.type == Journeyman.STEP_TYPE_FLY_TO then
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
            local questId = Journeyman.DataSource:GetQuestChainStartQuest(step.data)
            if Journeyman.DataSource:IsQuestNPCDrop(questId) and not State:IsQuestInQuestLog(questId) and not C_QuestLog.IsQuestFlaggedCompleted(questId) then
                showStep = false
            end
        end
    end

    return showStep
end

local function FindStep(type, data)
    if State.steps then
        for i = 1, #State.steps do
            local step = State.steps[i]
            if step.type == type and step.data == data then
                -- If step type is not unique, check if it has complete override
                if step.type == Journeyman.STEP_TYPE_BIND_HEARTHSTONE or step.type == Journeyman.STEP_TYPE_USE_HEARTHSTONE or step.type == Journeyman.STEP_TYPE_FLY_TO then
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
                    if Journeyman:IsStepTypeQuest(step) then
                        doable = doable and Journeyman.DataSource:IsQuestAvailable(step.data)
                        doable = doable and Journeyman.DataSource:GetQuestHasRequiredRace(step.data)
                        doable = doable and Journeyman.DataSource:GetQuestHasRequiredClass(step.data)
                    elseif step.type == Journeyman.STEP_TYPE_BIND_HEARTHSTONE or step.type == Journeyman.STEP_TYPE_USE_HEARTHSTONE then
                        doable = doable and Journeyman.DataSource:GetNearestInnkeeperLocation(step.data) ~= nil
                    elseif step.type == Journeyman.STEP_TYPE_LEARN_FLIGHT_PATH or step.type == Journeyman.STEP_TYPE_FLY_TO then
                        doable = doable and Journeyman:IsTaxiNodeAvailable(step.data)
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

    -- Update current quest log
    local questLog = Journeyman:GetQuestLog()
    if questLog then
        if self.currentQuestLog then
            -- Compare new quest log with current, to see if any quest got completed
            for questId, info in pairs(questLog) do
                local currentInfo = self.currentQuestLog[questId]
                if currentInfo and not currentInfo.isComplete and not currentInfo.isFailed then
                    if info and info.isComplete and not info.isFailed then
                        Journeyman:OnQuestCompleted(questId)
                    end
                end
            end
        end
        self.currentQuestLog = questLog
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
    self:OnStepCompleted(Journeyman.STEP_TYPE_ACCEPT_QUEST, questId)
end

function State:OnQuestCompleted(questId)
    self:OnStepCompleted(Journeyman.STEP_TYPE_COMPLETE_QUEST, questId)
end

function State:OnQuestTurnedIn(questId)
    self:OnStepCompleted(Journeyman.STEP_TYPE_TURNIN_QUEST, questId)
end

function State:OnQuestAbandoned(questId)
    -- Reset isCompleteOverride for all steps related to this quest
    if self.steps then
        for i = 1, #self.steps do
            local step = self.steps[i]
            if step and Journeyman:IsStepTypeQuest(step) and step.data == questId then
                step.isCompleteOverride = false
            end
        end
    end
    Journeyman:Update()
end

function State:OnLevelUp(level)
    self:OnStepCompleted(Journeyman.STEP_TYPE_REACH_LEVEL, level)
end

function State:OnHearthstoneBound(areaId)
    self:OnStepCompleted(Journeyman.STEP_TYPE_BIND_HEARTHSTONE, areaId)
end

function State:OnHearthstoneUsed(areaId)
    self:OnStepCompleted(Journeyman.STEP_TYPE_USE_HEARTHSTONE, areaId)
end

function State:OnLearnFlightPath(taxiNodeId)
    self:OnStepCompleted(Journeyman.STEP_TYPE_LEARN_FLIGHT_PATH, taxiNodeId)
end

function State:OnTakeFlightPath(taxiNodeId)
    self:OnStepCompleted(Journeyman.STEP_TYPE_FLY_TO, taxiNodeId)
end

function State:OnStepCompleted(type, data)
    local step = FindStep(type, data)
    if step == nil then return end

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
        return Journeyman.DataSource:GetNearestQuestStarter(step.data)
    elseif step.type == Journeyman.STEP_TYPE_COMPLETE_QUEST then
        return Journeyman.DataSource:GetNearestQuestObjective(step.data, step.objectiveIndex)
    elseif step.type == Journeyman.STEP_TYPE_TURNIN_QUEST then
        return Journeyman.DataSource:GetNearestQuestFinisher(step.data)
    elseif step.type == Journeyman.STEP_TYPE_REACH_LEVEL then
        return nil
    elseif step.type == Journeyman.STEP_TYPE_BIND_HEARTHSTONE then
        return Journeyman.DataSource:GetNearestInnkeeperLocation(step.data)
    elseif step.type == Journeyman.STEP_TYPE_USE_HEARTHSTONE then
        return nil
    elseif step.type == Journeyman.STEP_TYPE_LEARN_FLIGHT_PATH then
        return Journeyman.DataSource:GetFlightMasterLocation(step.data)
    elseif step.type == Journeyman.STEP_TYPE_FLY_TO then
        return Journeyman.DataSource:GetNearestFlightMasterLocation()
    else
        Journeyman:Error("Step type %s not implemented.", step.type)
    end
end

function State:GetQuestLogInfo(questId)
    return self.currentQuestLog[questId]
end

function State:IsQuestInQuestLog(questId)
    return self.currentQuestLog[questId] ~= nil
end
