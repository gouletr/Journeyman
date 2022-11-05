local addonName, addon = ...
local Journeys = addon:NewModule("Journeys")
local L = addon.Locale

local String = LibStub("LibCollections-1.0").String
local List = LibStub("LibCollections-1.0").List
local Utils

local function tmove(t, from, to) table.insert(t, to, table.remove(t, from)) end

function Journeys:OnInitialize()
    Utils = addon.Utils
end

function Journeys:OnEnable()
end

function Journeys:OnDisable()
end

function Journeys:CreateJourney(title, guid)
    if title == nil then
        title = L["NEW_JOURNEY_TITLE"]
    end
    if guid == nil then
        guid = Utils:CreateGUID()
    end
    return { guid = guid, title = title, chapters = {} }
end

function Journeys:AddNewJourney(title)
    local journey = self:CreateJourney(title)
    if journey then
        if addon.journeys == nil then
            addon.journeys = {}
        end
        List:Add(addon.journeys, journey)
        return journey
    end
end

function Journeys:MoveJourney(from, to)
    if addon.journeys and from > 0 and from <= #addon.journeys and to > 0 and to <= #addon.journeys then
        tmove(addon.journeys, from, to)
        return true
    end
    return false
end

function Journeys:DeleteJourney(index)
    return List:RemoveAt(addon.journeys, index)
end

function Journeys:SetActiveJourney(journey)
    if journey and journey.guid and type(journey.guid) == "string" then
        addon.db.char.journey = journey.guid
    end
end

function Journeys:CreateChapter(journey, title)
    if journey then
        if title == nil then
            title = L["NEW_CHAPTER_TITLE"]
        end
        return { journey = journey, title = title, steps = {} }
    end
end

function Journeys:AddNewChapter(journey, title)
    local chapter = self:CreateChapter(journey, title)
    if chapter then
        if journey.chapters == nil then
            journey.chapters = {}
        end
        List:Add(journey.chapters, chapter)
        addon:ResetJourneyState(journey)
        return chapter
    end
end

function Journeys:MoveChapter(journey, from, to)
    if journey and journey.chapters and from > 0 and from <= #journey.chapters and to > 0 and to <= #journey.chapters then
        tmove(journey.chapters, from, to)
        addon:ResetJourneyState(journey)
        return true
    end
    return false
end

function Journeys:DeleteChapter(journey, index)
    if List:RemoveAt(journey.chapters, index) then
        addon:ResetJourneyState(journey)
        return true
    end
    return false
end

function Journeys:AdvanceChapter(journey)
    local index = addon.db.char.chapter + 1
    if journey and index > 0 and index <= #journey.chapters then
        addon.db.char.chapter = index
        return true
    end
    return false
end

function Journeys:CreateStep(type, data, requiredRaces, requiredClasses, note)
    if type == nil then
        type = addon.STEP_TYPE_UNDEFINED
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

function Journeys:AddNewStep(journey, chapter, type, data, index, requiredRaces, requiredClasses, note)
    local step = self:CreateStep(type, data, requiredRaces, requiredClasses, note)
    if journey and chapter then
        if chapter.steps == nil then
            chapter.steps = {}
        end
        if index and index > 0 and index <= #chapter.steps then
            List:Insert(chapter.steps, index, step)
            addon:ResetJourneyChapterState(journey, chapter)
        else
            List:Add(chapter.steps, step)
        end
        return step
    end
end

function Journeys:GetStep(chapter, index)
    if chapter and chapter.steps and index > 0 and index <= #chapter.steps then
        return chapter.steps[index]
    end
end

function Journeys:MoveStep(journey, chapter, from, to)
    if journey and chapter and chapter.steps and from > 0 and from <= #chapter.steps and to > 0 and to <= #chapter.steps then
        tmove(chapter.steps, from, to)
        addon:ResetJourneyChapterState(journey, chapter)
        return true
    end
    return false
end

function Journeys:DeleteStep(journey, chapter, index)
    if journey and chapter and List:RemoveAt(chapter.steps, index) then
        addon:ResetJourneyChapterState(journey, chapter)
        return true
    end
    return false
end

local function MergeStepData(lhs, rhs)
    if lhs.type == addon.STEP_TYPE_COMPLETE_QUEST then
        local lhsData = addon:GetStepData(lhs)
        local rhsData = addon:GetStepData(rhs)
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
    elseif lhs.type == addon.STEP_TYPE_TRAIN_SPELLS then
        local lhsData = addon:GetStepData(lhs)
        local rhsData = addon:GetStepData(rhs)
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
    elseif lhs.type == addon.STEP_TYPE_ACQUIRE_ITEMS then
        -- todo?
    end
end

local function AddOrMergeStep(journey, chapter, type, data, requiredRaces, requiredClasses)
    -- Create step, but don't add it yet
    local step = Journeys:CreateStep(type, data, requiredRaces, requiredClasses)

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
                addon:Debug("Step %s updated.", addon:GetStepText(step, true, true))
                return
            end
        end
    end

    -- Step wasn't merged, add to chapter
    List:Add(chapter.steps, step)
    addon:Debug("Step %s added.", addon:GetStepText(step, true, true))
end

function GetLastOrAddNewChapter(journey, title)
    if journey then
        local chapter
        if journey.chapters and #journey.chapters > 0 then
            chapter = journey.chapters[#journey.chapters]
        end
        if chapter == nil then
            chapter = Journeys:AddNewChapter(journey, title)
        end
        return chapter
    end
end

function AddOrMergeStepToCharacterJourney(type, data, requiredRaces, requiredClasses)
    local journey = addon:GetMyJourney()
    local chapterTitle = addon:GetMapName()
    local chapter = GetLastOrAddNewChapter(journey, chapterTitle)
    if journey and chapter then
        if not String:IsNilOrEmpty(chapterTitle) and chapter.title ~= chapterTitle then
            chapter = Journeys:AddNewChapter(journey, chapterTitle)
            if chapter then
                local step = Journeys:AddNewStep(journey, chapter, type, data, nil, requiredRaces, requiredClasses)
                addon:Debug("Step %s added.", addon:GetStepText(step, true, true))
            end
        else
            AddOrMergeStep(journey, chapter, type, data, requiredRaces, requiredClasses)
        end
    end
end

function Journeys:OnQuestAccepted(questId)
    AddOrMergeStepToCharacterJourney(addon.STEP_TYPE_ACCEPT_QUEST, tostring(questId))
end

function Journeys:OnQuestCompleted(questId)
    AddOrMergeStepToCharacterJourney(addon.STEP_TYPE_COMPLETE_QUEST, tostring(questId))
end

function Journeys:OnQuestObjectiveCompleted(questId, objectiveIndex)
    AddOrMergeStepToCharacterJourney(addon.STEP_TYPE_COMPLETE_QUEST, string.format("%d,%d", questId, objectiveIndex))
end

function Journeys:OnQuestTurnedIn(questId)
    AddOrMergeStepToCharacterJourney(addon.STEP_TYPE_TURNIN_QUEST, tostring(questId))
end

function Journeys:OnQuestAbandoned(questId)
    local journey = addon:GetMyJourney()
    if journey.chapters then
        List:ForEach(journey.chapters, function(chapter)
            if chapter.steps then
                chapter.steps = List:Where(chapter.steps, function(step)
                    if addon:IsStepTypeQuest(step) then
                        local data = addon:GetStepData(step)
                        if data and data.questId then
                            return data.questId ~= questId
                        end
                    end
                    return true
                end)
            end
        end)
        addon:Debug("All steps with quest %s have been removed.", addon:GetQuestName(questId, true, true))
    end
end

function Journeys:OnZoneChanged(location)
    AddOrMergeStepToCharacterJourney(addon.STEP_TYPE_GO_TO_ZONE, string.format("%d,%.2f,%.2f", location.mapId, location.x * 100.0, location.y * 100.0))
end

function Journeys:OnLevelUp(level)
    AddOrMergeStepToCharacterJourney(addon.STEP_TYPE_REACH_LEVEL, tostring(level))
end

function Journeys:OnHearthstoneBound(areaId)
    AddOrMergeStepToCharacterJourney(addon.STEP_TYPE_BIND_HEARTHSTONE, tostring(areaId))
end

function Journeys:OnHearthstoneUsed(areaId)
    AddOrMergeStepToCharacterJourney(addon.STEP_TYPE_USE_HEARTHSTONE, tostring(areaId))
end

function Journeys:OnLearnFlightPath(taxiNodeId)
    AddOrMergeStepToCharacterJourney(addon.STEP_TYPE_LEARN_FLIGHT_PATH, tostring(taxiNodeId))
end

function Journeys:OnTakeFlightPath(taxiNodeId)
    AddOrMergeStepToCharacterJourney(addon.STEP_TYPE_FLY_TO, tostring(taxiNodeId))
end

function Journeys:OnClassTrainerClosed()
    AddOrMergeStepToCharacterJourney(addon.STEP_TYPE_TRAIN_CLASS)
end

function Journeys:OnSpellLearned(spellId)
    AddOrMergeStepToCharacterJourney(addon.STEP_TYPE_TRAIN_SPELLS, tostring(spellId), nil, addon.player.classMask)
end

function Journeys:OnSpiritResurrection()
    AddOrMergeStepToCharacterJourney(addon.STEP_TYPE_DIE_AND_RES)
end
