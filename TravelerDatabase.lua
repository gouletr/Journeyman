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
            stepsShown = 3,
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
    if self.journeys then
        self.db.profile.journeys = {}
        for i = 1, #self.journeys do
            local journey = self.journeys[i]
            if journey then
                local result, serialized = self:Serialize(journey)
                if result then
                    self.db.profile.journeys[i] = serialized
                end
            end
        end
    end
end

function Traveler:DeserializeDatabase()
    -- Deserialize journeys
    if self.db.profile.journeys then
        self.journeys = {}
        for journeyIndex = 1, #self.db.profile.journeys do
            local result, deserialized = self:Deserialize(self.db.profile.journeys[journeyIndex])
            if result then
                local journey = deserialized
                if journey then
                    local newJourney = {
                        guid = journey.guid or Traveler.Utils:CreateGUID(),
                        title = journey.title or L["NEW_JOURNEY_TITLE"],
                        chapters = {}
                    }
                    if journey.chapters then
                        for chapterIndex = 1, #journey.chapters do
                            local chapter = journey.chapters[chapterIndex]
                            local newChapter = {
                                title = chapter.title or L["NEW_CHAPTER_TITLE"],
                                steps = {}
                            }
                            if chapter.steps then
                                for stepIndex = 1, #chapter.steps do
                                    local step = chapter.steps[stepIndex]
                                    local newStep = {
                                        type = step.type or Traveler.STEP_TYPE_UNDEFINED,
                                        data = step.data or 0,
                                        note = step.node
                                    }
                                    tinsert(newChapter, newStep)
                                end
                            end
                            tinsert(newJourney.chapters, chapter)
                        end
                    end
                    tinsert(self.journeys, newJourney)
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
