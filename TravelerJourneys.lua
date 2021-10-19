local addonName, addon = ...
local L = addon.Locale
local Traveler = addon.Traveler
local Grail = Grail

function Traveler:InitializeJourney()
    if self.db.char.journey == nil or self.db.char.journey.chapters == nil then
        self.db.char.journey = {
            title = nil,
            chapters = {}
        }
    end

    if self.db.char.journey.title == nil then
        local playerName = UnitName("player")
        self.db.char.journey.title = playerName.."'s Journey"
    end

    self:JourneyRemoveEmptyChapters()
end

function Traveler:ImportFromCharacter()
    
end

function Traveler:JourneyAddChapter(title)
    local chapter = {
        title = title,
        level = UnitLevel("player"),
        steps = {}
    }
    ArrayAdd(self.db.char.journey.chapters, chapter)
    return chapter
end

function Traveler:JourneyRemoveEmptyChapters()
    ArrayRemoveIf(self.db.char.journey.chapters, function(i)
        local chapter = self.db.char.journey.chapters[i]
        return #chapter.steps == 0
    end)
end

function Traveler:JourneyCurrentChapter()
    local uiMapId = C_Map.GetBestMapForUnit("player")
    local mapInfo = uiMapId and C_Map.GetMapInfo(uiMapId) or nil
    local mapName = mapInfo and mapInfo.name or ""
    local chapterCount = #self.db.char.journey.chapters

    if chapterCount == 0 then
        return self:JourneyAddChapter(mapName)
    end

    local lastChapter = self.db.char.journey.chapters[chapterCount]
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
    local currentChapter = self:JourneyCurrentChapter()
    self:JourneyCurrentChapterAddStep(currentChapter, type, data)
end

function Traveler:JourneyAddQuestAccept(questId)
    self:JourneyCurrentChapterAddStep("ACCEPT", questId)
end

function Traveler:JourneyAddQuestTurnIn(questId)
    self:JourneyCurrentChapterAddStep("TURNIN", questId)
end

function Traveler:JourneyRemoveQuest(questId)
    for _,chapter in ipairs(self.db.char.journey.chapters) do
        ArrayRemoveIf(chapter.steps, function(i)
            local step = chapter.steps[i]
            return step.data == questId and (step.type == "ACCEPT" or step.type == "TURNIN" or step.type == "COMPLETE")
        end)
    end
    self:JourneyRemoveEmptyChapters()
end

function Traveler:JourneyAddFlyTo(slot, name)
    self:JourneyCurrentChapterAddStep("FLYTO", { slot, name })
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
