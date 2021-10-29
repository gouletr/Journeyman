local addonName, addon = ...
local L = addon.Locale
local Traveler = addon.Traveler

local State = {}
Traveler.State = State

local function IsStepComplete(stepIndex, step)
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
        end
    else
        if step.type == Traveler.STEP_TYPE_BIND_HEARTHSTONE then
            -- Check if current bind location match
            if GetBindLocation() == step.data then
                return true
            end
        end

        -- If next step is complete, consider this step complete
        local nextStep = State.chapter.steps[stepIndex + 1]
        if nextStep ~= nil then
            return IsStepComplete(nextStep, stepIndex + 1)
        end
    end
    return false
end

local function GetStepLocation(step)
    if step.type == Traveler.STEP_TYPE_ACCEPT_QUEST then
        return Traveler.DataSource:GetNearestQuestStarter(step.data)
    elseif step.type == Traveler.STEP_TYPE_COMPLETE_QUEST then
        -- todo
    elseif step.type == Traveler.STEP_TYPE_TURNIN_QUEST then
        return Traveler.DataSource:GetNearestQuestFinisher(step.data)
    elseif step.type == Traveler.STEP_TYPE_FLY_TO then
        --todo
    elseif step.type == Traveler.STEP_TYPE_BIND_HEARTHSTONE then
        --todo
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
    if self.journey == nil then return end

    self.chapter = Traveler:GetActiveChapter(self.journey)
    if self.chapter == nil then return end

    self:Update()
end

function State:Update()
    self.needUpdate = true
end

function State:UpdateImmediate()
    if not Traveler.DataSource.IsInitialized() then return end

    if self.journey == nil or self.chapter == nil then
        self.needUpdate = false
        return
    end

    local now = GetTimePreciseSec()

    self.currentQuestLog = {}
    local entriesCount = Traveler:GetQuestLogNumEntries()
    for i = 1, entriesCount do
        local info = Traveler:GetQuestLogInfo(i)
        if info ~= nil and not info.isHeader then
            State.currentQuestLog[info.questId] = {
                isComplete = info.isComplete
            }
        end
    end

    for i, step in ipairs(self.chapter.steps) do
        local state = self.steps[i]
        if state == nil then
            self.steps[i] = {
                step = step,
                isComplete = IsStepComplete(i, step),
                location = GetStepLocation(step)
            }
        else
            state.isComplete = IsStepComplete(i, step)
        end
    end

    Traveler:Debug("State update took %.2fms", (GetTimePreciseSec() - now) * 1000)

    Traveler.Tracker:UpdateImmediate()
    self.needUpdate = false
end

function State:OnQuestAccepted(questId)
    self:SetStepComplete({ type = Traveler.STEP_TYPE_ACCEPT_QUEST, data = questId })
end

function State:OnQuestTurnedIn(questId)
    self:SetStepComplete({ type = Traveler.STEP_TYPE_TURNIN_QUEST, data = questId })
end

function State:OnQuestAbandoned(questId)
    self:Update()
end

function State:OnQuestLogUpdate()
    self:Update()
end

function State:OnHearthstoneBound(location)
    self:SetStepComplete({ type = Traveler.STEP_TYPE_BIND_HEARTHSTONE, data = location })
end

function State:SetStepComplete(step)
    for i, state in ipairs(self.steps) do
        if not state.isComplete then
            if state.step.type == step.type and state.step.data == step.data then
                state.isComplete = true
                self:Update()
                return
            end
        end
    end
end
