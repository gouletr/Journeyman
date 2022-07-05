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
            autoScroll = true,
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
            indentSize = 0,
            stepSpacing = 8,
            strata = "BACKGROUND",
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
        hardcoreMode = false,
        updateJourney = false,
        taxiNodeIds = {}
    }
}

function Journeyman:InitializeDatabase()
    -- Create database
    self.db = LibStub("AceDB-3.0"):New(addonName.."Database", databaseDefaults, true)
    if self.db.profile.advanced.debug then
        _G["Journeyman"] = Journeyman
    end

    -- Initialize known taxi node ids per race
    if WOW_PROJECT_ID == WOW_PROJECT_CLASSIC then
        if Journeyman.player.raceName == "Human" then
            Journeyman.db.char.taxiNodeIds[2] = true -- Stormwind, Elwynn
        elseif Journeyman.player.raceName == "Orc" or Journeyman.player.raceName == "Troll" then
            Journeyman.db.char.taxiNodeIds[23] = true -- Orgrimmar, Durotar
        elseif Journeyman.player.raceName == "Dwarf" or Journeyman.player.raceName == "Gnome" then
            Journeyman.db.char.taxiNodeIds[6] = true -- Ironforge, Dun Morogh
        elseif Journeyman.player.raceName == "NightElf" then
            Journeyman.db.char.taxiNodeIds[26] = true -- Auberdine, Darkshore
            Journeyman.db.char.taxiNodeIds[27] = true -- Rut'theran Village, Teldrassil
        elseif Journeyman.player.raceName == "Scourge" then
            Journeyman.db.char.taxiNodeIds[11] = true -- Undercity, Tirisfal
        elseif Journeyman.player.raceName == "Tauren" then
            Journeyman.db.char.taxiNodeIds[22] = true -- Thunder Bluff, Mulgore
        end
    else
        Journeyman:Error("Unsupported version of WoW. (WOW_PROJECT_ID = %s)", WOW_PROJECT_ID)
    end

    -- Deserialize database
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
                        step.data = tostring(deserializedStep.data)
                    elseif deserializedStep.data and type(deserializedStep.data) == "string" then
                        step.data = deserializedStep.data
                    else
                        step.data = ""
                    end

                    if deserializedStep.requiredRaces and type(deserializedStep.requiredRaces) == "number" then
                        step.requiredRaces = deserializedStep.requiredRaces
                    end

                    if deserializedStep.requiredClasses and type(deserializedStep.requiredClasses) == "number" then
                        step.requiredClasses = deserializedStep.requiredClasses
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
        -- Make sure guids are unique
        for i = 1, #Journeyman.journeys do
            if journey.guid == Journeyman.journeys[i].guid then
                journey.guid = Journeyman.Utils:CreateGUID()
                break
            end
        end
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
                        step.data = tostring(deserializedStep.data)
                    elseif deserializedStep.data and type(deserializedStep.data) == "string" then
                        step.data = deserializedStep.data
                    else
                        step.data = ""
                    end

                    if deserializedStep.requiredRaces and type(deserializedStep.requiredRaces) == "number" then
                        step.requiredRaces = deserializedStep.requiredRaces
                    end

                    if deserializedStep.requiredClasses and type(deserializedStep.requiredClasses) == "number" then
                        step.requiredClasses = deserializedStep.requiredClasses
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
