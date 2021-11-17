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
            return questInfo ~= nil
        elseif step.type == Journeyman.STEP_TYPE_COMPLETE_QUEST then
            -- Check if quest is in quest log and complete
            return questInfo ~= nil and questInfo.isComplete
        elseif step.type == Journeyman.STEP_TYPE_TURNIN_QUEST then
            -- Check if quest is turned-in (redundancy)
            return C_QuestLog.IsQuestFlaggedCompleted(step.data)
        end
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
    -- Optimization: early exit if shown step count is reached
    if Journeyman.db.profile.window.stepsShown > 0 and State.stepShownCount >= Journeyman.db.profile.window.stepsShown then
        return false
    end

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
                return step
            end
        end
    end
end

function State:Initialize()
    self.ticker = C_Timer.NewTicker(Journeyman.db.profile.advanced.updateFrequency, function()
        if self.needUpdate then self:UpdateImmediate() end
    end)
end

function State:Shutdown()
    self.ticker:Cancel()
end

function State:Reset(immediate, postUpdateCallback)
    self.steps = nil
    self:Update(immediate, postUpdateCallback)
end

function State:Update(immediate, postUpdateCallback)
    self.needUpdate = true
    if self.postUpdateCallback == nil and postUpdateCallback then
        self.postUpdateCallback = postUpdateCallback
    end
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
    self.stepShownCount = 0
    for i = 1, #self.steps do
        local step = self.steps[i]
        -- Quest steps isComplete can regress (e.g. when abandoning or failing), always reset it
        if step.isComplete == nil or Journeyman:IsStepTypeQuest(step) then
            step.isComplete = IsStepComplete(step)
        else -- Other steps isComplete cannot regress, set it if not already set
            step.isComplete = step.isComplete or IsStepComplete(step)
        end
        step.isShown = IsStepShown(step)
        if not step.isComplete and step.isShown then
            self.stepShownCount = self.stepShownCount + 1
        end
    end
    self.needUpdate = false

    local elapsed = (GetTimePreciseSec() - now) * 1000
    if elapsed > 20 then
        Journeyman:Debug("State update took %.2fms", elapsed)
    end

    -- Run post update callback
    if self.postUpdateCallback and type(self.postUpdateCallback) == "function" then
        self.postUpdateCallback()
        self.postUpdateCallback = nil
    end

    -- Things to update only if window is shown
    if not self.needUpdate and Journeyman.db.char.window.show then
        -- Update window
        Journeyman.Window:UpdateImmediate()

        -- Update waypoint arrow
        if Journeyman.waypointNeedUpdate then
            if Journeyman.db.profile.autoSetWaypoint and not UnitOnTaxi("player") then
                Journeyman:SetWaypoint(self:GetCurrentStep(), false, true)
            end
            Journeyman.waypointNeedUpdate = false
        end

        -- Update targeting macro
        if Journeyman.macroNeedUpdate then
            Journeyman:SetMacro()
        end
    end
end

function State:OnQuestAccepted(questId)
    self:Update(false, function()
        local step = FindStep(Journeyman.STEP_TYPE_ACCEPT_QUEST, questId)
        if step then
            step.isComplete = true
            step.isShown = IsStepShown(step)
            self:OnStepComplete()
        end
    end)
end

function State:OnQuestCompleted(questId)
    self:Update(false, function()
        local step = FindStep(Journeyman.STEP_TYPE_COMPLETE_QUEST, questId)
        if step then
            step.isComplete = true
            step.isShown = IsStepShown(step)
            self:OnStepComplete()
        end
    end)
end

function State:OnQuestTurnedIn(questId)
    self:Update(false, function()
        local step = FindStep(Journeyman.STEP_TYPE_TURNIN_QUEST, questId)
        if step then
            step.isComplete = true
            step.isShown = IsStepShown(step)
            self:OnStepComplete()
        end
    end)
end

function State:OnQuestAbandoned(questId)
    self:Update()
end

function State:OnLevelUp(level)
    self:Update(false, function()
        local step = FindStep(Journeyman.STEP_TYPE_REACH_LEVEL, level)
        if step then
            step.isComplete = true
            step.isShown = IsStepShown(step)
            self:OnStepComplete()
        end
    end)
end

function State:OnHearthstoneBound(areaId)
    self:Update(false, function()
        local step = FindStep(Journeyman.STEP_TYPE_BIND_HEARTHSTONE, areaId)
        if step then
            step.isComplete = true
            step.isShown = IsStepShown(step)
            self:OnStepComplete()
        end
    end)
end

function State:OnHearthstoneUsed(areaId)
    self:Update(false, function()
        local step = FindStep(Journeyman.STEP_TYPE_USE_HEARTHSTONE, areaId)
        if step then
            step.isComplete = true
            step.isShown = IsStepShown(step)
            self:OnStepComplete()
        end
    end)
end

function State:OnLearnFlightPath(taxiNodeId)
    self:Update(false, function()
        local step = FindStep(Journeyman.STEP_TYPE_LEARN_FLIGHT_PATH, taxiNodeId)
        if step then
            step.isComplete = true
            step.isShown = IsStepShown(step)
            self:OnStepComplete()
        end
    end)
end

function State:OnTakeFlightPath(taxiNodeId)
    self:Update(false, function()
        local step = FindStep(Journeyman.STEP_TYPE_FLY_TO, taxiNodeId)
        if step then
            step.isComplete = true
            step.isShown = IsStepShown(step)
            self:OnStepComplete()
        end
    end)
end

function State:OnStepComplete()
    Journeyman:UpdateMacro()
    Journeyman:UpdateWaypoint()

    -- Check if chapter is complete
    local currentStep = self:GetCurrentStep()
    if currentStep == nil and #self.steps > 0 then
        local isChapterComplete = true
        for i = 1, #self.steps do
            local step = self.steps[i]
            if not step.isComplete then
                isChapterComplete = false
                break
            end
        end
        if isChapterComplete then
            self:OnChapterComplete()
        else
            self:Update()
        end
    end
end

function State:OnChapterComplete()
    local journey = Journeyman.Journey:GetActiveJourney()
    if journey then
        Journeyman.Journey:AdvanceChapter(journey)
        self:Reset()
    end
end

function State:GetCurrentStep()
    if self.steps then
        for i = 1, #self.steps do
            local step = self.steps[i]
            if not step.isComplete and step.isShown then
                return step
            end
        end
    end
end

function State:GetStepLocation(step, neededObjectivesOnly)
    if step.type == Journeyman.STEP_TYPE_ACCEPT_QUEST then
        return Journeyman.DataSource:GetNearestQuestStarter(step.data)
    elseif step.type == Journeyman.STEP_TYPE_COMPLETE_QUEST then
        return Journeyman.DataSource:GetNearestQuestObjective(step.data, neededObjectivesOnly)
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
