local addonName, addon = ...
local Journeyman = addon.Journeyman
local L = addon.Locale

local TaxiNodes = {}
Journeyman.TaxiNodes = TaxiNodes

local String = LibStub("LibCollections-1.0").String

-- Constants
local FLAGS_NONE = 0
local FLAGS_SHOW_ON_ALLIANCE_MAP = 0x1
local FLAGS_SHOW_ON_HORDE_MAP = 0x2
local FLAGS_SHOW_ON_MAP = 0x3 -- FLAGS_SHOW_ON_ALLIANCE_MAP|FLAGS_SHOW_ON_HORDE_MAP
local FLAGS_SHOW_IF_CLIENT_PASSES_CONDITION = 0x8

local FACTION_ALLIANCE = "Alliance"
local FACTION_HORDE = "Horde"
local FACTION_NEUTRAL = "Neutral"

-- Lua APIs
local next, tinsert, band = next, table.insert, bit.band

-- Version dependent stuff
local invalidIds
if WOW_PROJECT_ID == WOW_PROJECT_CLASSIC then
    invalidIds = {
        84, 85, 86, 87 -- Eastern Plaguelands PvP
    }
elseif WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC then
    invalidIds = {
        84, 85, 86, 87 -- Eastern Plaguelands PvP
    }
elseif WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC then
    invalidIds = {
        84, 85, 86, 87 -- Eastern Plaguelands PvP
    }
else
    error("Unsupported WoW version (WOW_PROJECT_ID = "..WOW_PROJECT_ID..")")
end

local invalidTaxiNodeIds = {}
local invalidIdCount = #invalidIds
for i = 1, invalidIdCount do
    invalidTaxiNodeIds[invalidIds[i]] = true
end

local function IsValid(id, data)
    if id == nil or data == nil then
        return false
    end

    -- Cull out nodes in invalid list
    if invalidTaxiNodeIds[id] then
        return false
    end

    -- Cull out nodes that does not appear on alliance or horde map
    if data.Flags == nil or data.Flags == FLAGS_NONE or band(data.Flags, FLAGS_SHOW_ON_MAP) == 0 then
        return false
    end

    -- Cull out nodes without a mount creature ID
    if data.MountCreatureID == nil or next(data.MountCreatureID) == nil or (data.MountCreatureID[1] == 0 and data.MountCreatureID[2] == 0) then
        return false
    end

    return true
end

local function GetFactionGroup(data)
    if data and data.Flags then
        local flags = band(data.Flags, FLAGS_SHOW_ON_MAP)
        if flags == FLAGS_SHOW_ON_MAP then
            return FACTION_NEUTRAL
        elseif flags == FLAGS_SHOW_ON_ALLIANCE_MAP then
            return FACTION_ALLIANCE
        elseif flags == FLAGS_SHOW_ON_HORDE_MAP then
            return FACTION_HORDE
        end
    end
end

local function GetInstanceId(data)
    if data and data.ContinentID then
        return data.ContinentID
    end
end

local function GetWorldCoordinates(data)
    if data and next(data.Pos) and data.Pos[1] and data.Pos[2] then
        return data.Pos[2], data.Pos[1]
    end
end

function TaxiNodes:GetIdsFromLocalizedName(localizedName)
    if self.localizedNameToId == nil then
        self.localizedNameToId = {}
        for id, data in pairs(L.taxiNodes) do
            if IsValid(id, data) then
                local key = data.Name_lang
                if self.localizedNameToId[key] == nil then
                    self.localizedNameToId[key] = {}
                end
                tinsert(self.localizedNameToId[key], id)
            end
        end
    end
    return self.localizedNameToId[localizedName]
end

function TaxiNodes:GetBestIdFromLocalizedName(localizedName)
    local ids = self:GetIdsFromLocalizedName(localizedName)
    if ids then
        local n = #ids
        for i = 1, n do
            return ids[i]
        end
    end
end

function TaxiNodes:GetTaxiNodeIdFromSlot(slot)
    local localizedName = TaxiNodeName(slot)
    if localizedName then
        return self:GetBestIdFromLocalizedName(localizedName)
    end
end

function TaxiNodes:GetLocalizedName(id, showId)
    local data = L.taxiNodes[id]
    if data then
        local localizedName = data.Name_lang
        if not String:IsNilOrEmpty(localizedName) then
            if showId then
                localizedName = localizedName.." ("..id..")"
            end
            return localizedName
        end
    end
end

function TaxiNodes:GetFactionGroup(id)
    local data = L.taxiNodes[id]
    if data then
        return GetFactionGroup(data)
    end
end

function TaxiNodes:GetWorldCoordinates(id)
    local data = L.taxiNodes[id]
    if data then
        local instanceId = GetInstanceId(data)
        local x, y = GetWorldCoordinates(data)
        if instanceId and x and y then
            return { instanceId = instanceId, x = x, y = y }
        end
    end
end

function TaxiNodes:IsAvailable(id, playerFaction, playerInstanceId)
    local data = L.taxiNodes[id]
    if not IsValid(id, data) then
        return false
    end

    if playerFaction then
        local faction = GetFactionGroup(data)
        if faction ~= FACTION_NEUTRAL and faction ~= playerFaction then
            return false
        end
    end

    if playerInstanceId then
        local instanceId = GetInstanceId(data)
        if instanceId ~= playerInstanceId then
            return false
        end
    end

    return true
end
