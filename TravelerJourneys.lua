local addonName, addon = ...
local L = addon.Locale
local Traveler = addon.Traveler

Traveler.STEP_TYPE_ACCEPT_QUEST = "ACCEPT"
Traveler.STEP_TYPE_COMPLETE_QUEST = "COMPLETE"
Traveler.STEP_TYPE_TURNIN_QUEST = "TURNIN"
Traveler.STEP_TYPE_FLY_TO = "FLYTO"
Traveler.STEP_TYPE_BIND_HEARTHSTONE = "BIND"

function Traveler:InitializeJourney()
    if self.journeys == nil then
        self.journeys = {}
    end

    if self.journey == nil then
        self.journey = {
            title = nil,
            chapters = {}
        }
    end

    if self.journey.title == nil then
        local playerName = UnitName("player")
        self.journey.title = playerName.."'s Journey"
    end

    self:JourneyRemoveEmptyChapters()
end

function Traveler:JourneyImportFromCharacter()
    if self.journey ~= nil then
        local journey = TableDeepCopy(self.journey)
        ArrayAdd(self.journeys, journey)
    end
end

function Traveler:IsStepQuest(step)
    return step.type == self.STEP_TYPE_ACCEPT_QUEST or step.type == self.STEP_TYPE_COMPLETE_QUEST or step.type == self.STEP_TYPE_TURNIN_QUEST
end

function Traveler:GetActiveJourneyIndex()
    return self.db.char.window.journey
end

function Traveler:GetActiveJourney()
    local index = self:GetActiveJourneyIndex()
    if index >= 1 and index <= #self.journeys then
        return self.journeys[index]
    end
end

function Traveler:GetActiveChapterIndex()
    return self.db.char.window.chapter
end

function Traveler:GetActiveChapter(journey)
    local index = self:GetActiveChapterIndex()
    if journey ~= nil and index >= 1 and index <= #journey.chapters then
        return journey.chapters[index]
    end
end

function Traveler:JourneyAddChapter(title)
    local chapter = {
        title = title,
        level = UnitLevel("player"),
        steps = {}
    }
    ArrayAdd(self.journey.chapters, chapter)
    return chapter
end

function Traveler:JourneyRemoveEmptyChapters()
    ArrayRemoveIf(self.journey.chapters, function(i)
        local chapter = self.journey.chapters[i]
        return #chapter.steps == 0
    end)
end

function Traveler:JourneyGetOrCreateChapter()
    local uiMapId = C_Map.GetBestMapForUnit("player")
    local mapInfo = uiMapId and C_Map.GetMapInfo(uiMapId) or nil
    local mapName = mapInfo and mapInfo.name or ""
    local chapterCount = #self.journey.chapters

    if chapterCount == 0 then
        return self:JourneyAddChapter(mapName)
    end

    local lastChapter = self.journey.chapters[chapterCount]
    if lastChapter.title ~= mapName then
        return self:JourneyAddChapter(mapName)
    end

    return lastChapter
end

function Traveler:JourneyChapterAddStep(chapter, type, data)
    local step = {
        type = type,
        data = data
    }
    ArrayAdd(chapter.steps, step)
    self:Debug("Chapter '"..chapter.title.."' added step "..type.." "..data)
    return step
end

function Traveler:JourneyCurrentChapterAddStep(type, data)
    local currentChapter = self:JourneyGetOrCreateChapter()
    self:JourneyChapterAddStep(currentChapter, type, data)
end

function Traveler:JourneyAddQuestAccept(questId)
    self:JourneyCurrentChapterAddStep(self.STEP_TYPE_ACCEPT_QUEST, questId)
end

function Traveler:JourneyAddQuestComplete(questId)
    self:JourneyCurrentChapterAddStep(self.STEP_TYPE_COMPLETE_QUEST, questId)
end

function Traveler:JourneyAddQuestTurnIn(questId)
    self:JourneyCurrentChapterAddStep(self.STEP_TYPE_TURNIN_QUEST, questId)
end

function Traveler:JourneyAddBindHearthstone(location)
    self:JourneyCurrentChapterAddStep(self.STEP_TYPE_BIND_HEARTHSTONE, location)
end

function Traveler:JourneyRemoveQuest(questId)
    for _,chapter in ipairs(self.journey.chapters) do
        ArrayRemoveIf(chapter.steps, function(i)
            local step = chapter.steps[i]
            return self:IsStepQuest(step) and step.data == questId
        end)
    end
    self:JourneyRemoveEmptyChapters()
end

function Traveler:JourneyAddFlyTo(slot, name)
    self:JourneyCurrentChapterAddStep(self.STEP_TYPE_FLY_TO, { slot, name })
end

function ArrayAdd(array, value)
    array[#array+1] = value
end

function ArrayRemove(array, value)
    if array == nil then return end
    local j, n = 1, #array
    for i = 1, n do
        if array[i] ~= value then
            if i ~= j then
                array[j] = array[i]
                array[i] = nil
            end
            j = j + 1
        else
            array[i] = nil
        end
    end
end

function ArrayRemoveIf(array, func)
    if array == nil then return end
    local j, n = 1, #array
    for i = 1, n do
        if not func(i) then
            if i ~= j then
                array[j] = array[i]
                array[i] = nil
            end
            j = j + 1
        else
            array[i] = nil
        end
    end
end

function TableDeepCopy(original)
    local original_type = type(original)
    local copy
    if original_type == 'table' then
        copy = {}
        for original_key, original_value in next, original, nil do
            copy[TableDeepCopy(original_key)] = TableDeepCopy(original_value)
        end
        setmetatable(copy, TableDeepCopy(getmetatable(original)))
    else -- number, string, boolean, etc
        copy = original
    end
    return copy
end
