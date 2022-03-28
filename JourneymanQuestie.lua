local addonName, addon = ...
local Journeyman = addon.Journeyman
local L = addon.Locale
local DataSourceQuestie = {}
Journeyman.DataSource = DataSourceQuestie

local HBD = LibStub("HereBeDragons-2.0")
local QuestieDB = QuestieLoader and QuestieLoader:ImportModule("QuestieDB")
local QuestiePlayer = QuestieLoader and QuestieLoader:ImportModule("QuestiePlayer")
--local QuestieMap = QuestieLoader and QuestieLoader:ImportModule("QuestieMap")
local QuestieLib = QuestieLoader and QuestieLoader:ImportModule("QuestieLib")
local QuestieZoneDB = QuestieLoader and QuestieLoader:ImportModule("ZoneDB")
--local QuestieL10n = QuestieLoader and QuestieLoader:ImportModule("l10n")
local QuestieLink = QuestieLoader and QuestieLoader:ImportModule("QuestieLink")

local tinsert = table.insert

local function GetNearestSpawn(spawns, player, zoneFilter)
    local bestDistance = 999999999
    local bestX, bestY, bestMapId

    for zone, spawn in pairs(spawns) do
        if zone and spawn then
            if zoneFilter == nil or (zoneFilter and zoneFilter == zone) then
                for _, spawnCoords in ipairs(spawn) do
                    local dungeonLocation = QuestieZoneDB:GetDungeonLocation(zone)
                    if dungeonLocation then
                        for _, dungeonCoords in ipairs(dungeonLocation) do
                            local x, y = dungeonCoords[2], dungeonCoords[3]
                            local mapId = QuestieZoneDB:GetUiMapIdByAreaId(dungeonCoords[1])
                            local worldX, worldY = HBD:GetWorldCoordinatesFromZone(x / 100.0, y / 100.0, mapId)
                            local distance = HBD:GetWorldDistance(player.mapId, player.x, player.y, worldX, worldY)
                            if distance and distance < bestDistance then
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
                        if distance and distance < bestDistance then
                            bestDistance = distance
                            bestX = x
                            bestY = y
                            bestMapId = mapId
                        end
                    end
                end
            end
        end
    end

    if bestX and bestY and bestMapId then
        return { distance = bestDistance, x = bestX, y = bestY, mapId = bestMapId }
    end
end

local function GetNearestNPC(npcs, player, zoneFilter)
    local bestDistance = 999999999
    local bestX, bestY, bestMapId, bestName, bestId

    for i = 1, #npcs do
        local npcId = npcs[i]
        if npcId then
            local npc = QuestieDB:GetNPC(npcId)
            if npc and npc.spawns then
                local nearest = GetNearestSpawn(npc.spawns, player, zoneFilter)
                if nearest and nearest.distance < bestDistance then
                    bestDistance = nearest.distance
                    bestX = nearest.x
                    bestY = nearest.y
                    bestMapId = nearest.mapId
                    bestName = npc.name
                    bestId = npcId
                end
            end
        end
    end

    if bestX and bestY and bestMapId then
        return { distance = bestDistance, x = bestX, y = bestY, mapId = bestMapId, name = bestName, id = bestId, type = "NPC" }
    end
end

local function GetNearestObject(objects, player, zoneFilter)
    local bestDistance = 999999999
    local bestX, bestY, bestMapId, bestName, bestId

    for i = 1, #objects do
        local objectId = objects[i]
        if objectId then
            local obj = QuestieDB:GetObject(objectId)
            if obj and obj.spawns then
                local nearest = GetNearestSpawn(obj.spawns, player, zoneFilter)
                if nearest and nearest.distance < bestDistance then
                    bestDistance = nearest.distance
                    bestX = nearest.x
                    bestY = nearest.y
                    bestMapId = nearest.mapId
                    bestName = obj.name
                    bestId = objectId
                end
            end
        end
    end

    if bestX and bestY and bestMapId then
        return { distance = bestDistance, x = bestX, y = bestY, mapId = bestMapId, name = bestName, id = bestId, type = "Object" }
    end
end

local function GetNearestItem(items, player, zoneFilter)
    local bestDistance = 999999999
    local bestX, bestY, bestMapId, bestName, bestId, bestType

    for i = 1, #items do
        local itemId = items[i]
        if itemId then
            local item = QuestieDB:GetItem(itemId)
            if item then
                if item.spawns then
                    local nearest = GetNearestSpawn(item.spawns, player, zoneFilter)
                    if nearest and nearest.distance < bestDistance then
                        bestDistance = nearest.distance
                        bestX = nearest.x
                        bestY = nearest.y
                        bestMapId = nearest.mapId
                        bestName = item.name
                        bestId = itemId
                        bestType = "Item"
                    end
                end
                if item.npcDrops then
                    local nearest = GetNearestNPC(item.npcDrops, player, zoneFilter)
                    if nearest and nearest.distance < bestDistance then
                        bestDistance = nearest.distance
                        bestX = nearest.x
                        bestY = nearest.y
                        bestMapId = nearest.mapId
                        bestName = nearest.name
                        bestId = nearest.id
                        bestType = "NPC Drop"
                    end
                end
                if item.objectDrops then
                    local nearest = GetNearestObject(item.objectDrops, player, zoneFilter)
                    if nearest and nearest.distance < bestDistance then
                        bestDistance = nearest.distance
                        bestX = nearest.x
                        bestY = nearest.y
                        bestMapId = nearest.mapId
                        bestName = nearest.name
                        bestId = nearest.id
                        bestType = "Object Drop"
                    end
                end
            end
        end
    end

    if bestX and bestY and bestMapId then
        return { distance = bestDistance, x = bestX, y = bestY, mapId = bestMapId, name = bestName, id = bestId, type = bestType }
    end
end

local function GetNearestQuestLocation(entity, player, zoneFilter)
    local nearest
    if entity.NPC then
        nearest = GetNearestNPC(entity.NPC, player, zoneFilter)
    elseif entity.GameObject then
        nearest = GetNearestObject(entity.GameObject, player, zoneFilter)
    elseif entity.Item then
        nearest = GetNearestItem(entity.Item, player, zoneFilter)
    elseif entity.Type == "monster" then
        nearest = GetNearestNPC({ entity.Id }, player, zoneFilter)
    elseif entity.Type == "object" then
        nearest = GetNearestObject({ entity.Id }, player, zoneFilter)
    elseif entity.Type == "item" then
        nearest = GetNearestItem({ entity.Id }, player, zoneFilter)
    elseif entity.Type == "event" and entity.Coordinates then
        nearest = GetNearestSpawn(entity.Coordinates, player, zoneFilter)
        nearest.name = entity.Text
        nearest.type = "Event"
    end
    return nearest
end

function DataSourceQuestie:IsInitialized()
    if self.initialized then
        return true
    end

    local initialized =
        QuestieDB ~= nil and
        QuestieDB.QueryNPC ~= nil and type(QuestieDB.QueryNPC) == "function" and
        QuestieDB.QueryQuest ~= nil and type(QuestieDB.QueryQuest) == "function" and
        QuestieDB.QueryObject ~= nil and type(QuestieDB.QueryObject) == "function" and
        QuestieDB.QueryItem ~= nil and type(QuestieDB.QueryItem) == "function" and
        QuestieDB.QueryNPCSingle ~= nil and type(QuestieDB.QueryNPCSingle) == "function" and
        QuestieDB.QueryQuestSingle ~= nil and type(QuestieDB.QueryQuestSingle) == "function" and
        QuestieDB.QueryObjectSingle ~= nil and type(QuestieDB.QueryObjectSingle) == "function" and
        QuestieDB.QueryItemSingle ~= nil and type(QuestieDB.QueryItemSingle) == "function"

    if initialized then
        self.initialized = true
        return true
    end

    return false
end

function DataSourceQuestie:IsQuestAvailable(questId)
    if questId == nil or type(questId) ~= "number" then return false end
    return QuestieDB:GetQuest(questId) ~= nil
end

function DataSourceQuestie:GetQuestName(questId, showLevel, showId)
    if questId == nil or type(questId) ~= "number" then return nil end
    local name = QuestieDB.QueryQuestSingle(questId, "name");
    if name then
        local level, _ = QuestieLib:GetTbcLevel(questId)
        if showLevel then
            name = QuestieLib:GetQuestString(questId, name, level, true)
        end
        if showId then
            name = name.." ("..questId..")"
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
        return QuestiePlayer:HasRequiredRace(requiredRaces) == true
    end
    return false
end

function DataSourceQuestie:GetQuestHasRequiredClass(questId)
    local requiredClasses = QuestieDB.QueryQuestSingle(questId, "requiredClasses")
    if requiredClasses then
        return QuestiePlayer:HasRequiredClass(requiredClasses) == true
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
        local playerX, playerY, playerMapId = HBD:GetPlayerWorldPosition()
        return GetNearestQuestLocation(quest.Starts, { x = playerX, y = playerY, mapId = playerMapId })
    end
end

function DataSourceQuestie:GetNearestQuestObjective(questId, objectiveIndex)
    local quest = QuestieDB:GetQuest(questId)
    if quest == nil or quest.ObjectiveData == nil then return nil end

    local objectives = C_QuestLog.GetQuestObjectives(questId)
    if objectives == nil then return nil end

    if #objectives ~= #quest.ObjectiveData then
        Journeyman:Error("Quest objectives count does not match (%d ~= %d)", #objectives, #quest.ObjectiveData)
        return nil
    end

    local bestDistance = 999999999
    local bestX, bestY, bestMapId, bestName, bestId, bestType
    local playerX, playerY, playerMapId = HBD:GetPlayerWorldPosition()
    local player = { x = playerX, y = playerY, mapId = playerMapId }

    for i = 1, #objectives do
        if objectives[i].finished == false and (objectiveIndex == nil or objectiveIndex == i) then
            local nearest = GetNearestQuestLocation(quest.ObjectiveData[i], player)
            if nearest and nearest.distance < bestDistance then
                bestDistance = nearest.distance
                bestX = nearest.x
                bestY = nearest.y
                bestMapId = nearest.mapId
                bestName = nearest.name
                bestId = nearest.id
                bestType = nearest.type
            end
        end
    end

    if bestX and bestY and bestMapId then
        return { distance = bestDistance, x = bestX, y = bestY, mapId = bestMapId, name = bestName, id = bestId, type = bestType }
    end
end

function DataSourceQuestie:GetNearestQuestFinisher(questId)
    local quest = QuestieDB:GetQuest(questId)
    if quest and quest.Finisher then
        local playerX, playerY, playerMapId = HBD:GetPlayerWorldPosition()
        return GetNearestQuestLocation(quest.Finisher, { x = playerX, y = playerY, mapId = playerMapId })
    end
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

function DataSourceQuestie:IsQuestRepeatable(questId)
    return QuestieDB:IsRepeatable(questId)
end

function DataSourceQuestie:GetAllInnkeeperZones()
    local npcs = Questie.db.global.townsfolk["Innkeeper"] or Questie.db.char.townsfolk["Innkeeper"]
    if npcs == nil then return nil end

    local zones = {}
    for i = 1, #npcs do
        local npcId = npcs[i]
        if npcId then
            local npc = QuestieDB:GetNPC(npcId)
            if npc and npc.spawns then
                for zone, _ in pairs(npc.spawns) do
                    if zone then
                        zones[zone] = true
                    end
                end
            end
        end
    end
    return zones
end

function DataSourceQuestie:GetNearestInnkeeperLocation(areaId)
    local npcs = Questie.db.global.townsfolk["Innkeeper"] or Questie.db.char.townsfolk["Innkeeper"]
    if npcs == nil then return nil end

    local playerX, playerY, playerMapId = HBD:GetPlayerWorldPosition()
    local parentAreaId = Journeyman:GetAreaParentId(areaId)
    if parentAreaId then
        return GetNearestNPC(npcs, { x = playerX, y = playerY, mapId = playerMapId }, parentAreaId)
    end
end

function DataSourceQuestie:GetTaxiNodeNPCId(taxiNodeId)
    if self.taxiNodeIdToNPCId == nil then
        self.taxiNodeIdToNPCId = {}
    end
    if self.npcIdToTaxiNodeId == nil then
        self.npcIdToTaxiNodeId = {}
    end

    if self.taxiNodeIdToNPCId[taxiNodeId] == nil then
        local bestDistance = 999999999
        local bestNPCId

        if Journeyman:IsTaxiNodeAvailable(taxiNodeId) then
            local npcs = Questie.db.global.townsfolk["Flight Master"] or Questie.db.char.townsfolk["Flight Master"]
            local taxiNodeWorldCoords = Journeyman:GetTaxiNodeWorldCoordinates(taxiNodeId)

            if npcs and taxiNodeWorldCoords then
                for i = 1, #npcs do
                    local npcId = npcs[i]
                    if npcId then
                        local npc = QuestieDB:GetNPC(npcId)
                        if npc and npc.spawns then
                            for zone, spawn in pairs(npc.spawns) do
                                for _, coords in ipairs(spawn) do
                                    local x, y = coords[1], coords[2]
                                    local mapId = QuestieZoneDB:GetUiMapIdByAreaId(zone)
                                    local worldX, worldY, worldI = HBD:GetWorldCoordinatesFromZone(x / 100.0, y / 100.0, mapId)
                                    local distance = HBD:GetWorldDistance(worldI, worldX, worldY, taxiNodeWorldCoords[1], taxiNodeWorldCoords[2])
                                    if distance and distance <= 15 and distance < bestDistance then
                                        bestDistance = distance
                                        bestNPCId = npcId
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end

        if bestNPCId then
            self.taxiNodeIdToNPCId[taxiNodeId] = bestNPCId
            self.npcIdToTaxiNodeId[bestNPCId] = taxiNodeId
        else
            self.taxiNodeIdToNPCId[taxiNodeId] = -1
        end
    end

    local npcId = self.taxiNodeIdToNPCId[taxiNodeId]
    if npcId and npcId > 0 then
        return npcId
    end
end

function DataSourceQuestie:GetFlightMasterLocation(taxiNodeId)
    if taxiNodeId then
        local npcId = self:GetTaxiNodeNPCId(taxiNodeId)
        if npcId then
            local playerX, playerY, playerMapId = HBD:GetPlayerWorldPosition()
            return GetNearestNPC({ npcId }, { x = playerX, y = playerY, mapId = playerMapId })
        end
    end
end

function DataSourceQuestie:GetNPCTaxiNodeId(npcId)
    if self.npcIdToTaxiNodeId == nil then
        self.npcIdToTaxiNodeId = {}
    end

    if self.npcIdToTaxiNodeId[npcId] == nil then
        for taxiNodeId, _ in pairs(L.taxiNodes) do
            if Journeyman:IsTaxiNodeAvailable(taxiNodeId) then
                if self:GetTaxiNodeNPCId(taxiNodeId) == npcId then
                    return taxiNodeId
                end
            end
        end
        self.npcIdToTaxiNodeId[npcId] = -1
    end

    local taxiNodeId = self.npcIdToTaxiNodeId[npcId]
    if taxiNodeId and taxiNodeId > 0 then
        return taxiNodeId
    end
end

function DataSourceQuestie:GetNearestFlightMasterLocation()
    local npcs = Questie.db.global.townsfolk["Flight Master"] or Questie.db.char.townsfolk["Flight Master"]
    if npcs then
        local playerX, playerY, playerMapId = HBD:GetPlayerWorldPosition()
        return GetNearestNPC(npcs, { x = playerX, y = playerY, mapId = playerMapId })
    end
end

function DataSourceQuestie:ShowQuestTooltip(questId)
    local questLink = QuestieLink:GetQuestHyperLink(questId)
    ShowUIPanel(ItemRefTooltip)
    ItemRefTooltip:SetOwner(UIParent, "ANCHOR_PRESERVE");
    ItemRefTooltip:SetHyperlink(questLink)
    ItemRefTooltip:Show()
end
