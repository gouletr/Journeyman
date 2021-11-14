local addonName, addon = ...
local Traveler = addon.Traveler
local L = addon.Locale
local LibAceSerializer = LibStub:GetLibrary("AceSerializer-3.0")
local LibDeflate = LibStub:GetLibrary("LibDeflate")

local tinsert = table.insert

local databaseDefaults = {
    profile = {
        window = {
            locked = false,
            clamped = true,
            showScrollBar = false,
            showQuestLevel = true,
            showCompletedSteps = false,
            showSkippedSteps = true,
            stepsShown = 5,
            backgroundColor = {
                r = 0,
                g = 0,
                b = 0,
                a = 0.5
            },
            width = 300,
            height = 300,
            relativePoint = "CENTER",
            x = 0,
            y = 0,
            fontSize = 12,
            lineSpacing = 2,
            strata = "MEDIUM",
            level = 0
        },
        autoSetWaypoint = true,
        autoSetWaypointMin = 15,
        advanced = {
            debug = false,
            updateFrequency = 1.0
        }
    },
    char = {
        window = {
            show = true,
        },
        journey = "",
        chapter = 1,
        updateJourney = false
    }
}

function Traveler:InitializeDatabase()
    self.db = LibStub("AceDB-3.0"):New(addonName.."Database", databaseDefaults, true)
    self:DeserializeDatabase()
end

function Traveler:SerializeDatabase()
    -- Serialize journeys
    if self.journeys and type(self.journeys) == "table" then
        self.db.profile.journeys = {}
        for i = 1, #self.journeys do
            local journey = self.journeys[i]
            if journey then
                local serialized = self:ExportJourney(journey)
                if serialized then
                    tinsert(self.db.profile.journeys, serialized)
                end
            end
        end
    end
end

function Traveler:DeserializeDatabase()
    -- Deserialize journeys
    if self.db.profile.journeys and type(self.db.profile.journeys) == "table" then
        self.journeys = {}
        for i = 1, #self.db.profile.journeys do
            local journey = self.db.profile.journeys[i]
            if journey then
                local deserialized = self:ImportJourney(journey)
                if deserialized then
                    tinsert(self.journeys, deserialized)
                end
            end
        end
    end

    -- Validate active chapter
    local journey = Traveler.Journey:GetActiveJourney()
    if journey then
        if #journey.chapters <= 0 then
            self.db.char.chapter = -1
        elseif self.db.char.chapter <= 0 or self.db.char.chapter > #journey.chapters then
            self.db.char.chapter = 1
        end
    end
end

function Traveler:ExportJourney(deserializedJourney)
    local journey = { chapters = {} }

    if deserializedJourney.guid and type(deserializedJourney.guid) == "string" then
        journey.guid = deserializedJourney.guid
    else
        journey.guid = Traveler.Utils:CreateGUID()
    end

    if deserializedJourney.title and type(deserializedJourney.title) == "string" then
        journey.title = deserializedJourney.title
    else
        journey.title = L["NEW_JOURNEY_TITLE"]
    end

    if deserializedJourney.chapters and type(deserializedJourney.chapters) == "table" then
        for chapterIndex = 1, #deserializedJourney.chapters do
            local deserializedChapter = deserializedJourney.chapters[chapterIndex]

            local chapter = { steps = {} }

            if deserializedChapter.title and type(deserializedChapter.title) == "string" then
                chapter.title = deserializedChapter.title
            else
                chapter.title = L["NEW_CHAPTER_TITLE"]
            end

            if deserializedChapter.steps and type(deserializedChapter.steps) == "table" then
                for stepIndex = 1, #deserializedChapter.steps do
                    local deserializedStep = deserializedChapter.steps[stepIndex]

                    local step = {}

                    if deserializedStep.type and type(deserializedStep.type) == "string" then
                        step.type = deserializedStep.type
                    else
                        step.type = Traveler.STEP_TYPE_UNDEFINED
                    end

                    if deserializedStep.data and type(deserializedStep.data) == "number" then
                        step.data = deserializedStep.data
                    else
                        step.data = 0
                    end

                    if deserializedStep.note and type(deserializedStep.note) == "string" then
                        step.note = deserializedStep.note
                    end

                    tinsert(chapter.steps, step)
                end
            end

            tinsert(journey.chapters, chapter)
        end
    end

    local result, serializedJourney = self:Serialize(journey)
    if result then
        return serializedJourney
    end
end

function Traveler:ImportJourney(serializedJourney)
    local result, deserializedJourney = self:Deserialize(serializedJourney)
    if not result or deserializedJourney == nil then
        return nil
    end

    local journey = { chapters = {} }

    if deserializedJourney.guid and type(deserializedJourney.guid) == "string" then
        journey.guid = deserializedJourney.guid
    else
        journey.guid = Traveler.Utils:CreateGUID()
    end

    if deserializedJourney.title and type(deserializedJourney.title) == "string" then
        journey.title = deserializedJourney.title
    else
        journey.title = L["NEW_JOURNEY_TITLE"]
    end

    if deserializedJourney.chapters and type(deserializedJourney.chapters) == "table" then
        for chapterIndex = 1, #deserializedJourney.chapters do
            local deserializedChapter = deserializedJourney.chapters[chapterIndex]

            local chapter = { steps = {} }

            if deserializedChapter.title and type(deserializedChapter.title) == "string" then
                chapter.title = deserializedChapter.title
            else
                chapter.title = L["NEW_CHAPTER_TITLE"]
            end

            if deserializedChapter.steps and type(deserializedChapter.steps) == "table" then
                for stepIndex = 1, #deserializedChapter.steps do
                    local deserializedStep = deserializedChapter.steps[stepIndex]

                    local step = {}

                    if deserializedStep.type and type(deserializedStep.type) == "string" then
                        step.type = deserializedStep.type
                    else
                        step.type = Traveler.STEP_TYPE_UNDEFINED
                    end

                    if deserializedStep.data and type(deserializedStep.data) == "number" then
                        step.data = deserializedStep.data
                    else
                        step.data = 0
                    end

                    if deserializedStep.note and type(deserializedStep.note) == "string" then
                        step.note = deserializedStep.note
                    end

                    tinsert(chapter.steps, step)
                end
            end

            tinsert(journey.chapters, chapter)
        end
    end

    return journey
end

function Traveler:Serialize(...)
    local serialized = LibAceSerializer:Serialize(...)
    if serialized == nil then
        self:Print("Failed to serialize.")
        return false
    end

    local compressed = LibDeflate:CompressDeflate(serialized)
    if compressed == nil then
        self:Print("Failed to compress.")
        return false
    end

    local encoded = LibDeflate:EncodeForPrint(compressed)
    if encoded == nil then
        self:Print("Failed to encode.")
        return false
    end

    return true, encoded
end

function Traveler:Deserialize(str)
    local decoded = LibDeflate:DecodeForPrint(str)
    if decoded == nil then
        self:Print("Failed to decode string.")
        return false
    end

    local decompressed, extraBytes = LibDeflate:DecompressDeflate(decoded)
    if decompressed == nil or extraBytes > 0 then
        self:Print("Failed to decompress ("..extraBytes.." extra bytes).")
        return false
    end

    local result, deserialized = LibAceSerializer:Deserialize(decompressed)
    if result == false then
        self:Print("Failed to deserialize.")
        return false
    end

    return result, deserialized
end
