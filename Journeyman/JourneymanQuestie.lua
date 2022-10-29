local addonName, addon = ...
local Journeyman = addon.Journeyman
local L = addon.Locale

local DataSourceQuestie = {}
Journeyman.DataSource = DataSourceQuestie

local TaxiNodes = Journeyman.TaxiNodes
local List = LibStub("LibCollections-1.0").List
local Dictionary = LibStub("LibCollections-1.0").Dictionary
local HBD = LibStub("HereBeDragons-2.0")
local QuestieDB = QuestieLoader and QuestieLoader:ImportModule("QuestieDB")
local QuestiePlayer = QuestieLoader and QuestieLoader:ImportModule("QuestiePlayer")
local QuestieLib = QuestieLoader and QuestieLoader:ImportModule("QuestieLib")
local QuestieZoneDB = QuestieLoader and QuestieLoader:ImportModule("ZoneDB")
local QuestieLink = QuestieLoader and QuestieLoader:ImportModule("QuestieLink")
local QuestieReputation = QuestieLoader and QuestieLoader:ImportModule("QuestieReputation")
local QuestieProfessions = QuestieLoader and QuestieLoader:ImportModule("QuestieProfessions")

local tinsert = table.insert

local function GetPlayerInfo(withFaction)
    local location = Journeyman.player.location
    if location then
        local info = { instanceId = location.instanceId, worldX = location.worldX, worldY = location.worldY, mapId = location.mapId, x = location.x, y = location.y }
        if withFaction then
            info.factionName = Journeyman.player.factionName
        end
        return info
    end
end

local function GetNearestSpawn(spawns, player, zoneFilter)
    local bestDistance = 999999999
    local bestX, bestY, bestMapId

    for zone, spawn in pairs(spawns) do
        if zone and spawn then
            if zoneFilter == nil or zoneFilter == zone then
                for _, spawnCoords in ipairs(spawn) do
                    local dungeonLocation = QuestieZoneDB:GetDungeonLocation(zone)
                    if dungeonLocation then
                        for _, dungeonCoords in ipairs(dungeonLocation) do
                            local mapId = QuestieZoneDB:GetUiMapIdByAreaId(dungeonCoords[1])
                            local x, y = dungeonCoords[2], dungeonCoords[3]
                            local worldX, worldY, instanceId = HBD:GetWorldCoordinatesFromZone(x / 100.0, y / 100.0, mapId)
                            if player.instanceId == instanceId then
                                local distance = HBD:GetWorldDistance(player.instanceId, player.worldX, player.worldY, worldX, worldY)
                                if distance and distance < bestDistance then
                                    bestDistance = distance
                                    bestX = x
                                    bestY = y
                                    bestMapId = mapId
                                end
                            end
                        end
                    else
                        local mapId = QuestieZoneDB:GetUiMapIdByAreaId(zone)
                        local x, y = spawnCoords[1], spawnCoords[2]
                        local worldX, worldY, instanceId = HBD:GetWorldCoordinatesFromZone(x / 100.0, y / 100.0, mapId)
                        if player.instanceId == instanceId then
                            local distance = HBD:GetWorldDistance(player.instanceId, player.worldX, player.worldY, worldX, worldY)
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
    end

    if bestX and bestY and bestMapId then
        return { distance = bestDistance, x = bestX, y = bestY, mapId = bestMapId }
    end
end

local function GetNearestNPC(npcs, player, zoneFilter)
    local bestDistance = 999999999
    local bestX, bestY, bestMapId, bestName, bestId

    List:ForEach(npcs, function(npcId)
        local npc = QuestieDB:GetNPC(npcId)
        if npc and npc.spawns and (not player.factionName or npc.friendly) then
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
    end)

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
                if item.vendors then
                    local nearest = GetNearestNPC(item.vendors, player, zoneFilter)
                    if nearest and nearest.distance < bestDistance then
                        bestDistance = nearest.distance
                        bestX = nearest.x
                        bestY = nearest.y
                        bestMapId = nearest.mapId
                        bestName = nearest.name
                        bestId = nearest.id
                        bestType = "Vendor"
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
                        bestType = "NPC"
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
                        bestType = "Object"
                    end
                end
                if item.itemDrops then
                    local nearest = GetNearestItem(item.itemDrops, player, zoneFilter)
                    if nearest and nearest.distance < bestDistance then
                        bestDistance = nearest.distance
                        bestX = nearest.x
                        bestY = nearest.y
                        bestMapId = nearest.mapId
                        bestName = nearest.name
                        bestId = nearest.id
                        bestType = "Item"
                    end
                end
            end
        end
    end

    if bestX and bestY and bestMapId then
        return { distance = bestDistance, x = bestX, y = bestY, mapId = bestMapId, name = bestName, id = bestId, type = bestType }
    end
end

local function GetNearestEntityLocation(entity, player, zoneFilter)
    local bestDistance = 999999999
    local bestX, bestY, bestMapId, bestName, bestId, bestType

    if not player then
        return nil
    end

    if entity.NPC then
        local nearest = GetNearestNPC(entity.NPC, player, zoneFilter)
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

    if entity.GameObject then
        local nearest = GetNearestObject(entity.GameObject, player, zoneFilter)
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

    if entity.Item then
        local nearest = GetNearestItem(entity.Item, player, zoneFilter)
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

    if entity.Type == "monster" then
        local nearest = GetNearestNPC({ entity.Id }, player, zoneFilter)
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

    if entity.Type == "object" then
        local nearest = GetNearestObject({ entity.Id }, player, zoneFilter)
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

    if entity.Type == "item" then
        local nearest = GetNearestItem({ entity.Id }, player, zoneFilter)
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

    if entity.Type == "event" and entity.Coordinates then
        nearest = GetNearestSpawn(entity.Coordinates, player, zoneFilter)
        if nearest and nearest.distance < bestDistance then
            bestDistance = nearest.distance
            bestX = nearest.x
            bestY = nearest.y
            bestMapId = nearest.mapId
            bestName = entity.Text
            bestType = "Event"
        end
    end

    if bestX and bestY and bestMapId then
        return { distance = bestDistance, x = bestX, y = bestY, mapId = bestMapId, name = bestName, id = bestId, type = bestType }
    end
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
        QuestieDB.QueryItemSingle ~= nil and type(QuestieDB.QueryItemSingle) == "function" and
        Questie.started == true

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
        local level, _ = QuestieLib.GetTbcLevel(questId)
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
    return QuestieLib.GetTbcLevel(questId)
end

local function GetQuestObjectivesNPC(result, npcs, type, isComplete, objectiveIndex)
    for i = 1, #npcs do
        local npcId = npcs[i]
        if npcId then
            local npc = QuestieDB:GetNPC(npcId)
            if npc then
                tinsert(result, { name = npc.name, id = npcId, type = type, isComplete = isComplete, objectiveIndex = objectiveIndex })
            end
        end
    end
end

local function GetQuestObjectivesObject(result, objects, type, isComplete, objectiveIndex)
    for i = 1, #objects do
        local objectId = objects[i]
        if objectId then
            local obj = QuestieDB:GetObject(objectId)
            if obj then
                tinsert(result, { name = obj.name, id = objectId, type = type, isComplete = isComplete, objectiveIndex = objectiveIndex })
            end
        end
    end
end

local function GetQuestObjectivesItem(result, items, type, isComplete, objectiveIndex)
    for i = 1, #items do
        local itemId = items[i]
        if itemId then
            local item = QuestieDB:GetItem(itemId)
            if item then
                local objective = { name = item.name, id = itemId, type = type, class = item.class, subClass = item.subClass, isComplete = isComplete, objectiveIndex = objectiveIndex }
                local sources = {}
                if item.vendors then
                    GetQuestObjectivesNPC(sources, item.vendors, "Vendor", isComplete, objectiveIndex)
                end
                if item.npcDrops then
                    GetQuestObjectivesNPC(sources, item.npcDrops, "NPC", isComplete, objectiveIndex)
                end
                if item.objectDrops then
                    GetQuestObjectivesObject(sources, item.objectDrops, "Object", isComplete, objectiveIndex)
                end
                if item.itemDrops then
                    GetQuestObjectivesItem(sources, item.itemDrops, "Item", isComplete, objectiveIndex)
                end
                objective.sources = sources
                tinsert(result, objective)
            end
        end
    end
end

function DataSourceQuestie:GetQuestObjectives(questId, objectives)
    local quest = QuestieDB:GetQuest(questId)
    local questLogObjectives = Journeyman.State:GetQuestObjectives(questId)
    if quest and quest.ObjectiveData and questLogObjectives then
        local result = {}
        if objectives then
            for _, objectiveIndex in ipairs(objectives) do
                local objective = quest.ObjectiveData[objectiveIndex]
                if objective then
                    local isComplete = questLogObjectives[objectiveIndex].finished == true
                    if objective.NPC then
                        GetQuestObjectivesNPC(result, objective.NPC, "NPC", isComplete, objectiveIndex)
                    elseif objective.GameObject then
                        GetQuestObjectivesObject(result, objective.GameObject, "Object", isComplete, objectiveIndex)
                    elseif objective.Item then
                        GetQuestObjectivesItem(result, objective.Item, "Item", isComplete, objectiveIndex)
                    elseif objective.Type == "monster" then
                        GetQuestObjectivesNPC(result, { objective.Id }, "NPC", isComplete, objectiveIndex)
                    elseif objective.Type == "object" then
                        GetQuestObjectivesObject(result, { objective.Id }, "Object", isComplete, objectiveIndex)
                    elseif objective.Type == "item" then
                        GetQuestObjectivesItem(result, { objective.Id }, "Item", isComplete, objectiveIndex)
                    elseif objective.Type == "event" then
                        tinsert(result, { name = objective.Text, type = "Event", isComplete = isComplete, objectiveIndex = objectiveIndex })
                    end
                end
            end
        else
            for objectiveIndex = 1, #questLogObjectives do
                local objective = quest.ObjectiveData[objectiveIndex]
                if objective then
                    local isComplete = questLogObjectives[objectiveIndex].finished == true
                    if objective.NPC then
                        GetQuestObjectivesNPC(result, objective.NPC, "NPC", isComplete, objectiveIndex)
                    elseif objective.GameObject then
                        GetQuestObjectivesObject(result, objective.GameObject, "Object", isComplete, objectiveIndex)
                    elseif objective.Item then
                        GetQuestObjectivesItem(result, objective.Item, "Item", isComplete, objectiveIndex)
                    elseif objective.Type == "monster" then
                        GetQuestObjectivesNPC(result, { objective.Id }, "NPC", isComplete, objectiveIndex)
                    elseif objective.Type == "object" then
                        GetQuestObjectivesObject(result, { objective.Id }, "Object", isComplete, objectiveIndex)
                    elseif objective.Type == "item" then
                        GetQuestObjectivesItem(result, { objective.Id }, "Item", isComplete, objectiveIndex)
                    elseif objective.Type == "event" then
                        tinsert(result, { name = objective.Text, type = "Event", isComplete = isComplete, objectiveIndex = objectiveIndex })
                    end
                end
            end
        end

        if quest.sourceItemId then -- Item provided by quest starter
            GetQuestObjectivesItem(result, { quest.sourceItemId }, "Item", false)
        end

        if quest.requiredSourceItems then -- Items that are not an objective but still needed for the quest
            GetQuestObjectivesItem(result, quest.requiredSourceItems, "Item", false)
        end

        if quest.extraObjectives then -- Extra custom objectives needed for the quest
            List:ForEach(quest.extraObjectives, function(extraObjective)
                if extraObjective then
                    local spawns = extraObjective[1]
                    if spawns then
                        tinsert(result, { name = extraObjective[3], type = "Event", isComplete = false })
                    end
                    local entities = extraObjective[5]
                    if entities then
                        List:ForEach(entities, function(entity)
                            local type = entity[1]
                            local id = entity[2]
                            if type == "monster" then
                                GetQuestObjectivesNPC(result, { id }, "NPC", false)
                            elseif type == "object" then
                                GetQuestObjectivesObject(result, { id }, "Object", false)
                            elseif type == "item" then
                                GetQuestObjectivesItem(result, { id }, "Item", false)
                            end
                        end)
                    end
                end
            end)
        end

        return result
    end
end

function DataSourceQuestie:GetQuestHasRequiredRace(questId)
    local requiredRaces = QuestieDB.QueryQuestSingle(questId, "requiredRaces")
    return QuestiePlayer:HasRequiredRace(requiredRaces) == true
end

function DataSourceQuestie:GetQuestHasRequiredClass(questId)
    local requiredClasses = QuestieDB.QueryQuestSingle(questId, "requiredClasses")
    return QuestiePlayer:HasRequiredClass(requiredClasses) == true
end

function DataSourceQuestie:GetQuestHasProfessionAndSkillLevel(questId)
    local requiredSkill = QuestieDB.QueryQuestSingle(questId, "requiredSkill")
    return QuestieProfessions:HasProfessionAndSkillLevel(requiredSkill) == true
end

function DataSourceQuestie:GetQuestHasReputation(questId)
    local requiredMinRep = QuestieDB.QueryQuestSingle(questId, "requiredMinRep")
    local requiredMaxRep = QuestieDB.QueryQuestSingle(questId, "requiredMaxRep")
    return QuestieReputation:HasReputation(requiredMinRep, requiredMaxRep) == true
end

function DataSourceQuestie:GetQuestRequiredLevel(questId)
    local requiredLevel = QuestieDB.QueryQuestSingle(questId, "requiredLevel")
    if requiredLevel then
        return requiredLevel
    end
    return 0
end

function DataSourceQuestie:GetQuestParentQuest(questId)
    local parentQuest = QuestieDB.QueryQuestSingle(questId, "parentQuest")
    if parentQuest and parentQuest ~= 0 then
        return parentQuest
    end
end

function DataSourceQuestie:GetQuestNextQuestInChain(questId)
    local nextQuestInChain = QuestieDB.QueryQuestSingle(questId, "nextQuestInChain")
    if nextQuestInChain and nextQuestInChain ~= 0 then
        return nextQuestInChain
    end
end

function DataSourceQuestie:GetQuestExclusiveTo(questId)
    return QuestieDB.QueryQuestSingle(questId, "exclusiveTo")
end

function DataSourceQuestie:GetQuestPreQuestSingle(questId)
    return QuestieDB.QueryQuestSingle(questId, "preQuestSingle")
end

function DataSourceQuestie:GetQuestPreQuestGroup(questId)
    return QuestieDB.QueryQuestSingle(questId, "preQuestGroup")
end

function DataSourceQuestie:GetNearestQuestStarter(questId)
    local quest = QuestieDB:GetQuest(questId)
    if quest and quest.Starts then
        local player = GetPlayerInfo()
        if player then
            return GetNearestEntityLocation(quest.Starts, player)
        end
    end
end

function DataSourceQuestie:GetQuestObjectiveLocation(questId, objectiveIndex)
    local quest = QuestieDB:GetQuest(questId)
    if quest and quest.ObjectiveData then
        local player = GetPlayerInfo()
        if player then
            return GetNearestEntityLocation(quest.ObjectiveData[objectiveIndex], player)
        end
    end
end

function DataSourceQuestie:GetNearestQuestObjectiveLocation(questId, objectives)
    local quest = QuestieDB:GetQuest(questId)
    if quest == nil or quest.ObjectiveData == nil then
        return nil
    end

    local player = GetPlayerInfo()
    if player == nil then
        return nil
    end

    local bestDistance = 999999999
    local bestX, bestY, bestMapId, bestName, bestId, bestType

    local n = #quest.ObjectiveData
    for i = 1, n do
        if objectives == nil or not objectives[i].finished then
            local nearest = GetNearestEntityLocation(quest.ObjectiveData[i], player)
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

    if quest.requiredSourceItems then -- Items that are not an objective but still needed for the quest
        local nearest = GetNearestItem(quest.requiredSourceItems, player)
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

    if quest.extraObjectives then -- Extra custom objectives needed for the quest
        List:ForEach(quest.extraObjectives, function(extraObjective)
            if extraObjective then
                local spawns = extraObjective[1]
                if spawns then
                    local nearest = GetNearestSpawn(spawns, player)
                    if nearest and nearest.distance < bestDistance then
                        bestDistance = nearest.distance
                        bestX = nearest.x
                        bestY = nearest.y
                        bestMapId = nearest.mapId
                        bestName = extraObjective[3]
                        bestType = "Event"
                    end
                end

                local entities = extraObjective[5]
                if entities then
                    List:ForEach(entities, function(entity)
                        local nearest = GetNearestEntityLocation({ Type = entity[1], Id = entity[2] }, player)
                        if nearest and nearest.distance < bestDistance then
                            bestDistance = nearest.distance
                            bestX = nearest.x
                            bestY = nearest.y
                            bestMapId = nearest.mapId
                            bestName = nearest.name
                            bestId = nearest.id
                            bestType = nearest.type
                        end
                    end)
                end
            end
        end)
    end

    if bestX and bestY and bestMapId then
        return { distance = bestDistance, x = bestX, y = bestY, mapId = bestMapId, name = bestName, id = bestId, type = bestType }
    end
end

function DataSourceQuestie:GetNearestQuestFinisher(questId)
    local quest = QuestieDB:GetQuest(questId)
    if quest and quest.Finisher then
        local player = GetPlayerInfo()
        if player then
            return GetNearestEntityLocation(quest.Finisher, player)
        end
    end
end

function DataSourceQuestie:GetNearestItemLocation(items)
    local player = GetPlayerInfo(true)
    if player then
        return GetNearestItem(items, player)
    end
end

function DataSourceQuestie:IsQuestRepeatable(questId)
    return QuestieDB:IsRepeatable(questId)
end

function DataSourceQuestie:IsQuestAutoComplete(questId)
    local objectivesText = QuestieDB.QueryQuestSingle(questId, "objectivesText")
    return objectivesText == nil or next(objectivesText) == nil
end

function DataSourceQuestie:GetNPCName(npcId, showId)
    local npc = QuestieDB:GetNPC(npcId)
    if npc and npc.name then
        local name = npc.name
        if showId then
            name = name.." ("..npcId..")"
        end
        return name
    end
end

function DataSourceQuestie:GetNPCLocation(npcId)
    local player = GetPlayerInfo()
    if player then
        return GetNearestNPC({ npcId }, player)
    end
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
    if npcs then
        local parentAreaId = Journeyman:GetAreaParentId(areaId)
        if parentAreaId then
            local player = GetPlayerInfo(true)
            if player then
                return GetNearestNPC(npcs, player, parentAreaId)
            end
        end
    end
end

function DataSourceQuestie:GetNearestClassTrainerLocation()
    local npcs = Questie.db.global.classSpecificTownsfolk[Journeyman.player.className]["Class Trainer"] or Questie.db.char.classSpecificTownsfolk[Journeyman.player.className]["Class Trainer"]
    if npcs == nil then return nil end

    local nearest = nil
    local player = GetPlayerInfo(true)
    if player then
        local playerAreaId = Journeyman:GetPlayerAreaId()
        if playerAreaId then
            local parentAreaId = Journeyman:GetAreaParentId(playerAreaId)
            if parentAreaId then
                nearest = GetNearestNPC(npcs, player, parentAreaId, true)
            end
        end
        if nearest == nil then
            nearest = GetNearestNPC(npcs, player)
        end
    end
    return nearest
end

function DataSourceQuestie:GetNearestPortalTrainerLocation()
    local npcs = Questie.db.global.classSpecificTownsfolk["MAGE"]["Portal Trainer"] or Questie.db.char.classSpecificTownsfolk[Journeyman.player.className]["Portal Trainer"]
    if npcs then
        local player = GetPlayerInfo(true)
        if player then
            return GetNearestNPC(npcs, player)
        end
    end
end

function DataSourceQuestie:GetNearestFirstAidTrainerLocation()
    local npcs = Questie.db.global.professionTrainers[QuestieProfessions.professionKeys.FIRST_AID]
    if npcs then
        local player = GetPlayerInfo(true)
        if player then
            return GetNearestNPC(npcs, player)
        end
    end
end

function DataSourceQuestie:GetNearestCookingTrainerLocation()
    local npcs = Questie.db.global.professionTrainers[QuestieProfessions.professionKeys.COOKING]
    if npcs then
        local player = GetPlayerInfo(true)
        if player then
            return GetNearestNPC(npcs, player)
        end
    end
end

function DataSourceQuestie:GetNearestFishingTrainerLocation()
    local npcs = Questie.db.global.professionTrainers[QuestieProfessions.professionKeys.FISHING]
    if npcs then
        local player = GetPlayerInfo(true)
        if player then
            return GetNearestNPC(npcs, player)
        end
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
        if TaxiNodes:IsAvailable(taxiNodeId) then
            local npcs = Questie.db.global.townsfolk["Flight Master"] or Questie.db.char.townsfolk["Flight Master"]
            local taxiNodeWorldCoords = TaxiNodes:GetWorldCoordinates(taxiNodeId)
            local nearest = GetNearestNPC(npcs, { instanceId = taxiNodeWorldCoords.instanceId, worldX = taxiNodeWorldCoords.x, worldY = taxiNodeWorldCoords.y })
            if nearest then
                self.taxiNodeIdToNPCId[taxiNodeId] = nearest.id
                self.npcIdToTaxiNodeId[nearest.id] = taxiNodeId
            else
                self.taxiNodeIdToNPCId[taxiNodeId] = -1
            end
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
            local player = GetPlayerInfo()
            if player then
                return GetNearestNPC({ npcId }, player)
            end
        end
    end
end

function DataSourceQuestie:GetNPCTaxiNodeId(npcId)
    if self.npcIdToTaxiNodeId == nil then
        self.npcIdToTaxiNodeId = {}
    end

    if self.npcIdToTaxiNodeId[npcId] == nil then
        for taxiNodeId, _ in pairs(L.taxiNodes) do
            if TaxiNodes:IsAvailable(taxiNodeId) then
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
        local player = GetPlayerInfo(true)
        if player then
            return GetNearestNPC(npcs, player)
        end
    end
end

function DataSourceQuestie:GetObjectName(objectId, showId)
    local obj = QuestieDB:GetObject(objectId)
    if obj and obj.name then
        local name = obj.name
        if showId then
            name = name.." ("..objectId..")"
        end
        return name
    end
end

function DataSourceQuestie:ShowQuestTooltip(questId)
    local questLink = QuestieLink:GetQuestHyperLink(questId)
    ShowUIPanel(ItemRefTooltip)
    ItemRefTooltip:SetOwner(UIParent, "ANCHOR_PRESERVE");
    ItemRefTooltip:SetHyperlink(questLink)
    ItemRefTooltip:Show()
end
