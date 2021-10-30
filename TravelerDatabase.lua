local addonName, addon = ...
local L = addon.Locale
local Traveler = addon.Traveler
local LibAceSerializer = LibStub:GetLibrary("AceSerializer-3.0")
local LibDeflate = LibStub:GetLibrary("LibDeflate")

local databaseDefaults = {
    profile = {
        window = {
            locked = false,
            width = 300,
            height = 300,
            relativePoint = "CENTER",
            x = 0,
            y = 0,
            strata = "MEDIUM",
            level = 0,
            backgroundColor = {
                r = 0,
                g = 0,
                b = 0,
                a = 0.5
            },
            fontSize = 12,
            lineSpacing = 2,
            showScrollBar = false,
            showQuestLevel = true,
            showCompletedSteps = false,
            showSkippedSteps = true,
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
            journey = -1,
            chapter = 1
        }
    }
}

function Traveler:InitializeDatabase()
    self.db = LibStub("AceDB-3.0"):New(addonName.."Database", databaseDefaults, true)
    self:DeserializeDatabase()
end

function Traveler:SerializeDatabase()
    if self.journeys ~= nil then
        for i,v in ipairs(self.journeys) do
            local result, serialized = self:Serialize(v)
            if result then self.db.profile.journeys[i] = serialized end
        end
    end

    if self.journey ~= nil then
        local result, serialized = self:Serialize(self.journey)
        if result then self.db.char.journey = serialized end
    end
end

function Traveler:DeserializeDatabase()
    if self.db.profile.journeys ~= nil then
        self.journeys = {}
        for i,v in ipairs(self.db.profile.journeys) do
            local result, deserialized = self:Deserialize(v)
            if result then self.journeys[i] = deserialized end
        end
    end

    if self.db.char.journey ~= nil then
        local result, deserialized = self:Deserialize(self.db.char.journey)
        if result then self.journey = deserialized end
    end

    if self.db.char.window.journey == -1 then return end
    if self.db.char.window.journey > #self.journeys then
        self.db.char.window.journey = -1
        return
    end

    local journey = self.journeys[self.db.char.window.journey]
    if #journey.chapters <= 0 then
        self.db.char.window.chapter = -1
        return
    end

    if self.db.char.window.chapter <= 0 or self.db.char.window.chapter > #journey.chapters then
        self.db.char.window.chapter = 1
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
