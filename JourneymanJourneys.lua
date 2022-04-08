local addonName, addon = ...
local Journeyman = addon.Journeyman
local L = addon.Locale
local Journey = {}
Journeyman.Journey = Journey

local tinsert = table.insert
local tremove = table.remove
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
    tinsert(Journeyman.journeys, journey)

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
    if Journeyman.journeys and index > 0 and index <= #Journeyman.journeys then
        tremove(Journeyman.journeys, index)
        return true
    end
    return false
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

function Journey:CreateStep(chapter, type, data, index)
    if chapter then
        if chapter.steps == nil then
            chapter.steps = {}
        end

        local step = { type = type, data = data }
        if index and index > 0 and index <= #chapter.steps then
            tinsert(chapter.steps, index, step)
        else
            tinsert(chapter.steps, step)
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

local function AddStep(chapter, type, data, force)
    if Journeyman.db.char.updateJourney then
        if chapter and (force or not Journey:ContainsStep(chapter, type, data)) then
            local step = Journey:CreateStep(chapter, type, data)
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
        AddStep(chapter, Journeyman.STEP_TYPE_ACCEPT_QUEST, tostring(questId))
    end
end

function Journey:OnQuestCompleted(questId)
    if Journeyman.db.char.updateJourney then
        local journey = self:GetActiveJourney()
        local chapter = self:GetOrCreateLastChapter(journey)
        AddStep(chapter, Journeyman.STEP_TYPE_COMPLETE_QUEST, tostring(questId))
    end
end

function Journey:OnQuestTurnedIn(questId)
    if Journeyman.db.char.updateJourney then
        local journey = self:GetActiveJourney()
        local chapter = self:GetOrCreateLastChapter(journey)
        AddStep(chapter, Journeyman.STEP_TYPE_TURNIN_QUEST, tostring(questId))
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
        AddStep(chapter, Journeyman.STEP_TYPE_REACH_LEVEL, tostring(level))
    end
end

function Journey:OnHearthstoneBound(areaId)
    if Journeyman.db.char.updateJourney then
        local journey = self:GetActiveJourney()
        local chapter = self:GetOrCreateLastChapter(journey)
        AddStep(chapter, Journeyman.STEP_TYPE_BIND_HEARTHSTONE, tostring(areaId), true)
    end
end

function Journey:OnHearthstoneUsed(areaId)
    if Journeyman.db.char.updateJourney then
        local journey = self:GetActiveJourney()
        local chapter = self:GetOrCreateLastChapter(journey)
        AddStep(chapter, Journeyman.STEP_TYPE_USE_HEARTHSTONE, tostring(areaId), true)
    end
end

function Journey:OnLearnFlightPath(taxiNodeId)
    if Journeyman.db.char.updateJourney then
        local journey = self:GetActiveJourney()
        local chapter = self:GetOrCreateLastChapter(journey)
        AddStep(chapter, Journeyman.STEP_TYPE_LEARN_FLIGHT_PATH, tostring(taxiNodeId))
    end
end

function Journey:OnTakeFlightPath(taxiNodeId)
    if Journeyman.db.char.updateJourney then
        local journey = self:GetActiveJourney()
        local chapter = self:GetOrCreateLastChapter(journey)
        AddStep(chapter, Journeyman.STEP_TYPE_FLY_TO, tostring(taxiNodeId), true)
    end
end

function Journey:OnTrainerClosed()
    if Journeyman.db.char.updateJourney then
        local journey = self:GetActiveJourney()
        local chapter = self:GetOrCreateLastChapter(journey)
        AddStep(chapter, Journeyman.STEP_TYPE_TRAIN_CLASS, "", true)
    end
end
