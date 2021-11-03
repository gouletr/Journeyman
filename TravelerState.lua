local addonName, addon = ...
local Traveler = addon.Traveler
local L = addon.Locale
local State = {}
Traveler.State = State

local function IsStepComplete(step)
    if Traveler:IsStepQuest(step) then
        -- Check if quest is already turned-in
        if C_QuestLog.IsQuestFlaggedCompleted(step.data) then
            return true
        end

        -- Check if quest is exclusive to some other quests
        local exclusiveTo = Traveler.DataSource:GetQuestExclusiveTo(step.data)
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
        if step.type == Traveler.STEP_TYPE_ACCEPT_QUEST then
            -- Check if quest is in quest log
            return questInfo ~= nil
        elseif step.type == Traveler.STEP_TYPE_COMPLETE_QUEST then
            -- Check if quest is in quest log and complete
            return questInfo ~= nil and questInfo.isComplete
        elseif step.type == Traveler.STEP_TYPE_TURNIN_QUEST then
            -- Check if quest is turned-in (redundancy)
            return C_QuestLog.IsQuestFlaggedCompleted(step.data)
        end
    else
        if step.type == Traveler.STEP_TYPE_BIND_HEARTHSTONE then
            -- Check if current bind location match
            return GetBindLocation() == step.data
        end

        -- If next step is complete, consider this step complete
        if step.type == Traveler.STEP_TYPE_FLY_TO or step.type == Traveler.STEP_TYPE_BIND_HEARTHSTONE then
            local nextState = State.steps[step.index + 1]
            if nextStep then
                return IsStepComplete(nextStep)
            end
        end
    end

    Traveler:Error("Step type %s not implemented.", step.type)
end

local function FindStep(type, data)
    for _, step in ipairs(State.steps) do
        if step.type == type and step.data == data then
            return step
        end
    end
end

function State:Initialize()
    self.ticker = C_Timer.NewTicker(Traveler.db.profile.advanced.updateFrequency, function()
        if self.needUpdate then self:UpdateImmediate() end
    end)
end

function State:Shutdown()
    self.ticker:Cancel()
end

function State:Reset(immediate)
    self.steps = nil
    self:Update(immediate)
end

function State:ResetIsComplete()
    if self.steps == nil then
        return
    end

    for i = 1, #self.steps do
        local step = self.steps[i]
        if step then
            step.isComplete = nil
        end
    end

    self:Update()
end

function State:Update(immediate)
    self.needUpdate = true
    if immediate then
        self:UpdateImmediate()
    end
end

function State:UpdateImmediate()
    if not Traveler.DataSource.IsInitialized() then return end

    local now = GetTimePreciseSec()

    -- Clone steps
    if self.steps == nil then
        self.steps = {}
        local journey = Traveler:GetActiveJourney()
        local chapter = Traveler:GetActiveChapter(journey)
        if chapter then
            local index = 1
            for _, step in ipairs(chapter.steps or {}) do
                -- Skip undefined steps
                if step.type and step.data and step.type ~= Traveler.STEP_TYPE_UNDEFINED then
                    -- Check if step is ever doable
                    local doable = true
                    if Traveler:IsStepQuest(step) then
                        doable = Traveler.DataSource:GetQuestHasRequiredRace(step.data) and Traveler.DataSource:GetQuestHasRequiredClass(step.data)
                    end

                    -- Clone step only if ever doable
                    if doable then
                        self.steps[index] = Traveler.Utils:Clone(step)
                        self.steps[index].index = index
                        index = index + 1
                    end
                end
            end
        end
    end

    -- Get current quest log
    self:UpdateQuestLog()

    -- Find first incomplete step index
    local firstIncompleteStepIndex = 1
    for i, step in ipairs(self.steps) do
        if step.isComplete == nil or not step.isComplete then
            break
        end
        firstIncompleteStepIndex = firstIncompleteStepIndex + 1
    end

    -- Determine first step index
    local firstStepIndex = 1
    if not Traveler.db.profile.window.showCompletedSteps then
        firstStepIndex = firstIncompleteStepIndex
    end

    -- Find last incomplete step index
    local lastStepIndex = #self.steps
    if Traveler.db.profile.window.stepsShown > 0 then
        local count = 0
        local lastIncompleteStepIndex = firstStepIndex
        for i = firstStepIndex, #self.steps do
            local step = self.steps[i]
            lastIncompleteStepIndex = i
            if step.isComplete ~= nil and not step.isComplete then
                count = count + 1
            end
            if count == Traveler.db.profile.window.stepsShown then
                break
            end
        end
        lastStepIndex = lastIncompleteStepIndex
    end

    -- Update step range
    Traveler:Debug("Updating step range %d to %d", firstStepIndex, lastStepIndex)
    for i = firstStepIndex, lastStepIndex do
        local step = self.steps[i]
        if step then
            step.isComplete = IsStepComplete(step)
            if step.location == nil then
                step.location = self:GetStepLocation(step)
            end
        end
    end

    self.needUpdate = false

    Traveler:Debug("State update took %.2fms", (GetTimePreciseSec() - now) * 1000)
    Traveler.Tracker:UpdateImmediate()
end

function State:UpdateQuestLog()
    self.currentQuestLog = {}
    local entriesCount = Traveler:GetQuestLogNumEntries()
    for i = 1, entriesCount do
        local info = Traveler:GetQuestLogInfo(i)
        if info and not info.isHeader then
            self.currentQuestLog[info.questId] = {
                isComplete = info.isComplete
            }
        end
    end
end

function State:OnQuestAccepted(questId)
    local step = FindStep(Traveler.STEP_TYPE_ACCEPT_QUEST, questId)
    if step then
        step.isComplete = true
    end
    self:Update()
end

function State:OnQuestCompleted(questId)
    local step = FindStep(Traveler.STEP_TYPE_COMPLETE_QUEST, questId)
    if step then
        step.isComplete = true
    end
    self:Update()
end

function State:OnQuestTurnedIn(questId)
    local step = FindStep(Traveler.STEP_TYPE_TURNIN_QUEST, questId)
    if step then
        step.isComplete = true
    end
    self:Update()
end

function State:OnQuestAbandoned(questId)
    self:ResetIsComplete()
end

function State:OnHearthstoneBound(location)
    local step = FindStep(Traveler.STEP_TYPE_BIND_HEARTHSTONE, location)
    if step then
        step.isComplete = true
    end
    self:Update()
end

function State:GetStepLocation(step)
    if step.type == Traveler.STEP_TYPE_ACCEPT_QUEST then
        return Traveler.DataSource:GetNearestQuestStarter(step.data)
    elseif step.type == Traveler.STEP_TYPE_COMPLETE_QUEST then
        return Traveler.DataSource:GetNearestQuestObjective(step.data)
    elseif step.type == Traveler.STEP_TYPE_TURNIN_QUEST then
        return Traveler.DataSource:GetNearestQuestFinisher(step.data)
    elseif step.type == Traveler.STEP_TYPE_FLY_TO then
        return Traveler.DataSource:GetNearestFlightMaster()
    elseif step.type == Traveler.STEP_TYPE_BIND_HEARTHSTONE then
        return Traveler.DataSource:GetInnkeeperLocation(step.data)
    else
        Traveler:Error("Step type %s not implemented.", step.type)
    end
end

function State:GetQuestLogInfo(questId)
    return self.currentQuestLog[questId]
end
