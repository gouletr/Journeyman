local addonName, addon = ...
local Traveler = addon.Traveler
local L = addon.Locale
local Journey = {}
Traveler.Journey = Journey

local tinsert = table.insert
local tremove = table.remove
local function tmove(t, from, to) table.insert(t, to, table.remove(t, from)) end

function Journey:CreateJourney(title)
    if Traveler.journeys == nil then
        Traveler.journeys = {}
    end

    local journey = { guid = Traveler.Utils:CreateGUID(), title = title, chapters = {} }
    tinsert(Traveler.journeys, journey)

    return journey
end

function Journey:GetJourney(index)
    if Traveler.journeys and index > 0 and index <= #Traveler.journeys then
        return Traveler.journeys[index]
    end
end

function Journey:MoveJourney(from, to)
    if Traveler.journeys and from > 0 and from <= #Traveler.journeys and to > 0 and to <= #Traveler.journeys then
        tmove(Traveler.journeys, from, to)
        return true
    end
    return false
end

function Journey:DeleteJourney(index)
    if Traveler.journeys and index > 0 and index <= #Traveler.journeys then
        tremove(Traveler.journeys, index)
        return true
    end
    return false
end

function Journey:GetActiveJourney()
    if Traveler.journeys and Traveler.db.char.window.journey and type(Traveler.db.char.window.journey) == "string" then
        for i, journey in ipairs(Traveler.journeys) do
            if journey.guid == Traveler.db.char.window.journey then
                return journey
            end
        end
    end
end

function Journey:SetActiveJourney(journey)
    if journey and journey.guid and type(journey.guid) == "string" then
        Traveler.db.char.window.journey = journey.guid
    end
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

function Journey:MoveChapter(journey, from, to)
    if journey and journey.chapters and from > 0 and from <= #journey.chapters and to > 0 and to <= #journey.chapters then
        tmove(journey.chapters, from, to)
        return true
    end
    return false
end

function Journey:DeleteChapter(journey, index)
    if journey and journey.chapters and index > 0 and index <= #journey.chapters then
        tremove(journey.chapters, index)
        return true
    end
    return false
end

function Journey:AdvanceChapter(journey)
    local index = Traveler.db.char.window.chapter + 1
    if journey and index > 0 and index <= #journey.chapters then
        Traveler.db.char.window.chapter = index
    end
end

function Journey:GetActiveChapter(journey)
    return self:GetChapter(journey, Traveler.db.char.window.chapter)
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

function Journey:AddStep(chapter, type, data, force)
    if chapter and (force or not self:ContainsStep(chapter, type, data)) then
        if self:CreateStep(chapter, type, data) then
            Traveler:Debug("Chapter '%s' added step %s %s", chapter.title, type, data)
        end
    end
end

function Journey:GetStep(chapter, index)
    if chapter and chapter.steps and index > 0 and index <= #chapter.steps then
        return chapter.steps[index]
    end
end

function Journey:ContainsStep(chapter, type, data)
    if chapter and chapter.steps then
        for i, v in ipairs(chapter.steps) do
            if v.type == type and v.data == data then
                return true
            end
        end
    end
    return false
end

function Journey:MoveStep(chapter, from, to)
    if chapter and chapter.steps and from > 0 and from <= #chapter.steps and to > 0 and to <= #chapter.steps then
        tmove(chapter.steps, from, to)
        return true
    end
    return false
end

function Journey:DeleteStep(chapter, index)
    if chapter and chapter.steps and index > 0 and index <= #chapter.steps then
        tremove(chapter.steps, index)
        return true
    end
    return false
end

function Journey:OnQuestAccepted(questId)
    if Traveler.updateJourney then
        local journey = self:GetActiveJourney()
        local chapter = self:GetActiveChapter(journey)
        self:AddStep(chapter, Traveler.STEP_TYPE_ACCEPT_QUEST, questId)
    end
end

function Journey:OnQuestCompleted(questId)
    if Traveler.updateJourney then
        local journey = self:GetActiveJourney()
        local chapter = self:GetActiveChapter(journey)
        self:AddStep(chapter, Traveler.STEP_TYPE_COMPLETE_QUEST, questId)
    end
end

function Journey:OnQuestTurnedIn(questId)
    if Traveler.updateJourney then
        local journey = self:GetActiveJourney()
        local chapter = self:GetActiveChapter(journey)
        self:AddStep(chapter, Traveler.STEP_TYPE_TURNIN_QUEST, questId)
    end
end

function Journey:OnQuestAbandoned(questId)
end

function Journey:OnHearthstoneBound(location)
    if Traveler.updateJourney then
        local journey = self:GetActiveJourney()
        local chapter = self:GetActiveChapter(journey)
        self:AddStep(chapter, Traveler.STEP_TYPE_BIND_HEARTHSTONE, location, true)
    end
end

function Journey:OnHearthstoneUsed(location)
    if Traveler.updateJourney then
        local journey = self:GetActiveJourney()
        local chapter = self:GetActiveChapter(journey)
        self:AddStep(chapter, Traveler.STEP_TYPE_USE_HEARTHSTONE, location, true)
    end
end

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
        tinsert(self.journeys, journey)
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
    tinsert(self.journey.chapters, chapter)
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
    tinsert(chapter.steps, step)
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

function Traveler:JourneyAddUseHearthstone(location)
    self:JourneyCurrentChapterAddStep(self.STEP_TYPE_USE_HEARTHSTONE, location)
end

function Traveler:JourneyRemoveQuest(questId)
    for _,chapter in ipairs(self.journey.chapters) do
        self.Utils:RemoveIf(chapter.steps, function(i)
            local step = chapter.steps[i]
            return self:IsStepTypeQuest(step) and step.data == questId
        end)
    end
    self:JourneyRemoveEmptyChapters()
end

function Traveler:JourneyAddFlyTo(slot, name)
    self:JourneyCurrentChapterAddStep(self.STEP_TYPE_FLY_TO, { slot, name })
end
