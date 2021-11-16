local addonName, addon = ...
local Journeyman = addon.Journeyman
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

function Journeyman:InitializeDatabase()
    self.db = LibStub("AceDB-3.0"):New(addonName.."Database", databaseDefaults, true)
    self:DeserializeDatabase()
end

function Journeyman:SerializeDatabase()
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

    -- Serialize state
    -- if self.State.steps and type(self.State.steps) == "table" then
        -- local serialized = self:ExportState(self.State.steps)
        -- if serialized then
            -- self.db.char.state = serialized
        -- end
    -- end
end

function Journeyman:DeserializeDatabase()
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

    -- Deserialize state
    -- if self.db.char.state and type(self.db.char.state) == "string" then
        -- local deserialized = self:ImportState(self.db.char.state)
        -- if deserialized then
            -- self.State.steps = deserialized
        -- end
    -- end

    -- Validate active chapter
    local journey = Journeyman.Journey:GetActiveJourney()
    if journey then
        if #journey.chapters <= 0 then
            self.db.char.chapter = -1
        elseif self.db.char.chapter <= 0 or self.db.char.chapter > #journey.chapters then
            self.db.char.chapter = 1
        end
    end
end

function Journeyman:ExportJourney(deserializedJourney)
    local journey = { chapters = {} }

    if deserializedJourney.guid and type(deserializedJourney.guid) == "string" then
        journey.guid = deserializedJourney.guid
    else
        journey.guid = Journeyman.Utils:CreateGUID()
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
                        step.type = Journeyman.STEP_TYPE_UNDEFINED
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
    if not result then
        return nil, serializedJourney
    end

    return serializedJourney
end

function Journeyman:ImportJourney(serializedJourney)
    local result, deserializedJourney = self:Deserialize(serializedJourney)
    if not result then
        return nil, deserializedJourney
    end

    local journey = { chapters = {} }

    if deserializedJourney.guid and type(deserializedJourney.guid) == "string" then
        journey.guid = deserializedJourney.guid
    else
        journey.guid = Journeyman.Utils:CreateGUID()
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
                        step.type = Journeyman.STEP_TYPE_UNDEFINED
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

function Journeyman:ExportState(deserializedState)
    local state = {}

    for i = 1, #deserializedState do
        local deserializedStep = deserializedState[i]

        local step = {}

        if deserializedStep.type and type(deserializedStep.type) == "string" then
            step.type = deserializedStep.type
        end

        if deserializedStep.data and type(deserializedStep.data) == "number" then
            step.data = deserializedStep.data
        end

        if deserializedStep.note and type(deserializedStep.note) == "string" then
            step.note = deserializedStep.note
        end

        if deserializedStep.index and type(deserializedStep.index) == "number" then
            step.index = deserializedStep.index
        end

        if deserializedStep.isComplete and type(deserializedStep.isComplete) == "boolean" then
            step.isComplete = deserializedStep.isComplete
        end

        tinsert(state, step)
    end

    local result, serializedState = self:Serialize(state)
    if result and serializedState then
        return serializedState
    end
end

function Journeyman:ImportState(serializedState)
    local result, deserializedState = self:Deserialize(serializedState)
    if not result or deserializedState == nil or type(deserializedState) ~= "table" then
        return nil
    end

    local state = {}

    for i = 1, #deserializedState do
        local deserializedStep = deserializedState[i]

        local step = {}

        if deserializedStep.type and type(deserializedStep.type) == "string" then
            step.type = deserializedStep.type
        end

        if deserializedStep.data and type(deserializedStep.data) == "number" then
            step.data = deserializedStep.data
        end

        if deserializedStep.note and type(deserializedStep.note) == "string" then
            step.note = deserializedStep.note
        end

        if deserializedStep.index and type(deserializedStep.index) == "number" then
            step.index = deserializedStep.index
        end

        if deserializedStep.isComplete and type(deserializedStep.isComplete) == "boolean" then
            step.isComplete = deserializedStep.isComplete
        end

        tinsert(state, step)
    end

    return state
end

function Journeyman:Serialize(...)
    local serialized = LibAceSerializer:Serialize(...)
    if serialized == nil then
        return false, "Failed to serialize."
    end

    local compressed = LibDeflate:CompressDeflate(serialized)
    if compressed == nil then
        return false, "Failed to compress."
    end

    local encoded = LibDeflate:EncodeForPrint(compressed)
    if encoded == nil then
        return false, "Failed to encode."
    end

    return true, encoded
end

function Journeyman:Deserialize(str)
    local decoded = LibDeflate:DecodeForPrint(str)
    if decoded == nil then
        return false, "Failed to decode string."
    end

    local decompressed, extraBytes = LibDeflate:DecompressDeflate(decoded)
    if decompressed == nil or extraBytes > 0 then
        return false, "Failed to decompress ("..extraBytes.." extra bytes)."
    end

    local result, deserialized = LibAceSerializer:Deserialize(decompressed)
    if result == false then
        return false, "Failed to deserialize."
    end

    return result, deserialized
end
