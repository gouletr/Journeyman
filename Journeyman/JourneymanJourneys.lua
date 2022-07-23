local addonName, addon = ...
local Journeyman = addon.Journeyman
local L = addon.Locale

local Journey = {}
Journeyman.Journey = Journey

local List = LibStub("LibCollections-1.0").List

local function tmove(t, from, to) table.insert(t, to, table.remove(t, from)) end

function Journey:Initialize()
    if Journeyman.journeys == nil then
        Journeyman.journeys = {}
    end
end

function Journey:CreateJourney(title)
    if Journeyman.journeys == nil then
        Journeyman.journeys = {}
    end

    if title == nil then
        title = L["NEW_JOURNEY_TITLE"]
    end

    local journey = { guid = Journeyman.Utils:CreateGUID(), title = title, chapters = {} }
    List:Add(Journeyman.journeys, journey)

    return journey
end

function Journey:GetJourney(index)
    if Journeyman.journeys and index > 0 and index <= #Journeyman.journeys then
        return Journeyman.journeys[index]
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

function Journey:GetActiveJourney()
    if Journeyman.journeys and Journeyman.db.char.journey and type(Journeyman.db.char.journey) == "string" then
        for i = 1, #Journeyman.journeys do
            local journey = Journeyman.journeys[i]
            if journey.guid == Journeyman.db.char.journey then
                return journey
            end
        end
    end
end

function Journey:SetActiveJourney(journey)
    if journey and journey.guid and type(journey.guid) == "string" then
        Journeyman.db.char.journey = journey.guid
    end
end

function Journey:CreateChapter(journey, title)
    if journey then
        if journey.chapters == nil then
            journey.chapters = {}
        end

        if title == nil then
            title = L["NEW_CHAPTER_TITLE"]
        end

        local chapter = { journey = journey, title = title, steps = {} }
        List:Add(journey.chapters, chapter)
        Journeyman:ResetJourneyState(journey)

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
    end
end

function Journey:GetActiveChapter(journey)
    return self:GetChapter(journey, Journeyman.db.char.chapter)
end

function Journey:GetOrCreateLastChapter(journey)
    if journey then
        local chapter
        if journey.chapters and #journey.chapters > 0 then
            chapter = journey.chapters[#journey.chapters]
        end

        if chapter == nil then
            chapter = self:CreateChapter(journey)
        end

        return chapter
    end
end

function Journey:CreateStep(journey, chapter, type, data, index)
    if journey and chapter then
        if chapter.steps == nil then
            chapter.steps = {}
        end

        local step = { type = type, data = data }
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

function Journey:ContainsStep(chapter, type, data)
    if chapter and chapter.steps then
        for i = 1, #chapter.steps do
            local step = chapter.steps[i]
            if step.type == type and step.data == data then
                return true
            end
        end
    end
    return false
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

local function AddStep(journey, chapter, type, data, force)
    if Journeyman.db.char.updateJourney then
        if journey and chapter and (force or not Journey:ContainsStep(chapter, type, data)) then
            local step = Journey:CreateStep(journey, chapter, type, data)
            if step then
                Journeyman:Print("Step %s added.", Journeyman:GetStepText(step, true, true))
                Journeyman.State:Reset()
            end
        end
    end
end

function Journey:OnQuestAccepted(questId)
    if Journeyman.db.char.updateJourney then
        local journey = self:GetActiveJourney()
        local chapter = self:GetOrCreateLastChapter(journey)
        AddStep(journey, chapter, Journeyman.STEP_TYPE_ACCEPT_QUEST, tostring(questId))
    end
end

function Journey:OnQuestCompleted(questId)
    if Journeyman.db.char.updateJourney then
        local journey = self:GetActiveJourney()
        local chapter = self:GetOrCreateLastChapter(journey)
        AddStep(journey, chapter, Journeyman.STEP_TYPE_COMPLETE_QUEST, tostring(questId))
    end
end

function Journey:OnQuestTurnedIn(questId)
    if Journeyman.db.char.updateJourney then
        local journey = self:GetActiveJourney()
        local chapter = self:GetOrCreateLastChapter(journey)
        AddStep(journey, chapter, Journeyman.STEP_TYPE_TURNIN_QUEST, tostring(questId))
    end
end

function Journey:OnQuestAbandoned(questId)
    -- if Journeyman.db.char.updateJourney then
        -- local journey = self:GetActiveJourney()
        -- if journey.chapters then
            -- for chapterIndex = 1, #journey.chapters do
                -- local chapter = journey.chapters[chapterIndex]
                -- if chapter and chapter.steps then
                    -- for stepIndex = #chapter.steps, 1, -1 do
                        -- local step = chapter.steps[stepIndex]
                        -- if Journeyman:IsStepTypeQuest(step) and step.data == questId then
                            -- if self:DeleteStep(chapter, stepIndex) then
                                -- Journeyman:Debug("Removed step '%s' from chapter '%s'", Journeyman:GetStepText(step, true, true), chapter.title)
                            -- end
                        -- end
                    -- end
                -- end
            -- end
        -- end
    -- end
end

function Journey:OnLevelUp(level)
    if Journeyman.db.char.updateJourney then
        local journey = self:GetActiveJourney()
        local chapter = self:GetOrCreateLastChapter(journey)
        AddStep(journey, chapter, Journeyman.STEP_TYPE_REACH_LEVEL, tostring(level))
    end
end

function Journey:OnHearthstoneBound(areaId)
    if Journeyman.db.char.updateJourney then
        local journey = self:GetActiveJourney()
        local chapter = self:GetOrCreateLastChapter(journey)
        AddStep(journey, chapter, Journeyman.STEP_TYPE_BIND_HEARTHSTONE, tostring(areaId), true)
    end
end

function Journey:OnHearthstoneUsed(areaId)
    if Journeyman.db.char.updateJourney then
        local journey = self:GetActiveJourney()
        local chapter = self:GetOrCreateLastChapter(journey)
        AddStep(journey, chapter, Journeyman.STEP_TYPE_USE_HEARTHSTONE, tostring(areaId), true)
    end
end

function Journey:OnLearnFlightPath(taxiNodeId)
    if Journeyman.db.char.updateJourney then
        local journey = self:GetActiveJourney()
        local chapter = self:GetOrCreateLastChapter(journey)
        AddStep(journey, chapter, Journeyman.STEP_TYPE_LEARN_FLIGHT_PATH, tostring(taxiNodeId))
    end
end

function Journey:OnTakeFlightPath(taxiNodeId)
    if Journeyman.db.char.updateJourney then
        local journey = self:GetActiveJourney()
        local chapter = self:GetOrCreateLastChapter(journey)
        AddStep(journey, chapter, Journeyman.STEP_TYPE_FLY_TO, tostring(taxiNodeId), true)
    end
end

function Journey:OnClassTrainerClosed()
    if Journeyman.db.char.updateJourney then
        local journey = self:GetActiveJourney()
        local chapter = self:GetOrCreateLastChapter(journey)
        AddStep(journey, chapter, Journeyman.STEP_TYPE_TRAIN_CLASS, "", true)
    end
end
