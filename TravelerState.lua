local addonName, addon = ...
local L = addon.Locale
local Traveler = addon.Traveler

local State = {}
Traveler.State = State

local function IsStepComplete(state)
    if Traveler:IsStepQuest(state.step) then
        -- Check if quest is already turned-in
        if C_QuestLog.IsQuestFlaggedCompleted(state.step.data) then
            return true
        end

        -- Check if quest is exclusive to some other quests
        local exclusiveTo = Traveler.DataSource:GetQuestExclusiveTo(state.step.data)
        if exclusiveTo ~= nil then
            for _, questId in ipairs(exclusiveTo) do
                -- Check if exclusive quest is in quest log or already turned-in
                if State.currentQuestLog[questId] ~= nil or C_QuestLog.IsQuestFlaggedCompleted(questId) then
                    return true -- Quest is unobtainable, consider complete
                end
            end
        end

        -- Per quest step type checks
        local questInfo = State.currentQuestLog[state.step.data]
        if state.step.type == Traveler.STEP_TYPE_ACCEPT_QUEST then
            -- Check if quest is in quest log
            return questInfo ~= nil
        elseif state.step.type == Traveler.STEP_TYPE_COMPLETE_QUEST then
            -- Check if quest is in quest log and complete
            return questInfo ~= nil and questInfo.isComplete
        end
    else
        if state.step.type == Traveler.STEP_TYPE_BIND_HEARTHSTONE then
            -- Check if current bind location match
            if GetBindLocation() == state.step.data then
                return true
            end
        end

        -- If next step is complete, consider this step complete
        local nextState = State.steps[state.index + 1]
        if nextStep then
            return IsStepComplete(nextStep)
        end
    end
    return false
end

local function FindState(type, data)
    for _, state in ipairs(State.steps) do
        if state.step.type == type and state.step.data == data then
            return state
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

function State:Reset()
    self.steps = {}
    self.journey = Traveler:GetActiveJourney()
    self.chapter = Traveler:GetActiveChapter(self.journey)

    if self.chapter then
        for i, step in ipairs(self.chapter.steps or {}) do
            self.steps[i] = {
                step = step,
                index = i
            }
        end
    end

    self:Update()
end

function State:Update()
    self.needUpdate = true
end

function State:UpdateImmediate()
    if not Traveler.DataSource.IsInitialized() then return end

    if self.journey and self.chapter then
        local now = GetTimePreciseSec()

        -- Get current quest log
        self.currentQuestLog = {}
        local entriesCount = Traveler:GetQuestLogNumEntries()
        for i = 1, entriesCount do
            local info = Traveler:GetQuestLogInfo(i)
            if info and not info.isHeader then
                State.currentQuestLog[info.questId] = {
                    isComplete = info.isComplete
                }
            end
        end

        -- Find first incomplete step index
        local firstStepIndex = 1
        if not Traveler.db.profile.window.showCompletedSteps then
            for i, state in ipairs(self.steps) do
                if not state.isComplete then
                    firstStepIndex = i
                    break
                end
            end
        end

        -- Update steps range state
        Traveler:Debug("Updating state range %d to %d", firstStepIndex, #self.steps)
        for i = firstStepIndex, #self.steps do
            local state = self.steps[i]
            state.isComplete = IsStepComplete(state)
            state.location = self:GetStepLocation(state.step)
        end

        Traveler:Debug("State update took %.2fms", (GetTimePreciseSec() - now) * 1000)
    end
    self.needUpdate = false

    Traveler.Tracker:UpdateImmediate()
end

function State:OnQuestAccepted(questId)
    local state = FindState(Traveler.STEP_TYPE_ACCEPT_QUEST, questId)
    if state then
        state.isComplete = true
    end
    self:Update()
end

function State:OnQuestProgress(questId)
    local state = FindState(Traveler.STEP_TYPE_COMPLETE_QUEST, questId)
    if state then
        state.isComplete = IsStepComplete(state)
    end
    self:Update()
end

function State:OnQuestTurnedIn(questId)
    local state = FindState(Traveler.STEP_TYPE_TURNIN_QUEST, questId)
    if state then
        state.isComplete = true
    end
    self:Update()
end

function State:OnQuestAbandoned(questId)
    self:Reset()
end

function State:OnHearthstoneBound(location)
    local state = FindState(Traveler.STEP_TYPE_BIND_HEARTHSTONE, location)
    if state then
        state.isComplete = true
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
    end
end
