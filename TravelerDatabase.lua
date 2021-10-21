local addonName, addon = ...
local L = addon.Locale
local Traveler = addon.Traveler
local LibAceSerializer = LibStub:GetLibrary("AceSerializer-3.0")
local LibDeflate = LibStub:GetLibrary("LibDeflate")

local databaseDefaults = {
    profile = {
        general = {
            debug = false
        },
        tracker = {
            locked = false,
            width = 300,
            height = 300,
            relativeTo = "CENTER",
            x = 0,
            y = 0,
            alpha = 0.5
        },
        journeys = {}
    },
    char = {
        tracker = {
            show = true,
            journey = -1,
        },
        journey = {
            title = nil,
            chapters = {}
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
