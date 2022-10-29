local addonName, addon = ...
local Journeyman = addon.Journeyman
local L = addon.Locale

local Journey = {}
Journeyman.Journey = Journey

local String = LibStub("LibCollections-1.0").String
local List = LibStub("LibCollections-1.0").List

local function tmove(t, from, to) table.insert(t, to, table.remove(t, from)) end

function Journey:Initialize()
    if Journeyman.journeys == nil then
        Journeyman.journeys = {}
    end
end

function Journey:CreateJourney(title, guid)
    if title == nil then
        title = L["NEW_JOURNEY_TITLE"]
    end
    if guid == nil then
        guid = Journeyman.Utils:CreateGUID()
    end
    return { guid = guid, title = title, chapters = {} }
end

function Journey:AddNewJourney(title)
    local journey = self:CreateJourney(title)
    if journey then
        if Journeyman.journeys == nil then
            Journeyman.journeys = {}
        end
        List:Add(Journeyman.journeys, journey)
        return journey
    end
end

function Journey:MoveJourney(from, to)
    if Journeyman.journeys and from > 0 and from <= #Journeyman.journeys and to > 0 and to <= #Journeyman.journeys then
        tmove(Journeyman.journeys, from, to)
        return true
    end
    return false
end

function Journey:DeleteJourney(index)
    return List:RemoveAt(Journeyman.journeys, index)
end

function Journey:SetActiveJourney(journey)
    if journey and journey.guid and type(journey.guid) == "string" then
        Journeyman.db.char.journey = journey.guid
    end
end

function Journey:CreateChapter(journey, title)
    if journey then
        if title == nil then
            title = L["NEW_CHAPTER_TITLE"]
        end
        return { journey = journey, title = title, steps = {} }
    end
end

function Journey:AddNewChapter(journey, title)
    local chapter = self:CreateChapter(journey, title)
    if chapter then
        if journey.chapters == nil then
            journey.chapters = {}
        end
        List:Add(journey.chapters, chapter)
        Journeyman:ResetJourneyState(journey)
        return chapter
    end
end

function Journey:MoveChapter(journey, from, to)
    if journey and journey.chapters and from > 0 and from <= #journey.chapters and to > 0 and to <= #journey.chapters then
        tmove(journey.chapters, from, to)
        Journeyman:ResetJourneyState(journey)
        return true
    end
    return false
end

function Journey:DeleteChapter(journey, index)
    if List:RemoveAt(journey.chapters, index) then
        Journeyman:ResetJourneyState(journey)
        return true
    end
    return false
end

function Journey:AdvanceChapter(journey)
    local index = Journeyman.db.char.chapter + 1
    if journey and index > 0 and index <= #journey.chapters then
        Journeyman.db.char.chapter = index
        return true
    end
    return false
end

function Journey:CreateStep(type, data, requiredRaces, requiredClasses, note)
    if type == nil then
        type = Journeyman.STEP_TYPE_UNDEFINED
    end
    if data == nil then
        data = ""
    end
    if requiredRaces == 0 then
        requiredRaces = nil
    end
    if requiredClasses == 0 then
        requiredClasses = nil
    end
    if String:IsNilOrEmpty(note) then
        note = nil
    end
    return { type = type, data = data, requiredRaces = requiredRaces, requiredClasses = requiredClasses, note = note }
end

function Journey:AddNewStep(journey, chapter, type, data, index, requiredRaces, requiredClasses, note)
    local step = self:CreateStep(type, data, requiredRaces, requiredClasses, note)
    if journey and chapter then
        if chapter.steps == nil then
            chapter.steps = {}
        end
        if index and index > 0 and index <= #chapter.steps then
            List:Insert(chapter.steps, index, step)
            Journeyman:ResetJourneyChapterState(journey, chapter)
        else
            List:Add(chapter.steps, step)
        end
        return step
    end
end

function Journey:GetStep(chapter, index)
    if chapter and chapter.steps and index > 0 and index <= #chapter.steps then
        return chapter.steps[index]
    end
end

function Journey:MoveStep(journey, chapter, from, to)
    if journey and chapter and chapter.steps and from > 0 and from <= #chapter.steps and to > 0 and to <= #chapter.steps then
        tmove(chapter.steps, from, to)
        Journeyman:ResetJourneyChapterState(journey, chapter)
        return true
    end
    return false
end

function Journey:DeleteStep(journey, chapter, index)
    if journey and chapter and List:RemoveAt(chapter.steps, index) then
        Journeyman:ResetJourneyChapterState(journey, chapter)
        return true
    end
    return false
end

local function MergeStepData(lhs, rhs)
    if lhs.type == Journeyman.STEP_TYPE_COMPLETE_QUEST then
        local lhsData = Journeyman:GetStepData(lhs)
        local rhsData = Journeyman:GetStepData(rhs)
        if lhsData and rhsData and lhsData.questId and rhsData.questId and lhsData.questId == rhsData.questId then
            local questId = lhsData.questId
            local objectives = {}
            if lhsData.objectives then
                List:AddRange(objectives, lhsData.objectives)
            end
            if rhsData.objectives then
                List:AddRange(objectives, rhsData.objectives)
            end
            objectives = List:Distinct(objectives)
            local data = tostring(questId)
            if #objectives > 0 then
                data = data..","..String:Join(",", List:Select(objectives, function(objective) return tostring(objective) end))
            end
            return data
        end
    elseif lhs.type == Journeyman.STEP_TYPE_TRAIN_SPELLS then
        local lhsData = Journeyman:GetStepData(lhs)
        local rhsData = Journeyman:GetStepData(rhs)
        if lhsData and rhsData then
            local spells = {}
            if lhsData.spells then
                List:AddRange(spells, lhsData.spells)
            end
            if rhsData.spells then
                List:AddRange(spells, rhsData.spells)
            end
            spells = List:Distinct(spells)
            if #spells > 0 then
                return String:Join(",", List:Select(spells, function(spell) return tostring(spell) end))
            end
        end
    elseif lhs.type == Journeyman.STEP_TYPE_ACQUIRE_ITEMS then
        -- todo?
    end
end

local function AddOrMergeStep(journey, chapter, type, data, requiredRaces, requiredClasses)
    -- Create step, but don't add it yet
    local step = Journey:CreateStep(type, data, requiredRaces, requiredClasses)

    -- Verify if we can merge step instead of adding
    if #chapter.steps > 0 then
        local lastStep = chapter.steps[#chapter.steps]
        if lastStep.type == step.type then
            if lastStep.data == step.data then
                return -- Same data, don't add step
            end
            local data = MergeStepData(lastStep, step)
            if data then
                lastStep.data = data
                Journeyman:Debug("Step %s updated.", Journeyman:GetStepText(step, true, true))
                return
            end
        end
    end

    -- Step wasn't merged, add to chapter
    List:Add(chapter.steps, step)
    Journeyman:Debug("Step %s added.", Journeyman:GetStepText(step, true, true))
end

function GetLastOrAddNewChapter(journey, title)
    if journey then
        local chapter
        if journey.chapters and #journey.chapters > 0 then
            chapter = journey.chapters[#journey.chapters]
        end
        if chapter == nil then
            chapter = Journey:AddNewChapter(journey, title)
        end
        return chapter
    end
end

function AddOrMergeStepToCharacterJourney(type, data, requiredRaces, requiredClasses)
    local journey = Journeyman:GetMyJourney()
    local chapterTitle = Journeyman:GetMapName()
    local chapter = GetLastOrAddNewChapter(journey, chapterTitle)
    if journey and chapter then
        if not String:IsNilOrEmpty(chapterTitle) and chapter.title ~= chapterTitle then
            chapter = Journey:AddNewChapter(journey, chapterTitle)
            if chapter then
                local step = Journey:AddNewStep(journey, chapter, type, data, nil, requiredRaces, requiredClasses)
                Journeyman:Debug("Step %s added.", Journeyman:GetStepText(step, true, true))
            end
        else
            AddOrMergeStep(journey, chapter, type, data, requiredRaces, requiredClasses)
        end
    end
end

function Journey:OnQuestAccepted(questId)
    AddOrMergeStepToCharacterJourney(Journeyman.STEP_TYPE_ACCEPT_QUEST, tostring(questId))
end

function Journey:OnQuestCompleted(questId)
    AddOrMergeStepToCharacterJourney(Journeyman.STEP_TYPE_COMPLETE_QUEST, tostring(questId))
end

function Journey:OnQuestObjectiveCompleted(questId, objectiveIndex)
    AddOrMergeStepToCharacterJourney(Journeyman.STEP_TYPE_COMPLETE_QUEST, string.format("%d,%d", questId, objectiveIndex))
end

function Journey:OnQuestTurnedIn(questId)
    AddOrMergeStepToCharacterJourney(Journeyman.STEP_TYPE_TURNIN_QUEST, tostring(questId))
end

function Journey:OnQuestAbandoned(questId)
    local journey = Journeyman:GetMyJourney()
    if journey.chapters then
        List:ForEach(journey.chapters, function(chapter)
            if chapter.steps then
                chapter.steps = List:Where(chapter.steps, function(step)
                    if Journeyman:IsStepTypeQuest(step) then
                        local data = Journeyman:GetStepData(step)
                        if data and data.questId then
                            return data.questId ~= questId
                        end
                    end
                    return true
                end)
            end
        end)
        Journeyman:Debug("All steps with quest %s have been removed.", Journeyman:GetQuestName(questId, true, true))
    end
end

function Journey:OnZoneChanged(location)
    AddOrMergeStepToCharacterJourney(Journeyman.STEP_TYPE_GO_TO_ZONE, string.format("%d,%.2f,%.2f", location.mapId, location.x * 100.0, location.y * 100.0))
end

function Journey:OnLevelUp(level)
    AddOrMergeStepToCharacterJourney(Journeyman.STEP_TYPE_REACH_LEVEL, tostring(level))
end

function Journey:OnHearthstoneBound(areaId)
    AddOrMergeStepToCharacterJourney(Journeyman.STEP_TYPE_BIND_HEARTHSTONE, tostring(areaId))
end

function Journey:OnHearthstoneUsed(areaId)
    AddOrMergeStepToCharacterJourney(Journeyman.STEP_TYPE_USE_HEARTHSTONE, tostring(areaId))
end

function Journey:OnLearnFlightPath(taxiNodeId)
    AddOrMergeStepToCharacterJourney(Journeyman.STEP_TYPE_LEARN_FLIGHT_PATH, tostring(taxiNodeId))
end

function Journey:OnTakeFlightPath(taxiNodeId)
    AddOrMergeStepToCharacterJourney(Journeyman.STEP_TYPE_FLY_TO, tostring(taxiNodeId))
end

function Journey:OnClassTrainerClosed()
    AddOrMergeStepToCharacterJourney(Journeyman.STEP_TYPE_TRAIN_CLASS)
end

function Journey:OnSpellLearned(spellId)
    AddOrMergeStepToCharacterJourney(Journeyman.STEP_TYPE_TRAIN_SPELLS, tostring(spellId), nil, Journeyman.player.classMask)
end

function Journey:OnSpiritResurrection()
    AddOrMergeStepToCharacterJourney(Journeyman.STEP_TYPE_DIE_AND_RES)
end
