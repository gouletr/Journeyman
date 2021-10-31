local addonName, addon = ...
local Traveler = addon.Traveler
local L = addon.Locale
local DataSourceQuestie = {}
Traveler.DataSource = DataSourceQuestie

local HBD = LibStub("HereBeDragons-2.0")
local QuestieDB = QuestieLoader and QuestieLoader:ImportModule("QuestieDB")
local QuestiePlayer = QuestieLoader and QuestieLoader:ImportModule("QuestiePlayer")
local QuestieMap = QuestieLoader and QuestieLoader:ImportModule("QuestieMap")
local QuestieLib = QuestieLoader and QuestieLoader:ImportModule("QuestieLib")
local QuestieZoneDB = QuestieLoader and QuestieLoader:ImportModule("ZoneDB")

local function GetNearestSpawn(spawns, player)
    local bestDistance = 999999999
    local bestX, bestY, bestMapId

    for zone, spawn in pairs(spawns or {}) do
        if zone and spawn then
            for _, spawnCoords in ipairs(spawn) do
                local dungeonLocation = QuestieZoneDB:GetDungeonLocation(zone)
                if dungeonLocation then
                    for _, dungeonCoords in ipairs(dungeonLocation) do
                        local x, y = dungeonCoords[2], dungeonCoords[3]
                        local mapId = QuestieZoneDB:GetUiMapIdByAreaId(dungeonCoords[1])
                        local worldX, worldY = HBD:GetWorldCoordinatesFromZone(x / 100.0, y / 100.0, mapId)
                        local distance = HBD:GetWorldDistance(player.mapId, player.x, player.y, worldX, worldY)
                        if distance < bestDistance then
                            bestDistance = distance
                            bestX = x
                            bestY = y
                            bestMapId = mapId
                        end
                    end
                else
                    local x, y = spawnCoords[1], spawnCoords[2]
                    local mapId = QuestieZoneDB:GetUiMapIdByAreaId(zone)
                    local worldX, worldY = HBD:GetWorldCoordinatesFromZone(x / 100.0, y / 100.0, mapId)
                    local distance = HBD:GetWorldDistance(player.mapId, player.x, player.y, worldX, worldY)
                    if distance < bestDistance then
                        bestDistance = distance
                        bestX = x
                        bestY = y
                        bestMapId = mapId
                    end
                end
            end
        end
    end

    if bestX and bestY and bestMapId then
        return { distance = bestDistance, x = bestX, y = bestY, mapId = bestMapId }
    end
end

local function GetNearestObject(objects, player)
    local bestDistance = 999999999
    local bestX, bestY, bestMapId, bestName

    for _, objectId in ipairs(objects or {}) do
        local obj = QuestieDB:GetObject(objectId)
        if obj and obj.spawns then
            local nearest = GetNearestSpawn(obj.spawns, player)
            if nearest and (nearest.distance < bestDistance) then
                bestDistance = nearest.distance
                bestX = nearest.x
                bestY = nearest.y
                bestMapId = nearest.mapId
                bestName = obj.name
            end
        end
    end

    if bestX and bestY and bestMapId then
        return { distance = bestDistance, x = bestX, y = bestY, mapId = bestMapId, name = bestName, type = "Object" }
    end
end

local function GetNearestNPC(npcs, player)
    local bestDistance = 999999999
    local bestX, bestY, bestMapId, bestName

    for _, npcId in ipairs(npcs or {}) do
        local npc = QuestieDB:GetNPC(npcId)
        if npc and npc.spawns then
            local nearest = GetNearestSpawn(npc.spawns, player)
            if nearest and (nearest.distance < bestDistance) then
                bestDistance = nearest.distance
                bestX = nearest.x
                bestY = nearest.y
                bestMapId = nearest.mapId
                bestName = npc.name
            end
        end
    end

    if bestX and bestY and bestMapId then
        return { distance = bestDistance, x = bestX, y = bestY, mapId = bestMapId, name = bestName, type = "NPC" }
    end
end

local function GetNearestObjectiveSpawn(objective, player)
    local bestDistance = 999999999
    local bestX, bestY, bestMapId, bestName, bestType

    for spawnId, spawnData in pairs(objective.spawnList or {}) do
        local nearest = GetNearestSpawn(spawnData.Spawns, player)
        if nearest and (nearest.distance < bestDistance) then
            bestDistance = nearest.distance
            bestX = nearest.x
            bestY = nearest.y
            bestMapId = nearest.mapId
            bestName = spawnData.Name
            bestType = spawnData.Type
        end
    end

    if bestX and bestY and bestMapId then
        return { distance = bestDistance, x = bestX, y = bestY, mapId = bestMapId, name = bestName, type = bestType }
    end
end

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

function DataSourceQuestie:GetQuestHasRequiredRace(questId)
    local requiredRaces = QuestieDB.QueryQuestSingle(questId, "requiredRaces")
    return QuestiePlayer:HasRequiredRace(requiredRaces)
end

function DataSourceQuestie:GetQuestHasRequiredClass(questId)
    local requiredClasses = QuestieDB.QueryQuestSingle(questId, "requiredClasses")
    return QuestiePlayer:HasRequiredClass(requiredClasses)
end

function DataSourceQuestie:GetQuestExclusiveTo(questId)
    local quest = QuestieDB:GetQuest(questId)
    if quest ~= nil then return quest.exclusiveTo end
end

function DataSourceQuestie:GetNearestQuestStarter(questId)
    local quest = QuestieDB:GetQuest(questId)
    if quest == nil then return nil end

    local bestDistance = 999999999
    local bestX, bestY, bestMapId, bestName, bestType
    local playerX, playerY, playerMapId = HBD:GetPlayerWorldPosition()

    for starterType, starters in pairs(quest.Starts or {}) do
        if starterType == "GameObject" then
            local nearest = GetNearestObject(starters, { x = playerX, y = playerY, mapId = playerMapId })
            if nearest and (nearest.distance < bestDistance) then
                bestDistance = nearest.distance
                bestX = nearest.x
                bestY = nearest.y
                bestMapId = nearest.mapId
                bestName = nearest.name
                bestType = nearest.type
            end
        elseif starterType == "NPC" then
            local nearest = GetNearestNPC(starters, { x = playerX, y = playerY, mapId = playerMapId })
            if nearest and (nearest.distance < bestDistance) then
                bestDistance = nearest.distance
                bestX = nearest.x
                bestY = nearest.y
                bestMapId = nearest.mapId
                bestName = nearest.name
                bestType = nearest.type
            end
        end
    end

    if bestX and bestY and bestMapId then
        return { distance = bestDistance, x = bestX, y = bestY, mapId = bestMapId, name = bestName, type = bestType }
    end
end

function DataSourceQuestie:GetNearestQuestObjective(questId)
    local quest = QuestieDB:GetQuest(questId)
    if quest == nil then return nil end

    local bestDistance = 999999999
    local bestX, bestY, bestMapId, bestName, bestType
    local playerX, playerY, playerMapId = HBD:GetPlayerWorldPosition()

    for i, objective in ipairs(quest.Objectives or {}) do
        if not objective.Needed or objective.Needed ~= objective.Collected then
            local nearest = GetNearestObjectiveSpawn(objective, { x = playerX, y = playerY, mapId = playerMapId })
            if nearest and (nearest.distance < bestDistance) then
                bestDistance = nearest.distance
                bestX = nearest.x
                bestY = nearest.y
                bestMapId = nearest.mapId
                bestName = nearest.name
                bestType = nearest.type
            end
        end
    end

    for _, objective in ipairs(quest.SpecialObjectives or {}) do
        if not objective.Needed or objective.Needed ~= objective.Collected then
            local nearest = GetNearestObjectiveSpawn(objective, { x = playerX, y = playerY, mapId = playerMapId })
            if nearest and (nearest.distance < bestDistance) then
                bestDistance = nearest.distance
                bestX = nearest.x
                bestY = nearest.y
                bestMapId = nearest.mapId
                bestName = nearest.name
                bestType = nearest.type
            end
        end
    end

    if bestX and bestY and bestMapId then
        return { distance = bestDistance, x = bestX, y = bestY, mapId = bestMapId, name = bestName, type = bestType }
    end
end

function DataSourceQuestie:GetNearestQuestFinisher(questId)
    local quest = QuestieDB:GetQuest(questId)
    if quest == nil then return nil end

    if quest.Finisher then
        local playerX, playerY, playerMapId = HBD:GetPlayerWorldPosition()
        if quest.Finisher.Type == "object" then
            return GetNearestObject({ quest.Finisher.Id }, { x = playerX, y = playerY, mapId = playerMapId })
        elseif quest.Finisher.Type == "monster" then
            return GetNearestNPC({ quest.Finisher.Id }, { x = playerX, y = playerY, mapId = playerMapId })
        end
    end
end

function DataSourceQuestie:GetNearestFlightMaster()
end

function DataSourceQuestie:GetInnkeeperLocation(location)
end
