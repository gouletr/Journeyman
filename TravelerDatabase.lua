local addonName, addon = ...
local Traveler = addon.Traveler
local L = addon.Locale
local LibAceSerializer = LibStub:GetLibrary("AceSerializer-3.0")
local LibDeflate = LibStub:GetLibrary("LibDeflate")

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
            journey = "",
            chapter = 1
        }
    }
}

function Traveler:InitializeDatabase()
    self.db = LibStub("AceDB-3.0"):New(addonName.."Database", databaseDefaults, true)
    self:DeserializeDatabase()
end

function Traveler:SerializeDatabase()
    if self.journeys then
        self.db.profile.journeys = {}
        for i,v in ipairs(self.journeys) do
            local result, serialized = self:Serialize(v)
            if result then self.db.profile.journeys[i] = serialized end
        end
    end

    if self.journey then
        local result, serialized = self:Serialize(self.journey)
        if result then self.db.char.journey = serialized end
    end
end

function Traveler:DeserializeDatabase()
    -- Deserialize journeys
    if self.db.profile.journeys then
        self.journeys = {}
        for i,v in ipairs(self.db.profile.journeys) do
            local result, deserialized = self:Deserialize(v)
            if result then
                if deserialized.guid == nil or type(deserialized.guid) ~= "string" then
                    deserialized.guid = Traveler.Utils:CreateGUID()
                end
                self.journeys[i] = deserialized
            end
        end
    end

    -- Deserialize character journey
    if self.db.char.journey then
        local result, deserialized = self:Deserialize(self.db.char.journey)
        if result then self.journey = deserialized end
    end

    -- Validate active journey
    if self.db.char.window.journey == nil or type(self.db.char.window.journey) ~= "string" then
        self.db.char.window.journey = ""
    end

    -- Validate active chapter
    local journey = Traveler.Journey:GetActiveJourney()
    if journey then
        if #journey.chapters <= 0 then
            self.db.char.window.chapter = -1
        elseif self.db.char.window.chapter <= 0 or self.db.char.window.chapter > #journey.chapters then
            self.db.char.window.chapter = 1
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
