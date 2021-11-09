local addonName, addon = ...
local Traveler = addon.Traveler
local L = addon.Locale
local State = {}
Traveler.State = State

local function IsStepComplete(step)
    if Traveler:IsStepTypeQuest(step) then
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
        elseif step.type == Traveler.STEP_TYPE_USE_HEARTHSTONE then
            -- Check if current bind location match and hearthstone is on cooldown
            local startTime, duration, enable = GetItemCooldown(Traveler.ITEM_HEARTHSTONE)
            local cooldownLeft = duration - (GetTime() - startTime)
            if cooldownLeft > 0 and GetBindLocation() == step.data then
                return true
            end
        elseif step.type == Traveler.STEP_TYPE_REACH_LEVEL then
            return UnitLevel("player") >= step.data
        end

        -- If next step is complete, consider this step complete
        if step.type == Traveler.STEP_TYPE_FLY_TO or step.type == Traveler.STEP_TYPE_BIND_HEARTHSTONE or step.type == Traveler.STEP_TYPE_USE_HEARTHSTONE then
            local nextStep = State.steps[step.index + 1]
            if nextStep then
                return IsStepComplete(nextStep)
            else
                return false
            end
        end
    end

    Traveler:Error("Step type %s not implemented.", step.type)
end

local function FindStep(type, data)
    for _, step in ipairs(State.steps or {}) do
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

function State:Reset(immediate, afterUpdateFunc)
    self.steps = nil
    self:Update(immediate, afterUpdateFunc)
end

function State:Update(immediate, afterUpdateFunc)
    self.needUpdate = true
    if afterUpdateFunc then
        self.afterUpdateFunc = afterUpdateFunc
    end
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
        local journey = Traveler.Journey:GetActiveJourney()
        local chapter = Traveler:GetActiveChapter(journey)
        if chapter then
            local index = 1
            for _, step in ipairs(chapter.steps or {}) do
                -- Skip undefined steps
                if step.type and step.type ~= Traveler.STEP_TYPE_UNDEFINED and step.data then
                    -- Check if step is ever doable
                    local doable = true
                    if Traveler:IsStepTypeQuest(step) then
                        doable = doable and Traveler.DataSource:GetQuestHasRequiredRace(step.data) == true
                        doable = doable and Traveler.DataSource:GetQuestHasRequiredClass(step.data) == true
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

    -- Update steps
    for i, step in ipairs(self.steps) do
        step.isComplete = IsStepComplete(step)
        if step.location == nil then
            step.location = self:GetStepLocation(step)
        end
    end
    self.needUpdate = false

    -- Run after update callback
    if self.afterUpdateFunc then
        self.afterUpdateFunc(self)
        if not self.needUpdate then -- Remove after update callback only if it didn't request another update
            self.afterUpdateFunc = nil
        end
    end

    local elapsed = (GetTimePreciseSec() - now) * 1000
    if elapsed > 16.6667 then
        Traveler:Debug("State update took %.2fms", elapsed)
    end

    -- Update window only if after update callback didn't request another update
    if not self.needUpdate then
        Traveler.Tracker:UpdateImmediate()
    end
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
    self:Update(false, function(self)
        local step = FindStep(Traveler.STEP_TYPE_ACCEPT_QUEST, questId)
        if step then
            step.isComplete = true
        end
        self:OnStepComplete()
    end)
end

function State:OnQuestCompleted(questId)
    self:Update(false, function(self)
        local step = FindStep(Traveler.STEP_TYPE_COMPLETE_QUEST, questId)
        if step then
            step.isComplete = true
        end
        self:OnStepComplete()
    end)
end

function State:OnQuestTurnedIn(questId)
    self:Update(false, function(self)
        local step = FindStep(Traveler.STEP_TYPE_TURNIN_QUEST, questId)
        if step then
            step.isComplete = true
        end
        self:OnStepComplete()
    end)
end

function State:OnQuestAbandoned(questId)
    self:Update()
end

function State:OnHearthstoneBound(location)
    self:Update(false, function(self)
        local step = FindStep(Traveler.STEP_TYPE_BIND_HEARTHSTONE, location)
        if step then
            step.isComplete = true
        end
        self:OnStepComplete()
    end)
end

function State:OnHearthstoneUsed(location)
    self:Update(false, function(self)
        local step = FindStep(Traveler.STEP_TYPE_USE_HEARTHSTONE, location)
        if step then
            step.isComplete = true
        end
        self:OnStepComplete()
    end)
end

function State:OnLevelUp(level)
    self:Update(false, function(self)
        local step = FindStep(Traveler.STEP_TYPE_REACH_LEVEL, level)
        if step then
            step.isComplete = true
        end
        self:OnStepComplete()
    end)
end

function State:OnStepComplete()
    local currentStep = self:GetCurrentStep()
    if currentStep then
        if Traveler.db.profile.autoSetWaypoint then
            Traveler:SetWaypoint(currentStep)
        end
        Traveler:UpdateTargetingMacro()
    elseif #self.steps > 0 then
        -- Check if chapter is complete
        local isChapterComplete = true
        for i, step in ipairs(self.steps) do
            if step.isComplete == nil or step.isComplete == false then
                isChapterComplete = false
                break
            end
        end
        if isChapterComplete then
            self:OnChapterComplete()
        end
    end
end

function State:OnChapterComplete()
    local journey = Traveler.Journey:GetActiveJourney()
    if journey then
        Traveler.Journey:AdvanceChapter(journey)
        self:Reset(false, function(self)
            if Traveler.db.profile.autoSetWaypoint then
                Traveler:SetWaypoint(self:GetCurrentStep())
            end
            Traveler:UpdateTargetingMacro()
        end)
    end
end

function State:GetCurrentStep()
    for i, step in ipairs(self.steps) do
        if step.isComplete ~= nil and step.isComplete == false then
            return step
        end
    end
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
    elseif step.type == Traveler.STEP_TYPE_USE_HEARTHSTONE then
        return nil
    elseif step.type == Traveler.STEP_TYPE_REACH_LEVEL then
        return nil
    else
        Traveler:Error("Step type %s not implemented.", step.type)
    end
end

function State:GetQuestLogInfo(questId)
    return self.currentQuestLog[questId]
end

function State:IsQuestInQuestLog(questId)
    return self.currentQuestLog[questId] ~= nil
end
