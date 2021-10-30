local addonName, addon = ...
local L = addon.Locale
local Traveler = addon.Traveler

local HBD = LibStub("HereBeDragonsQuestie-2.0")
local QuestieDB = QuestieLoader and QuestieLoader:ImportModule("QuestieDB")
local QuestiePlayer = QuestieLoader and QuestieLoader:ImportModule("QuestiePlayer")
local QuestieMap = QuestieLoader and QuestieLoader:ImportModule("QuestieMap")
local QuestieLib = QuestieLoader and QuestieLoader:ImportModule("QuestieLib")
local QuestieZoneDB = QuestieLoader and QuestieLoader:ImportModule("ZoneDB")

local DataSourceQuestie = {}

function DataSourceQuestie:IsInitialized()
    return QuestieDB ~= nil and QuestieDB.QueryQuest ~= nil and type(QuestieDB.QueryQuest) == "function"
end

function DataSourceQuestie:GetQuestName(questId, showLevel)
    local name = QuestieDB.QueryQuestSingle(questId, "name");
    local level, _ = QuestieLib:GetTbcLevel(questId)
    if showLevel then
        name = QuestieLib:GetQuestString(questId, name, level, true)
    end
    return name
end

function DataSourceQuestie:GetQuestLevel(questId)
    return QuestieLib:GetTbcLevel(questId)
end

function DataSourceQuestie:GetQuestExclusiveTo(questId)
    local quest = QuestieDB:GetQuest(questId)
    if quest ~= nil then return quest.exclusiveTo end
end

local function UpdateIfNearest(nearest, player, world, coords, name, type)
    if world.x and world.y then
        local distance = HBD:GetWorldDistance(world.uiMapId, player.x or 0, player.y or 0, world.x, world.y)
        if distance then
            if nearest.distance > distance then
                nearest.distance = distance
                nearest.x = coords.x
                nearest.y = coords.y
                nearest.uiMapId = coords.uiMapId
                nearest.name = name
                nearest.type = type
            end
        end
    end
end

local function GetNearestObject(nearest, objects, player)
    for _, objectId in ipairs(objects or {}) do
        local obj = QuestieDB:GetObject(objectId)
        if obj ~= nil and obj.spawns ~= nil then
            for zone, spawns in pairs(obj.spawns) do
                if zone ~= nil and spawns ~= nil then
                    local uiMapId = QuestieZoneDB:GetUiMapIdByAreaId(zone)
                    for _, coords in ipairs(spawns) do
                        if coords[1] ~= -1 and coords[2] ~= -1 then
                            local worldX, worldY, worldI = HBD:GetWorldCoordinatesFromZone(coords[1] / 100.0, coords[2] / 100.0, uiMapId)
                            UpdateIfNearest(nearest, player, { x = worldX, y = worldY, uiMapId = worldI }, { x = coords[1], y = coords[2], uiMapId = uiMapId }, obj.name, "Object")
                        else
                            local dungeonLocation = QuestieZoneDB:GetDungeonLocation(zone)
                            if dungeonLocation ~= nil then
                                for _, value in ipairs(dungeonLocation) do
                                    if value[1] and value[2] then
                                        local worldX, worldY, worldI = HBD:GetWorldCoordinatesFromZone(value[1] / 100.0, value[2] / 100.0, QuestieZoneDB:GetUiMapIdByAreaId(value[3]))
                                        UpdateIfNearest(nearest, player, { x = worldX, y = worldY, uiMapId = worldI }, { x = value[1], y = value[2], uiMapId = uiMapId }, obj.name, "Object")
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

local function GetNearestNPC(nearest, npcs, player)
    for _, npcId in ipairs(npcs or {}) do
        local npc = QuestieDB:GetNPC(npcId)
        if npc ~= nil and npc.spawns ~= nil then
            for zone, spawns in pairs(npc.spawns) do
                if zone ~= nil and spawns ~= nil then
                    local uiMapId = QuestieZoneDB:GetUiMapIdByAreaId(zone)
                    for _, coords in ipairs(spawns) do
                        if coords[1] ~= -1 and coords[2] ~= -1 then
                            local worldX, worldY, worldI = HBD:GetWorldCoordinatesFromZone(coords[1] / 100.0, coords[2] / 100.0, uiMapId)
                            UpdateIfNearest(nearest, player, { x = worldX, y = worldY, uiMapId = worldI }, { x = coords[1], y = coords[2], uiMapId = uiMapId }, npc.name, "NPC")
                        else
                            local dungeonLocation = QuestieZoneDB:GetDungeonLocation(zone)
                            if dungeonLocation ~= nil then
                                for _, value in ipairs(dungeonLocation) do
                                    if value[1] and value[2] then
                                        local worldX, worldY, worldI = HBD:GetWorldCoordinatesFromZone(value[1] / 100.0, value[2] / 100.0, QuestieZoneDB:GetUiMapIdByAreaId(value[3]))
                                        UpdateIfNearest(nearest, player, { x = worldX, y = worldY, uiMapId = worldI }, { x = value[1], y = value[2], uiMapId = uiMapId }, npc.name, "NPC")
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

    local playerX, playerY, playerI = HBD:GetPlayerWorldPosition()
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
            GetNearestObject(nearest, starters, { x = playerX, y = playerY, uiMapId = playerI })
        elseif starterType == "NPC" then
            GetNearestNPC(nearest, starters, { x = playerX, y = playerY, uiMapId = playerI })
        end
    end

    if nearest.x == -1 then
        Traveler:Debug("Could not find nearest quest starter for "..questId)
    end

    return nearest
end

function DataSourceQuestie:GetNearestQuestObjective(questId)
    local quest = QuestieDB:GetQuest(questId)
    if quest == nil then return nil end

    local bestDistance = 999999999
    local bestSpawn, bestSpawnZone, bestSpawnId, bestSpawnType, bestSpawnName
    if quest.Objectives then
        for _, objective in pairs(quest.Objectives) do
            local spawn, zone, name, id, type, dist = QuestieMap:GetNearestSpawn(objective)
            if spawn and dist < bestDistance and ((not objective.Needed) or objective.Needed ~= objective.Collected) then
                bestDistance = dist
                bestSpawn = spawn
                bestSpawnZone = zone
                bestSpawnId = id
                bestSpawnType = type
                bestSpawnName = name
            end
        end
    end

    if next(quest.SpecialObjectives) then
        for _, objective in pairs(quest.SpecialObjectives) do
            local spawn, zone, name, id, type, dist = QuestieMap:GetNearestSpawn(objective)
            if spawn and dist < bestDistance and ((not objective.Needed) or objective.Needed ~= objective.Collected) then
                bestDistance = dist
                bestSpawn = spawn
                bestSpawnZone = zone
                bestSpawnId = id
                bestSpawnType = type
                bestSpawnName = name
            end
        end
    end

    if bestSpawn then
        return {
            x = bestSpawn[1],
            y = bestSpawn[2],
            uiMapId = QuestieZoneDB:GetUiMapIdByAreaId(bestSpawnZone),
            name = bestSpawnName,
            type = bestSpawnType
        }
    end
end

function DataSourceQuestie:GetNearestQuestFinisher(questId)
    local quest = QuestieDB:GetQuest(questId)
    if quest == nil then return nil end

    local playerX, playerY, playerI = HBD:GetPlayerWorldPosition()
    local nearest = {
        distance = 999999,
        x = -1,
        y = -1,
        uiMapId = -1,
        name = "",
        type = ""
    }

    if quest.Finisher.Type == "object" then
        local finishers = {}
        finishers[#finishers + 1] = quest.Finisher.Id
        GetNearestObject(nearest, finishers, { x = playerX, y = playerY, uiMapId = playerI })
    elseif quest.Finisher.Type == "monster" then
        local finishers = {}
        finishers[#finishers + 1] = quest.Finisher.Id
        GetNearestNPC(nearest, finishers, { x = playerX, y = playerY, uiMapId = playerI })
    end

    if nearest.x == -1 then
        Traveler:Debug("Could not find nearest quest finisher for "..questId)
    end

    return nearest
end

Traveler.DataSource = DataSourceQuestie
