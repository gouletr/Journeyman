local addonName, addon = ...
local L = addon.Locale
local Traveler = addon.Traveler

local HBD = LibStub("HereBeDragonsQuestie-2.0")
local QuestieDB = QuestieLoader and QuestieLoader:ImportModule("QuestieDB")
local QuestiePlayer = QuestieLoader and QuestieLoader:ImportModule("QuestiePlayer")
local QuestieLib = QuestieLoader and QuestieLoader:ImportModule("QuestieLib")
local QuestieZoneDB = QuestieLoader and QuestieLoader:ImportModule("ZoneDB")

local DataSourceQuestie = {}

function DataSourceQuestie:IsInitialized()
    return QuestieDB ~= nil and QuestieDB.QueryQuest ~= nil and type(QuestieDB.QueryQuest) == "function"
end

function DataSourceQuestie:GetQuestName(questId)
    local name = QuestieDB.QueryQuestSingle(questId, "name");
    local level, _ = QuestieLib:GetTbcLevel(questId)
    if Traveler.db.profile.tracker.showLevel then
        name = QuestieLib:GetQuestString(questId, name, level, true)
    end
    return name
end

function DataSourceQuestie:GetQuestLevel(questId)
    return QuestieLib:GetTbcLevel(questId)
end

local function UpdateIfNearest(nearest, playerX, playerY, x, y, uiMapId, name, type)
    if x and y then
        local distance = HBD:GetWorldDistance(nil, playerX or 0, playerY or 0, x, y)
        if nearest.distance > distance then
            nearest.distance = distance
            nearest.x = x
            nearest.y = y
            nearest.uiMapId = uiMapId
            nearest.name = name
            nearest.type = type
        end
    end
end

local function GetNearestObject(nearest, objects, playerX, playerY)
    for _, objectId in ipairs(objects or {}) do
        local obj = QuestieDB:GetObject(objectId)
        if obj ~= nil and obj.spawns ~= nil then
            for zone, spawns in pairs(obj.spawns) do
                if zone ~= nil and spawns ~= nil then
                    local uiMapId = QuestieZoneDB:GetUiMapIdByAreaId(zone)
                    for _, coords in ipairs(spawns) do
                        if coords[1] ~= -1 and coords[2] ~= -1 then
                            local x, y = HBD:GetWorldCoordinatesFromZone(coords[1] / 100, coords[2] / 100, uiMapId)
                            UpdateIfNearest(nearest, playerX, playerY, x, y, upMapId, obj.name, "Object")
                        else
                            local dungeonLocation = QuestieZoneDB:GetDungeonLocation(zone)
                            if dungeonLocation ~= nil then
                                for _, value in ipairs(dungeonLocation) do
                                    if value[1] and value[2] then
                                        local x, y = HBD:GetWorldCoordinatesFromZone(value[1] / 100, value[2] / 100, QuestieZoneDB:GetUiMapIdByAreaId(value[3]))
                                        UpdateIfNearest(nearest, playerX, playerY, x, y, upMapId, obj.name, "Object")
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

local function GetNearestNPC(nearest, npcs, playerX, playerY)
    for _, npcId in ipairs(npcs or {}) do
        local npc = QuestieDB:GetNPC(npcId)
        if npc ~= nil and npc.spawns ~= nil then
            for zone, spawns in pairs(npc.spawns) do
                if zone ~= nil and spawns ~= nil then
                    local uiMapId = QuestieZoneDB:GetUiMapIdByAreaId(zone)
                    for _, coords in ipairs(spawns) do
                        if coords[1] ~= -1 and coords[2] ~= -1 then
                            local x, y = HBD:GetWorldCoordinatesFromZone(coords[1] / 100, coords[2] / 100, uiMapId)
                            UpdateIfNearest(nearest, playerX, playerY, x, y, upMapId, npc.name, "NPC")
                        else
                            local dungeonLocation = QuestieZoneDB:GetDungeonLocation(zone)
                            if dungeonLocation ~= nil then
                                for _, value in ipairs(dungeonLocation) do
                                    if value[1] and value[2] then
                                        local x, y = HBD:GetWorldCoordinatesFromZone(value[1] / 100, value[2] / 100, QuestieZoneDB:GetUiMapIdByAreaId(value[3]))
                                        UpdateIfNearest(nearest, playerX, playerY, x, y, upMapId, npc.name, "NPC")
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

function DataSourceQuestie:GetNearestQuestStarter(questId)
    local quest = QuestieDB:GetQuest(questId)
    if quest == nil then return nil end

    local playerX, playerY = HBD:GetPlayerWorldPosition()
    local nearest = {
        distance = 999999,
        x = -1,
        y = -1,
        uiMapId = -1,
        name = "",
        type = ""
    }

    for starterType, starters in pairs(quest.Starts) do
        if starterType == "GameObject" then
            GetNearestObject(nearest, starters, playerX, playerY)
        elseif starterType == "NPC" then
            GetNearestNPC(nearest, starters, playerX, playerY)
        end
    end

    if nearest.x == -1 then
        Traveler:Debug("Could not find nearest quest starter for "..questId)
    end

    return nearest
end

function DataSourceQuestie:GetNearestQuestFinisher(questId)
    local quest = QuestieDB:GetQuest(questId)
    if quest == nil then return nil end

    local playerX, playerY = HBD:GetPlayerWorldPosition()
    local nearest = {
        distance = 999999,
        x = -1,
        y = -1,
        uiMapId = -1,
        name = "",
        type = ""
    }

    if quest.Finisher.Type == "object" then
        -- finisher = QuestieDB:GetObject(quest.Finisher.Id)
        local finishers = {}
        finishers[#finishers + 1] = quest.Finisher.Id
        GetNearestObject(nearest, finishers, playerX, playerY)
    elseif quest.Finisher.Type == "monster" then
        -- finisher = QuestieDB:GetNPC(quest.Finisher.Id)
        local finishers = {}
        finishers[#finishers + 1] = quest.Finisher.Id
        GetNearestNPC(nearest, finishers, playerX, playerY)
    end

    if nearest.x == -1 then
        Traveler:Debug("Could not find nearest quest finisher for "..questId)
    end

    return nearest
end

Traveler.DataSource = DataSourceQuestie
