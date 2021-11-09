local addonName, addon = ...
local Traveler = addon.Traveler
local L = addon.Locale
local DataSourceQuestie = {}
Traveler.DataSource = DataSourceQuestie

local HBD = LibStub("HereBeDragons-2.0")
local QuestieDB = QuestieLoader and QuestieLoader:ImportModule("QuestieDB")
local QuestiePlayer = QuestieLoader and QuestieLoader:ImportModule("QuestiePlayer")
--local QuestieMap = QuestieLoader and QuestieLoader:ImportModule("QuestieMap")
local QuestieLib = QuestieLoader and QuestieLoader:ImportModule("QuestieLib")
local QuestieZoneDB = QuestieLoader and QuestieLoader:ImportModule("ZoneDB")
--local QuestieL10n = QuestieLoader and QuestieLoader:ImportModule("l10n")

local tinsert = table.insert

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

local function GetNearestNPC(npcs, player)
    local bestDistance = 999999999
    local bestX, bestY, bestMapId, bestName

    for i = 1, #npcs do
        local npc = QuestieDB:GetNPC(npcs[i])
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

local function GetNearestObject(objects, player)
    local bestDistance = 999999999
    local bestX, bestY, bestMapId, bestName

    for i = 1, #objects do
        local obj = QuestieDB:GetObject(objects[i])
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

local function GetNearestItem(items, player)
    local bestDistance = 999999999
    local bestX, bestY, bestMapId, bestName, bestType

    for i = 1, #items do
        local item = QuestieDB:GetItem(items[i])
        if item then
            if item.spawns then
                local nearest = GetNearestSpawn(item.spawns, player)
                if nearest and (nearest.distance < bestDistance) then
                    bestDistance = nearest.distance
                    bestX = nearest.x
                    bestY = nearest.y
                    bestMapId = nearest.mapId
                    bestName = nearest.name
                    bestType = "Item"
                end
            end
            if item.npcDrops then
                local nearest = GetNearestNPC(item.npcDrops, player)
                if nearest and (nearest.distance < bestDistance) then
                    bestDistance = nearest.distance
                    bestX = nearest.x
                    bestY = nearest.y
                    bestMapId = nearest.mapId
                    bestName = nearest.name
                    bestType = "NPC Drop"
                end
            end
            if item.objectDrops then
                local nearest = GetNearestObject(item.objectDrops, player)
                if nearest and (nearest.distance < bestDistance) then
                    bestDistance = nearest.distance
                    bestX = nearest.x
                    bestY = nearest.y
                    bestMapId = nearest.mapId
                    bestName = nearest.name
                    bestType = "Object Drop"
                end
            end
        end
    end

    if bestX and bestY and bestMapId then
        return { distance = bestDistance, x = bestX, y = bestY, mapId = bestMapId, name = bestName, type = bestType }
    end
end

local function GetNearestQuestLocation(entities)
    local bestDistance = 999999999
    local bestX, bestY, bestMapId, bestName, bestType
    local playerX, playerY, playerMapId = HBD:GetPlayerWorldPosition()
    local player = { x = playerX, y = playerY, mapId = playerMapId }

    for i = 1, #entities do
        local entity = entities[i]
        local nearest
        if entity.NPC then
            nearest = GetNearestNPC(entity.NPC, player)
        elseif entity.GameObject then
            nearest = GetNearestObject(entity.GameObject, player)
        elseif entity.Item then
            nearest = GetNearestItem(entity.Item, player)
        elseif entity.Type == "monster" then
            nearest = GetNearestNPC({ entity.Id }, player)
        elseif entity.Type == "object" then
            nearest = GetNearestObject({ entity.Id }, player)
        elseif entity.Type == "item" then
            nearest = GetNearestItem({ entity.Id }, player)
        elseif entity.Type == "event" and entity.Coordinates then
            nearest = GetNearestSpawn(entity.Coordinates, player)
            nearest.name = entity.Text
            nearest.type = "Event"
        end

        if nearest and (nearest.distance < bestDistance) then
            bestDistance = nearest.distance
            bestX = nearest.x
            bestY = nearest.y
            bestMapId = nearest.mapId
            bestName = nearest.name
            bestType = nearest.type
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
    if questId == nil or type(questId) ~= "number" then
        return nil
    end

    local name = QuestieDB.QueryQuestSingle(questId, "name");
    if name then
        local level, _ = QuestieLib:GetTbcLevel(questId)
        if showLevel then
            name = QuestieLib:GetQuestString(questId, name, level, true)
        end
        return name
    end
end

function DataSourceQuestie:GetQuestLevel(questId)
    return QuestieLib:GetTbcLevel(questId)
end

local function GetQuestObjectivesNPC(objectives, npcs, questLogObjective)
    for i = 1, #npcs do
        local npc = QuestieDB:GetNPC(npcs[i])
        if npc then
            tinsert(objectives, { name = npc.name, type = "NPC", isComplete = questLogObjective.finished == true })
        end
    end
end

local function GetQuestObjectivesObject(objectives, objects, questLogObjective)
    for i = 1, #objects do
        local obj = QuestieDB:GetObject(objects[i])
        if obj then
            tinsert(objectives, { name = obj.name, type = "Object", isComplete = questLogObjective.finished == true })
        end
    end
end

local function GetQuestObjectivesItem(objectives, items, questLogObjective)
    for i = 1, #items do
        local item = QuestieDB:GetItem(items[i])
        if item then
            tinsert(objectives, { name = item.name, type = "Item", isComplete = questLogObjective.finished == true })
            if item.npcDrops then
                GetQuestObjectivesNPC(objectives, item.npcDrops, questLogObjective)
            end
            if item.objectDrops then
                GetQuestObjectivesObject(objectives, item.objectDrops, questLogObjective)
            end
        end
    end
end

function DataSourceQuestie:GetQuestObjectives(questId)
    local quest = QuestieDB:GetQuest(questId)
    local questLogObjectives = C_QuestLog.GetQuestObjectives(questId)
    if quest and quest.ObjectiveData and questLogObjectives then
        local objectives = {}
        for i = 1, #quest.ObjectiveData do
            local objective = quest.ObjectiveData[i]
            local questLogObjective = questLogObjectives[i]
            if objective.NPC then
                GetQuestObjectivesNPC(objectives, objective.NPC, questLogObjective)
            elseif objective.GameObject then
                GetQuestObjectivesObject(objectives, objective.GameObject, questLogObjective)
            elseif objective.Item then
                GetQuestObjectivesItem(objectives, objective.Item, questLogObjective)
            elseif objective.Type == "monster" then
                GetQuestObjectivesNPC(objectives, { objective.Id }, questLogObjective)
            elseif objective.Type == "object" then
                GetQuestObjectivesObject(objectives, { objective.Id }, questLogObjective)
            elseif objective.Type == "item" then
                GetQuestObjectivesItem(objectives, { objective.Id }, questLogObjective)
            elseif objective.Type == "event" then
                tinsert(objectives, { name = objective.Text, type = "Event", isComplete = questLogObjective.finished == true })
            end
        end
        return objectives
    end
end

function DataSourceQuestie:GetQuestHasRequiredRace(questId)
    local requiredRaces = QuestieDB.QueryQuestSingle(questId, "requiredRaces")
    if requiredRaces then
        return QuestiePlayer:HasRequiredRace(requiredRaces)
    end
    return false
end

function DataSourceQuestie:GetQuestHasRequiredClass(questId)
    local requiredClasses = QuestieDB.QueryQuestSingle(questId, "requiredClasses")
    if requiredClasses then
        return QuestiePlayer:HasRequiredClass(requiredClasses)
    end
    return false
end

function DataSourceQuestie:GetQuestExclusiveTo(questId)
    local quest = QuestieDB:GetQuest(questId)
    if quest ~= nil then return quest.exclusiveTo end
end

function DataSourceQuestie:GetNearestQuestStarter(questId)
    local quest = QuestieDB:GetQuest(questId)
    if quest and quest.Starts then
        return GetNearestQuestLocation({ quest.Starts })
    end
end

function DataSourceQuestie:GetNearestQuestObjective(questId)
    local quest = QuestieDB:GetQuest(questId)
    if quest and quest.ObjectiveData then
        return GetNearestQuestLocation(quest.ObjectiveData)
    end
end

function DataSourceQuestie:GetNearestQuestFinisher(questId)
    local quest = QuestieDB:GetQuest(questId)
    if quest and quest.Finisher then
        return GetNearestQuestLocation({ quest.Finisher })
    end
end

function DataSourceQuestie:GetNearestFlightMaster()
end

function DataSourceQuestie:GetQuestChainStartQuest(questId)
    if self.questChainStartQuest == nil then
        self.questChainStartQuest = {}
    elseif self.questChainStartQuest[questId] ~= nil then
        return self.questChainStartQuest[questId]
    end

    local quest = QuestieDB:GetQuest(questId)
    if quest then
        local chainStartQuestId
        local preQuestSingle = QuestieDB.QueryQuestSingle(questId, "preQuestSingle")
        if preQuestSingle then
            for _, preQuestId in pairs(preQuestSingle) do
                -- preQuestSingle is a table, but assuming there will always be a single element, might be wrong
                chainStartQuestId = self:GetQuestChainStartQuest(preQuestId)
                break
            end
        end

        if chainStartQuestId then
            self.questChainStartQuest[questId] = chainStartQuestId
            return chainStartQuestId
        else
            self.questChainStartQuest[questId] = questId
            return questId
        end
    end
end

function DataSourceQuestie:IsQuestNPCDrop(questId)
    if self.isQuestNPCDrop == nil then
        self.isQuestNPCDrop = {}
    elseif self.isQuestNPCDrop[questId] then
        return self.isQuestNPCDrop[questId]
    end

    local quest = QuestieDB:GetQuest(questId)
    if quest then
        local starterLocation = self:GetNearestQuestStarter(questId)
        if starterLocation then
            local isNPCDrop = starterLocation.type == "NPC Drop"
            self.isQuestNPCDrop[questId] = isNPCDrop
            return isNPCDrop
        end
    end
    return false
end

-- local function GetZoneIDByName(name)
    -- for _, zones in pairs(QuestieL10n.zoneLookup) do
        -- for zoneIDnum, zoneName in pairs(zones) do
            -- if zoneName == name then
                -- return zoneIDnum
            -- end
        -- end
    -- end
-- end

function DataSourceQuestie:GetInnkeeperLocation(location)
    -- Traveler:Debug("GetInnkeeperLocation %s", location)

    -- local key = "Innkeeper"
    -- local npcs = Questie.db.global.townsfolk[key] or Questie.db.char.townsfolk[key]
    -- if npcs == nil then return nil end

    -- local zoneId = GetZoneIDByName(location)
    -- local mapId = QuestieZoneDB:GetUiMapIdByAreaId(zoneId)
    -- if mapId == nil then
        -- mapId = QuestieZoneDB:GetParentZoneId(zoneId)
    -- end
    -- -- Traveler:Debug("zone '%s' is = %s (%s)", location, dump(zoneId), dump(mapId))

    -- for _, npcId in ipairs(npcs) do
        -- local npc = QuestieDB:GetNPC(npcId)
        -- if npc then
            -- for zone, spawns in pairs(npc.spawns) do
                -- Traveler:Debug("npc %d zone=%s", npcId, dump(zone))
            -- end
        -- end
    -- end
end
