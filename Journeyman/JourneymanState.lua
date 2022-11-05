local addonName, addon = ...
local State, Private = addon:NewModule("State"), {}
local L = addon.Locale

local String = LibStub("LibCollections-1.0").String
local List = LibStub("LibCollections-1.0").List
local HBD = LibStub("HereBeDragons-2.0")
local Utils, Journeys, Events, DataSource, TaxiNodes

function State:OnInitialize()
    Utils = addon.Utils
    Journeys = addon.Journeys
    Events = addon.Events
    TaxiNodes = addon.TaxiNodes
    DataSource = addon.DataSource
    self.questsTurnedIn = {}
end

function State:OnEnable()
end

function State:OnDisable()
end

function State:CheckForUpdate()
    if self.needUpdate or self.waypointNeedUpdate or self.macroNeedUpdate then
        self:UpdateImmediate()
    end
end

function State:Reset(immediate)
    self.waypointNeedUpdate = addon.db.profile.autoSetWaypoint
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
    if not addon.worldLoaded or not DataSource:IsInitialized() then
        return
    end

    local now = GetTimePreciseSec()

    -- Store some values
    addon.player.level = UnitLevel("player")
    addon.player.xp = UnitXP("player")
    addon.player.maxXP = UnitXPMax("player")
    addon.player.greenRange = GetQuestGreenRange("player")

    -- Reset state
    self.currentStep = nil
    self.questObjectives = {}
    self.startedQuestChains = {}

    -- Get active steps
    if self.steps == nil then
        self.steps = self:GetActiveSteps()
    end

    -- Update quest log
    local questLog = addon:GetQuestLog()
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
                                Events:OnQuestObjectiveCompleted(questId, objectiveIndex)
                            end
                        end
                    end
                    -- Check if quest got completed
                    if (questInfo.isComplete and not questInfo.isFailed) and (not lastQuestInfo.isComplete and not lastQuestInfo.isFailed) then
                        Events:OnQuestCompleted(questId)
                    end
                end
            end
        end
        self.questLog = questLog
    end

    -- Update steps state
    local stepShownCount = 0
    if self.steps then
        local n = #self.steps
        for i = 1, n do
            local step = self.steps[i]

            -- Check if step is completed
            if addon:IsStepComplete(step) or addon:IsStepSkipped(step) then
                step.isComplete = true
            else
                local isComplete = self:IsStepComplete(step)
                if isComplete and not step.isComplete then
                    self:OnStepCompleted(step) -- Step got completed without OnStepCompleted called
                end
                step.isComplete = isComplete
            end

            -- Check if step is shown
            if addon.db.profile.window.stepsShown > 0 and stepShownCount >= addon.db.profile.window.stepsShown then
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

            -- Check if we reached shown step count
            if addon.db.profile.window.stepsShown > 0 and stepShownCount >= addon.db.profile.window.stepsShown then
                break
            end
        end
    end
    self.needUpdate = false

    local elapsed = (GetTimePreciseSec() - now) * 1000
    if elapsed > 20 then
        addon:Debug("State update took %.2fms", elapsed)
    end

    if self.steps and next(self.steps) and self:IsChapterComplete() then
        -- Advance to next chapter and reset state
        local journey = addon:GetActiveJourney()
        if journey then
            if not Journeys:AdvanceChapter(journey) then
                addon.db.char.journey = ""
                addon.db.char.chapter = 1
            end
            addon:Reset(true)
        end
    else
        -- Update window, waypoint and macro immediate
        if addon.db.char.window.show then
            addon.Window:UpdateImmediate()
            if self.waypointNeedUpdate then
                if addon:SetWaypoint(self.currentStep, false) then
                    self.waypointNeedUpdate = false
                end
            end
            if self.macroNeedUpdate then
                if addon:SetMacro(self.currentStep) then
                    self.macroNeedUpdate = false
                end
            end
        end
    end
end

function State:GetActiveSteps()
    local steps = {}
    local chapter = addon:GetActiveJourneyChapter()
    if chapter and type(chapter) == "table" then
        -- Clone active steps
        local index = 1
        for i = 1, #chapter.steps or {} do
            local step = chapter.steps[i]
            if step.type and step.type ~= addon.STEP_TYPE_UNDEFINED and step.data then
                local data = addon:GetStepData(step)
                if data then
                    local clonedStep = Utils:Clone(step)
                    clonedStep.data = data

                    local isAvailable, reason = self:IsStepAvailable(clonedStep)
                    if isAvailable then
                        clonedStep.index = index
                        clonedStep.indexInChapter = i
                        clonedStep.isComplete = false
                        clonedStep.isShown = true
                        steps[index] = clonedStep
                        index = index + 1
                    else
                        --addon:Debug("Step %s %s not available: %s", step.type, step.data, reason)
                    end
                end
            end
        end

        -- Initialize state
        for i = 1, #steps do
            local step = steps[i]
            if not addon:IsStepComplete(step) and self:IsStepComplete(step) then
                addon:SetStepStateCompleted(step, true)
            end
            if step.type == addon.STEP_TYPE_TURNIN_QUEST and addon:IsStepComplete(step) then
                self:SetQuestTurnedIn(step.data.questId)
            end
        end
    end
    return steps
end

function State:FindStep(predicate)
    if predicate then
        if self.currentStep and predicate(self.currentStep) then
            return self.currentStep
        end
        if self.steps then
            return List:First(self.steps, predicate)
        end
    end
end

function State:OnQuestAccepted(questId)
    local step = self:FindStep(function(s) return s.type == addon.STEP_TYPE_ACCEPT_QUEST and s.data.questId == questId end)
    if step then
        self:OnStepCompleted(step)
    end
end

function State:OnQuestCompleted(questId)
    local step = self:FindStep(function(s) return s.type == addon.STEP_TYPE_COMPLETE_QUEST and s.data.questId == questId end)
    if step then
        self:OnStepCompleted(step)
    end
end

function State:OnQuestObjectiveCompleted(questId, objectiveIndex)
    local step = self:FindStep(function(s)
        if s.type == addon.STEP_TYPE_COMPLETE_QUEST and s.data.questId == questId then
            if s.objectives then
                return List:Contains(s.objectives, objectiveIndex)
            else
                return true
            end
        end
    end)
    if step then
        if self:IsStepAllQuestObjectivesComplete(step) then
            self:OnStepCompleted(step)
        else
            self.waypointNeedUpdate = addon.db.profile.autoSetWaypoint
            self.macroNeedUpdate = true
            addon:Update()
        end
    end
end

function State:OnQuestTurnedIn(questId)
    local step = self:FindStep(function(s) return s.type == addon.STEP_TYPE_TURNIN_QUEST and s.data.questId == questId end)
    if step then
        self:OnStepCompleted(step)
    end
end

function State:OnQuestAbandoned(questId)
    -- Reset state for all steps related to this quest
    if self.steps then
        List:ForEach(self.steps, function(step)
            if addon:IsStepTypeQuest(step) and step.data.questId == questId then
                addon:ResetStepState(step)
            end
        end)
    end
    addon:Update()
end

function State:OnLevelUp(level)
    local step = self:FindStep(function(s) return s.type == addon.STEP_TYPE_REACH_LEVEL and s.data.level == level and s.data.xp == nil end)
    if step then
        self:OnStepCompleted(step)
    end
end

function State:OnLevelXPReached(step)
    self:OnStepCompleted(step)
end

function State:OnReputationReached(step)
    self:OnStepCompleted(step)
end

function State:OnHearthstoneBound(areaId)
    local step = self.currentStep
    if step and step.type == addon.STEP_TYPE_BIND_HEARTHSTONE and step.data.areaId == areaId then
        self:OnStepCompleted(step)
    end
end

function State:OnHearthstoneUsed(areaId)
    local step = self.currentStep
    if step and step.type == addon.STEP_TYPE_USE_HEARTHSTONE and step.data.areaId == areaId then
        self:OnStepCompleted(step)
    end
end

function State:OnLearnFlightPath(taxiNodeId)
    local step = self:FindStep(function(s) return s.type == addon.STEP_TYPE_LEARN_FLIGHT_PATH and s.data.taxiNodeId == taxiNodeId end)
    if step then
        self:OnStepCompleted(step)
    end
end

function State:OnTakeFlightPath(taxiNodeId)
    local step = self.currentStep
    if step and step.type == addon.STEP_TYPE_FLY_TO and step.data.taxiNodeId == taxiNodeId then
        self:OnStepCompleted(step)
    end
end

function State:OnClassTrainerClosed()
    local step = self.currentStep
    if step and step.type == addon.STEP_TYPE_TRAIN_CLASS then
        self:OnStepCompleted(step)
    end
end

function State:OnSpellLearned(spellId)
    local step
    if spellId == addon.SPELL_FIRST_AID_APPRENTICE then
        step = self:FindStep(function(s) return s.type == addon.STEP_TYPE_LEARN_FIRST_AID end)
    elseif spellId == addon.SPELL_COOKING_APPRENTICE then
        step = self:FindStep(function(s) return s.type == addon.STEP_TYPE_LEARN_COOKING end)
    elseif spellId == addon.SPELL_FISHING_APPRENTICE then
        step = self:FindStep(function(s) return s.type == addon.STEP_TYPE_LEARN_FISHING end)
    else
        step = self:FindStep(function(s) return s.type == addon.STEP_TYPE_TRAIN_SPELLS and List:Contains(s.spells, spellId) end)
    end
    if step then
        self:OnStepCompleted(step)
    end
end

function State:OnSpellCast(spellId)
end

function State:OnSpiritResurrection()
    local step = self.currentStep
    if step and step.type == addon.STEP_TYPE_DIE_AND_RES then
        self:OnStepCompleted(step)
    end
end

function State:OnStepCompleted(step, immediate)
    self.waypointNeedUpdate = addon.db.profile.autoSetWaypoint
    self.macroNeedUpdate = true

    -- Mark step as completed
    addon:SetStepStateCompleted(step, true)
    step.isComplete = true
    step.isShown = false
    if step.type == addon.STEP_TYPE_TURNIN_QUEST then
        self:SetQuestTurnedIn(step.data.questId)
    end

    -- Display step complete message
    if not addon:IsStepTypeQuest(step) and step.type ~= addon.STEP_TYPE_LEARN_FLIGHT_PATH then
        local text = addon:GetStepText(step, false, false)
        if not String:IsNilOrEmpty(text) then
            UIErrorsFrame:AddMessage(string.format("Step: %s (%s)", text, "Complete"), YELLOW_FONT_COLOR:GetRGB())
        end
    end

    addon:Update(immediate)
end

function State:OnStepSkipped(step, immediate)
    self.waypointNeedUpdate = addon.db.profile.autoSetWaypoint
    self.macroNeedUpdate = true

    -- Mark step as skipped
    addon:SetStepStateSkipped(step, true)
    step.isComplete = true
    step.isShown = false
    if step.type == addon.STEP_TYPE_TURNIN_QUEST then
        self:SetQuestTurnedIn(step.data.questId)
    end

    addon:Update(immediate)
end

function State:OnStepReset(step, immediate)
    self.waypointNeedUpdate = addon.db.profile.autoSetWaypoint
    self.macroNeedUpdate = true

    -- Reset step completed state
    addon:ResetStepState(step)
    step.isComplete = false
    step.isShown = true

    addon:Update(immediate)
end

function State:IsStepAvailable(step)
    if addon.db.char.hardcoreMode and step.type == addon.STEP_TYPE_DIE_AND_RES then
        return false
    end

    if step.requiredRaces and bit.band(step.requiredRaces, addon.player.raceMask) == 0 then
        return false
    end

    if step.requiredClasses and bit.band(step.requiredClasses, addon.player.classMask) == 0 then
        return false
    end

    if addon:IsStepTypeQuest(step) then
        return self:IsQuestAvailable(step.data.questId)
    elseif step.type == addon.STEP_TYPE_FLY_TO then
        return TaxiNodes:IsAvailable(step.data.taxiNodeId, addon.player.factionName)
    end

    return true
end

function State:IsStepDoable(step)
    if addon:IsStepTypeQuest(step) then
        return self:IsQuestDoable(step.data.questId, step.type == addon.STEP_TYPE_COMPLETE_QUEST)
    elseif step.type == addon.STEP_TYPE_BIND_HEARTHSTONE then
        return DataSource:GetNearestInnkeeperLocation(step.data.areaId) ~= nil
    elseif step.type == addon.STEP_TYPE_LEARN_FLIGHT_PATH then
        return TaxiNodes:IsAvailable(step.data.taxiNodeId, addon.player.factionName)
    elseif step.type == addon.STEP_TYPE_FLY_TO then
        return addon.db.char.taxiNodeIds[step.data.taxiNodeId] == true
    end
    return true
end

function State:IsStepShown(step)
    -- Check if step is completed, or if we show completed steps
    local showStep = not step.isComplete or addon.db.profile.window.showCompletedSteps

    -- Additional checks if step is going to become current step
    if showStep and not step.isComplete and self.currentStep == nil then
        local doable, reason = self:IsStepDoable(step)
        if doable then
            if addon:IsStepTypeQuest(step) then
                -- Additional checks if step is going to become current step
                local questId = step.data.questId
                if step.type == addon.STEP_TYPE_COMPLETE_QUEST then
                    if not self:IsQuestInQuestLog(questId) then
                        -- Check if there's any objectives that can be completed even if quest is not in quest log
                        local objectives = DataSource:GetQuestObjectives(questId, step.data.objectives)
                        doable = List:Any(objectives, function(objective)
                            if not objective.isComplete and objective.type == "Item" then
                                -- Check if we can get item from vendors
                                if List:Any(objective.sources, function(source) return source.type == "Vendor" end) then
                                    return true
                                end
                                -- Check if we can get item without active quest (not a quest item)
                                if not addon:IsItemQuestItem(objective.id) then
                                    return true
                                end
                            end
                            return false
                        end)
                        if not doable then
                            return false, string.format("Quest %s not in quest log", questId)
                        end
                    end
                elseif step.type == addon.STEP_TYPE_TURNIN_QUEST then
                    if DataSource:IsQuestRepeatable(questId) or DataSource:IsQuestAutoComplete(questId) then
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
            --addon:Debug("Step %s %s is not doable: %s", step.type, dump(step.data), dump(reason))
        end

        showStep = doable -- Hide steps that are not doable
    end

    return showStep
end

function State:IsStepComplete(step)
    if addon:IsStepTypeQuest(step) then
        local questId = step.data.questId

        -- Check if quest is already turned-in
        if self:IsQuestTurnedIn(questId) then
            return true
        end

        -- Check if quest is exclusive to some other quests
        local exclusiveToQuestIds = DataSource:GetQuestExclusiveTo(questId)
        if exclusiveToQuestIds ~= nil then
            -- Check if exclusive quest is in quest log or already turned-in
            if List:Any(exclusiveToQuestIds, function(exclusiveQuestId) return self:IsQuestInQuestLogOrTurnedIn(exclusiveQuestId) end) then
                return true -- Quest is unobtainable, consider complete
            end
        end

        -- Per quest step type checks
        if step.type == addon.STEP_TYPE_ACCEPT_QUEST then
            -- Check if quest is in quest log
            if self:IsQuestInQuestLog(questId) then
                return true
            end
        elseif step.type == addon.STEP_TYPE_COMPLETE_QUEST then
            if self:IsQuestInQuestLogAndComplete(questId) then -- Check if quest is in quest log and complete
                return true
            elseif self:IsStepAllQuestObjectivesComplete(step) then -- Check if quest objectives are all complete
                return true
            end
        elseif step.type == addon.STEP_TYPE_TURNIN_QUEST then
            -- Check if quest is turned-in (redundancy)
            if self:IsQuestTurnedIn(questId) then
                return true
            end
        end
        return false
    else
        if step.type == addon.STEP_TYPE_GO_TO_COORD then
            -- Can't verify
        elseif step.type == addon.STEP_TYPE_GO_TO_ZONE then
            -- Can't verify
        elseif step.type == addon.STEP_TYPE_GO_TO_AREA then
            -- Can't verify
        elseif step.type == addon.STEP_TYPE_REACH_LEVEL then
            if addon.player.level > step.data.level then
                return true
            elseif addon.player.level == step.data.level then
                return step.data.xp == nil or addon.player.xp >= step.data.xp
            end
        elseif step.type == addon.STEP_TYPE_REACH_REPUTATION then
            local name, _, standingId = GetFactionInfoByID(step.data.factionId)
            if name and standingId and standingId >= step.data.standingId then
                return true
            end
        elseif step.type == addon.STEP_TYPE_BIND_HEARTHSTONE then
            -- Can't verify
        elseif step.type == addon.STEP_TYPE_USE_HEARTHSTONE then
            -- Can't verify
        elseif step.type == addon.STEP_TYPE_LEARN_FLIGHT_PATH then
            -- Check if taxiNodeId has been unlocked
            return addon.db.char.taxiNodeIds[step.data.taxiNodeId] == true
        elseif step.type == addon.STEP_TYPE_FLY_TO then
            -- Can't verify
        elseif step.type == addon.STEP_TYPE_TRAIN_CLASS then
            -- Can't verify
        elseif step.type == addon.STEP_TYPE_TRAIN_SPELLS then
            return List:All(step.data.spells, function(spellId) return addon:IsSpellKnown(spellId) end)
        elseif step.type == addon.STEP_TYPE_LEARN_FIRST_AID then
            return addon:IsSpellKnown(addon.SPELL_FIRST_AID_APPRENTICE)
        elseif step.type == addon.STEP_TYPE_LEARN_COOKING then
            return addon:IsSpellKnown(addon.SPELL_COOKING_APPRENTICE)
        elseif step.type == addon.STEP_TYPE_LEARN_FISHING then
            return addon:IsSpellKnown(addon.SPELL_FISHING_APPRENTICE)
        elseif step.type == addon.STEP_TYPE_ACQUIRE_ITEMS then
            return List:All(step.data.items, function(item) return addon:GetItemCountInBags(item.id) >= item.count end)
        elseif step.type == addon.STEP_TYPE_DIE_AND_RES then
            -- Can't verify
        end
        return false
    end

    addon:Error("Step type %s not implemented.", step.type)
end

function State:IsChapterComplete()
    if self.steps then
        return List:All(self.steps, function(step) return step.isComplete or not step.isShown end)
    end
    return false
end

function State:GetCurrentStep()
    return self.currentStep
end

function State:GetStepLocation(step)
    if step.type == addon.STEP_TYPE_ACCEPT_QUEST then
        return DataSource:GetNearestQuestStarter(step.data.questId)
    elseif step.type == addon.STEP_TYPE_COMPLETE_QUEST then
        if step.objectiveIndex then
            return DataSource:GetQuestObjectiveLocation(step.data.questId, step.objectiveIndex)
        else
            local objectives = self:GetQuestObjectives(step.data.questId)
            if step.data.objectives then
                local n = #step.data.objectives
                for i = 1, n do
                    local objectiveIndex = step.data.objectives[i]
                    if not objectives[objectiveIndex].finished then
                        return DataSource:GetQuestObjectiveLocation(step.data.questId, objectiveIndex)
                    end
                end
                return DataSource:GetQuestObjectiveLocation(step.data.questId, step.data.objectives[1])
            else
                if self:IsQuestTurnedIn(step.data.questId) or List:All(objectives, function(objective) return objective.finished end) then
                    return DataSource:GetNearestQuestObjectiveLocation(step.data.questId)
                end
                return DataSource:GetNearestQuestObjectiveLocation(step.data.questId, objectives)
            end
        end
    elseif step.type == addon.STEP_TYPE_TURNIN_QUEST then
        return DataSource:GetNearestQuestFinisher(step.data.questId)
    elseif step.type == addon.STEP_TYPE_GO_TO_COORD then
        if addon.player.location then
            local distance = HBD:GetZoneDistance(addon.player.location.mapId, addon.player.location.x, addon.player.location.y, step.data.mapId, step.data.x / 100.0, step.data.y / 100.0)
            if distance then
                return { distance = distance, mapId = step.data.mapId, x = step.data.x, y = step.data.y, name = string.format("%s\n%s", step.data.desc, step.data.mapName), type = "Event" }
            end
        end
    elseif step.type == addon.STEP_TYPE_GO_TO_ZONE then
        if addon.player.location and step.data.x and step.data.y then -- coords are optional, so they can be nil
            local distance = HBD:GetZoneDistance(addon.player.location.mapId, addon.player.location.x, addon.player.location.y, step.data.mapId, step.data.x / 100.0, step.data.y / 100.0)
            if distance then
                return { distance = distance, mapId = step.data.mapId, x = step.data.x, y = step.data.y, name = string.format("%s", step.data.mapName), type = "Event" }
            end
        end
    elseif step.type == addon.STEP_TYPE_GO_TO_AREA then
        return nil -- todo
    elseif step.type == addon.STEP_TYPE_REACH_LEVEL then
        return nil
    elseif step.type == addon.STEP_TYPE_REACH_REPUTATION then
        return nil
    elseif step.type == addon.STEP_TYPE_BIND_HEARTHSTONE then
        return DataSource:GetNearestInnkeeperLocation(step.data.areaId)
    elseif step.type == addon.STEP_TYPE_USE_HEARTHSTONE then
        return nil
    elseif step.type == addon.STEP_TYPE_LEARN_FLIGHT_PATH then
        return DataSource:GetFlightMasterLocation(step.data.taxiNodeId)
    elseif step.type == addon.STEP_TYPE_FLY_TO then
        return DataSource:GetNearestFlightMasterLocation()
    elseif step.type == addon.STEP_TYPE_TRAIN_CLASS then
        return DataSource:GetNearestClassTrainerLocation()
    elseif step.type == addon.STEP_TYPE_TRAIN_SPELLS then
        local spellId = step.data.spells[1] -- Always use trainer location of first spell in list
        if spellId == addon.SPELL_TELEPORT_TO_STORMWIND or spellId == addon.SPELL_PORTAL_TO_STORMWIND then
            return DataSource:GetNPCLocation(addon.NPC_STORMWIND_PORTAL_TRAINER)
        elseif spellId == addon.SPELL_TELEPORT_TO_IRONFORGE or spellId == addon.SPELL_PORTAL_TO_IRONFORGE then
            return DataSource:GetNPCLocation(addon.NPC_IRONFORGE_PORTAL_TRAINER)
        elseif spellId == addon.SPELL_TELEPORT_TO_DARNASSUS or spellId == addon.SPELL_PORTAL_TO_DARNASSUS then
            return DataSource:GetNPCLocation(addon.NPC_DARNASSUS_PORTAL_TRAINER)
        elseif spellId == addon.SPELL_HORSE_RIDING then
            return DataSource:GetNPCLocation(addon.NPC_HORSE_RIDING_INSTRUCTOR)
        elseif spellId == addon.SPELL_RAM_RIDING then
            return DataSource:GetNPCLocation(addon.NPC_RAM_RIDING_INSTRUCTOR)
        elseif spellId == addon.SPELL_TIGER_RIDING then
            return DataSource:GetNPCLocation(addon.NPC_NIGHTSABER_RIDING_INSTRUCTOR)
        elseif spellId == addon.SPELL_MECHANOSTRIDER_PILOTING then
            return DataSource:GetNPCLocation(addon.NPC_MECHANOSTRIDER_PILOT)
        end
        return DataSource:GetNearestClassTrainerLocation()
    elseif step.type == addon.STEP_TYPE_LEARN_FIRST_AID then
        return DataSource:GetNearestFirstAidTrainerLocation()
    elseif step.type == addon.STEP_TYPE_LEARN_COOKING then
        return DataSource:GetNearestCookingTrainerLocation()
    elseif step.type == addon.STEP_TYPE_LEARN_FISHING then
        return DataSource:GetNearestFishingTrainerLocation()
    elseif step.type == addon.STEP_TYPE_ACQUIRE_ITEMS then
        if step.itemId then
            return DataSource:GetNearestItemLocation({ step.itemId })
        else
            local items = {}
            local hasAll = List:All(step.data.items, function(item) return addon:GetItemCountInBags(item.id) >= item.count end)
            local items = List:Select(step.data.items, function(item)
                if hasAll or addon:GetItemCountInBags(item.id) < item.count then
                    return item.id
                end
            end)
            return DataSource:GetNearestItemLocation(items)
        end
    elseif step.type == addon.STEP_TYPE_DIE_AND_RES then
        return nil
    else
        addon:Error("Step type %s not implemented.", step.type)
    end
end

function State:IsQuestAvailable(questId)
    -- Check if quest exists in game
    if not DataSource:IsQuestAvailable(questId) then
        return false, "Invalid quest ID"
    end

    -- Check if player has required race
    if not DataSource:GetQuestHasRequiredRace(questId) then
        return false, "Missing race requirement"
    end

    -- Check if player has required class
    if not DataSource:GetQuestHasRequiredClass(questId) then
        return false, "Missing class requirement"
    end

    -- Quest should be available now or later
    return true
end

function State:IsQuestDoable(questId, isStepTypeComplete)
    -- Check if player has required level
    if addon.player.level < DataSource:GetQuestRequiredLevel(questId) then
        return false, "Missing level requirement"
    end

    -- Check if player has required profession and skill level
    if not DataSource:GetQuestHasProfessionAndSkillLevel(questId) then
        return false, "Missing profession or skill level requirement"
    end

    -- Check if player has required reputation
    if not DataSource:GetQuestHasReputation(questId) then
        return false, "Missing reputation requirement"
    end

    -- For complete quest steps: if quest is not in quest log yet, assume it will become doable
    if isStepTypeComplete and not self:IsQuestInQuestLog(questId) then
        return true
    end

    -- Check if quest next quest in chain is complete or in quest log
    local nextInChainQuestId = DataSource:GetQuestNextQuestInChain(questId)
    if nextInChainQuestId and State:IsQuestInQuestLogOrTurnedIn(nextInChainQuestId) then
        return false, string.format("Next quest in chain %s is in quest log or has been turned-in", nextInChainQuestId)
    end

    -- Check if quest has exclusive quests completed or in quest log
    local exclusiveToQuestIds = DataSource:GetQuestExclusiveTo(questId)
    if exclusiveToQuestIds then
        if List:Any(exclusiveToQuestIds, function(exclusiveQuestId) return exclusiveQuestId and State:IsQuestInQuestLogOrTurnedIn(exclusiveQuestId) end) then
            return false, string.format("Exclusive quest %s is in quest log or has been turned-in", exclusiveQuestId)
        end
    end

    -- Check if quest has parent quest and is in quest log
    local parentQuestId = DataSource:GetQuestParentQuest(questId)
    if parentQuestId and not State:IsQuestInQuestLog(parentQuestId) then
        return false, string.format("Parent quest %s is not in quest log", parentQuestId)
    end

    -- Check if all pre quests are complete
    local preQuestGroup = DataSource:GetQuestPreQuestGroup(questId)
    if preQuestGroup then
        return self:IsQuestPreQuestGroupFulfilled(preQuestGroup)
    end

    -- Check if single pre quest are complete
    local preQuestSingle = DataSource:GetQuestPreQuestSingle(questId)
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
            local exclusiveToQuestIds = DataSource:GetQuestExclusiveTo(preQuestId)
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
        local exclusiveToQuestIds = DataSource:GetQuestExclusiveTo(preQuestId)
        if exclusiveToQuestIds then
            if List:Any(exclusiveToQuestIds, function(exclusiveQuestId) return exclusiveQuestId and self:IsQuestTurnedIn(exclusiveQuestId) end) then
                return true
            end
        end
    end

    -- No pre quest is complete
    return false, "No pre quest have been turned-in"
end

function State:IsStepAllQuestObjectivesComplete(step)
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
    local isQuestTurnedIn = self.questsTurnedIn[questId]
    if not isQuestTurnedIn then -- Update if nil or false
        isQuestTurnedIn = C_QuestLog.IsQuestFlaggedCompleted(questId) == true
        self.questsTurnedIn[questId] = isQuestTurnedIn
    end
    return isQuestTurnedIn
end

function State:SetQuestTurnedIn(questId)
    if not DataSource:IsQuestRepeatable(questId) then
        self.questsTurnedIn[questId] = true
    end
end

function State:GetQuestObjectives(questId)
    if self.questObjectives == nil then
        self.questObjectives = {}
    end

    local questObjectives = self.questObjectives[questId]
    if questObjectives == nil then
        local objectives = C_QuestLog.GetQuestObjectives(questId)
        if objectives then
            questObjectives = List:Where(objectives, function(objective) return not String:IsNilOrEmpty(objective.text) end)
            self.questObjectives[questId] = questObjectives
        end
    end

    return questObjectives
end

function State:IterateStepQuestObjectives(step, callback)
    local objectives = self:GetQuestObjectives(step.data.questId)
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
    local objectives = self:GetQuestObjectives(questId)
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
