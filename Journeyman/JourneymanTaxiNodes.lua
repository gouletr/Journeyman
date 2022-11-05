local addonName, addon = ...
local TaxiNodes, Private = addon:NewModule("TaxiNodes"), {}
local L = addon.Locale

local String = LibStub("LibCollections-1.0").String
local List = LibStub("LibCollections-1.0").List
local HBD = LibStub("HereBeDragons-2.0")

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
local next, band = next, bit.band

-- HereBeDragons
local instanceIDOverrides = HBD.___DIIDO
local transforms = HBD.transforms

local function overrideInstance(instance)
    return instanceIDOverrides[instance] or instance
end

local function applyCoordinateTransforms(x, y, instanceID)
    if transforms[instanceID] then
        for _, transformData in ipairs(transforms[instanceID]) do
            if transformData.minX <= x and transformData.maxX >= x and transformData.minY <= y and transformData.maxY >= y then
                instanceID = transformData.newInstanceID
                x = x + transformData.offsetX
                y = y + transformData.offsetY
                break
            end
        end
    end
    return x, y, overrideInstance(instanceID)
end

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

local function GetLocalizedName(data)
    if data and data.Name_lang then
        return data.Name_lang
    end
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

function TaxiNodes:OnInitialize()
end

function TaxiNodes:OnEnable()
end

function TaxiNodes:OnDisable()
end

function TaxiNodes:GetTaxiNode(id)
    local data = L.taxiNodes[id]
    if data and IsValid(id, data) then
        local name = GetLocalizedName(data)
        local instanceId = GetInstanceId(data)
        local worldX, worldY = GetWorldCoordinates(data)
        if instanceId and worldX and worldY then
            worldX, worldY, instanceId = applyCoordinateTransforms(worldX, worldY, instanceId)
        end
        local faction = GetFactionGroup(data)
        return {
            id = id,
            name = name,
            instanceId = instanceId,
            worldX = worldX,
            worldY = worldY,
            faction = faction
        }
    end
end

function TaxiNodes:GetIdsFromLocalizedName(localizedName)
    if self.localizedNameToId == nil then
        self.localizedNameToId = {}
        for id, data in pairs(L.taxiNodes) do
            if IsValid(id, data) then
                local key = GetLocalizedName(data)
                if self.localizedNameToId[key] == nil then
                    self.localizedNameToId[key] = {}
                end
                List:Add(self.localizedNameToId[key], id)
            end
        end
    end
    return self.localizedNameToId[localizedName]
end

function TaxiNodes:GetBestIdFromLocalizedName(localizedName, playerFaction, playerInstanceId)
    local ids = self:GetIdsFromLocalizedName(localizedName)
    if ids then
        return List:First(ids, function(id) return not playerFaction or self:IsAvailable(id, playerFaction, playerInstanceId) end)
    end
end

function TaxiNodes:GetTaxiNodeIdFromSlot(slot, playerFaction, playerInstanceId)
    local localizedName = TaxiNodeName(slot)
    if localizedName then
        return self:GetBestIdFromLocalizedName(localizedName, playerFaction, playerInstanceId)
    end
end

function TaxiNodes:GetLocalizedName(id, showId)
    local data = L.taxiNodes[id]
    if data then
        local localizedName = GetLocalizedName(data)
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
            x, y, instanceId = applyCoordinateTransforms(x, y, instanceId)
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
