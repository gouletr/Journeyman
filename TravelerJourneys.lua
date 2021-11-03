local addonName, addon = ...
local Traveler = addon.Traveler
local L = addon.Locale
local Journey = {}
Traveler.Journey = Journey

local tinsert = table.insert
local tremove = table.remove

function Journey:CreateJourney(title)
    if Traveler.journeys == nil then
        Traveler.journeys = {}
    end

    local journey = { title = title, chapters = {} }
    tinsert(Traveler.journeys, journey)

    return journey
end

function Journey:GetJourney(index)
    if Traveler.journeys and index > 0 and index <= #Traveler.journeys then
        return Traveler.journeys[index]
    end
end

function Journey:DeleteJourney(index)
    if Traveler.journeys and index > 0 and index <= #Traveler.journeys then
        tremove(Traveler.journeys, index)
        return true
    end
    return false
end

function Journey:CreateChapter(journey, title)
    if journey then
        if journey.chapters == nil then
            journey.chapters = {}
        end

        local chapter = { title = title, steps = {} }
        tinsert(journey.chapters, chapter)

        return chapter
    end
end

function Journey:GetChapter(journey, index)
    if journey and journey.chapters and index > 0 and index <= #journey.chapters then
        return journey.chapters[index]
    end
end

function Journey:DeleteChapter(journey, index)
    if journey and journey.chapters and index > 0 and index <= #journey.chapters then
        tremove(journey.chapters, index)
        return true
    end
    return false
end

function Journey:CreateStep(chapter, type, data)
    if chapter then
        if chapter.steps == nil then
            chapter.steps = {}
        end

        local step = { type = type, data = data }
        tinsert(chapter.steps, step)

        return step
    end
end

function Journey:GetStep(chapter, index)
    if chapter and chapter.steps and index > 0 and index <= #chapter.steps then
        return chapter.steps[index]
    end
end

function Journey:DeleteStep(chapter, index)
    if chapter and chapter.steps and index > 0 and index <= #chapter.steps then
        tremove(chapter.steps, index)
        return true
    end
    return false
end

Traveler.STEP_TYPE_UNDEFINED = "UNDEFINED"
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
        local journey = self.Utils:Clone(self.journey)
        self.Utils:Add(self.journeys, journey)
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
    self.Utils:Add(self.journey.chapters, chapter)
    return chapter
end

function Traveler:JourneyRemoveEmptyChapters()
    self.Utils:RemoveIf(self.journey.chapters, function(i)
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
    self.Utils:Add(chapter.steps, step)
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
        self.Utils:RemoveIf(chapter.steps, function(i)
            local step = chapter.steps[i]
            return self:IsStepQuest(step) and step.data == questId
        end)
    end
    self:JourneyRemoveEmptyChapters()
end

function Traveler:JourneyAddFlyTo(slot, name)
    self:JourneyCurrentChapterAddStep(self.STEP_TYPE_FLY_TO, { slot, name })
end
