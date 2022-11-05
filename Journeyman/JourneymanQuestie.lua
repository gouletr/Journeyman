local addonName, addon = ...
local DataSourceQuestie, Private = addon:NewModule("DataSourceQuestie"), {}
local L = addon.Locale

local String = LibStub("LibCollections-1.0").String
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
local TaxiNodes, State

local tinsert = table.insert

local function GetPlayerInfo(withFaction)
    local location = addon.player.location
    if location then
        local info = { instanceId = location.instanceId, worldX = location.worldX, worldY = location.worldY, mapId = location.mapId, x = location.x, y = location.y }
        if withFaction then
            info.factionName = addon.player.factionName
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

    if entity.Type == "killcredit" then
        local nearest = GetNearestNPC(entity.IdList, player, zoneFilter)
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

function DataSourceQuestie:OnInitialize()
    TaxiNodes = addon.TaxiNodes
    State = addon.State
end

function DataSourceQuestie:OnEnable()
end

function DataSourceQuestie:OnDisable()
end

function Private:MakeQuestObjectiveNPC(npcId, isVendor)
    local npc = QuestieDB:GetNPC(npcId)
    if npc then
        local objective = { type = "npc", id = npcId }
        if isVendor then
            objective.vendor = true
        end
        return objective
    end
end

function Private:MakeQuestObjectiveItem(itemId)
    local item = QuestieDB:GetItem(itemId)
    if item then
        local sources = {}
        if item.vendors then
            List:ForEach(item.vendors, function(npcId) List:Add(sources, self:MakeQuestObjectiveNPC(npcId, true)) end)
        end
        if item.npcDrops then
            List:ForEach(item.npcDrops, function(npcId) List:Add(sources, self:MakeQuestObjectiveNPC(npcId)) end)
        end
        if item.itemDrops then
            List:ForEach(item.itemDrops, function(itemId) List:Add(sources, self:MakeQuestObjectiveItem(itemId)) end)
        end
        if item.objectDrops then
            List:ForEach(item.objectDrops, function(objectId) List:Add(sources, self:MakeQuestObjectiveObject(objectId)) end)
        end

        local objective = { type = "item", id = itemId }
        if #sources > 0 then
            objective.sources = sources
        end
        return objective
    end
end

function Private:MakeQuestObjectiveObject(objectId)
    local object = QuestieDB:GetObject(objectId)
    if object then
        return { type = "object", id = objectId }
    end
end

function Private:MakeQuestObjectiveEvent(text)
    return { type = "event", text = text }
end

function Private:GetQuestObjectives(quest)
    if quest and quest.ObjectiveData then
        local objectives = {}

        -- Regular quest objectives
        List:ForEach(quest.ObjectiveData, function(objectiveData)
            if objectiveData.NPC then
                List:ForEach(objectiveData.NPC, function(npcId) List:Add(objectives, self:MakeQuestObjectiveNPC(npcId)) end)
            elseif objectiveData.Item then
                List:ForEach(objectiveData.Item, function(itemId) List:Add(objectives, self:MakeQuestObjectiveItem(itemId)) end)
            elseif objectiveData.GameObject then
                List:ForEach(objectiveData.GameObject, function(objectId) List:Add(objectives, self:MakeQuestObjectiveObject(objectId)) end)
            elseif objectiveData.Type == "monster" then
                List:Add(objectives, self:MakeQuestObjectiveNPC(objectiveData.Id))
            elseif objectiveData.Type == "item" then
                List:Add(objectives, self:MakeQuestObjectiveItem(objectiveData.Id))
            elseif objectiveData.Type == "object" then
                List:Add(objectives, self:MakeQuestObjectiveObject(objectiveData.Id))
            elseif objectiveData.Type == "event" then
                List:Add(objectives, self:MakeQuestObjectiveEvent(objectiveData.Text))
            elseif objectiveData.Type == "killcredit" then
                List:ForEach(objectiveData.IdList, function(npcId) List:Add(objectives, self:MakeQuestObjectiveNPC(npcId)) end)
            -- else
                -- addon:Error("Unknown objective data type %s for quest %d", objectiveData.Type, quest.Id)
            end
        end)

        -- Item provided by quest starter
        if quest.sourceItemId then
            List:Add(objectives, self:MakeQuestObjectiveItem(quest.sourceItemId))
        end

        -- Items required to complete quest
        if quest.requiredSourceItems then
            List:ForEach(quest.requiredSourceItems, function(itemId) List:Add(objectives, self:MakeQuestObjectiveItem(itemId)) end)
        end

        -- Extra custom objectives required to complete quest
        if quest.extraObjectives then
            List:ForEach(quest.extraObjectives, function(extraObjective)
                if extraObjective then
                    local spawns = extraObjective[1]
                    if spawns then
                        List:Add(objectives, self:MakeQuestObjectiveEvent(extraObjective[3]))
                    end
                    local entities = extraObjective[5]
                    if entities then
                        List:ForEach(entities, function(entity)
                            local type = entity[1]
                            local id = entity[2]
                            if type == "monster" then
                                List:Add(objectives, self:MakeQuestObjectiveNPC(id))
                            elseif type == "item" then
                                List:Add(objectives, self:MakeQuestObjectiveItem(id))
                            elseif type == "object" then
                                List:Add(objectives, self:MakeQuestObjectiveObject(id))
                            else
                                addon:Error("Unknown extra objective type")
                            end
                        end)
                    end
                end
            end)
        end

        return objectives
    end
end

function Private:MakeSpawn(areaId, x, y)
    local mapId = QuestieZoneDB:GetUiMapIdByAreaId(areaId)
    local worldX, worldY, instanceId = HBD:GetWorldCoordinatesFromZone(x / 100.0, y / 100.0, mapId)
    return { instanceId = instanceId, worldX = worldX, worldY = worldY, mapId = mapId, areaId = areaId, x = x, y = y }
end

function Private:GetSpawns(entity)
    if entity and entity.spawns then
        local result = {}
        Dictionary:ForEach(entity.spawns, function(areaId, spawns)
            local dungeonSpawns = QuestieZoneDB:GetDungeonLocation(areaId)
            if dungeonSpawns then
                List:ForEach(dungeonSpawns, function(spawn) List:Add(result, MakeSpawn(spawn[1], spawn[2], spawn[3])) end)
            else
                List:ForEach(spawns, function(spawn) List:Add(result, MakeSpawn(areaId, spawn[1], spawn[2])) end)
            end
        end)
        return result
    end
end

function Private:IsNPCFriendly(npc, playerFaction)
    local friendlyToFaction = npc.friendlyToFaction
    if friendlyToFaction then
        return (friendlyToFaction == "AH" or friendlyToFaction == "HA") or (playerFaction == "Alliance" and friendlyToFaction == "A") or (playerFaction == "Horde" and friendlyToFaction == "H")
    end
    return false
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

function DataSourceQuestie:GetQuest(questId)
    local quest = QuestieDB:GetQuest(questId)
    if quest then
        return {
            id = questId,
            type = Private:GetQuestType(questId),
            name = String:Trim(quest.name),
            level = quest.questLevel,
            requiredLevel = quest.requiredLevel,
            objectives = Private:GetQuestObjectives(quest)
        }
    end
end

function Private:GetQuestType(questId)
    local questType, questTag = QuestieDB.GetQuestTagInfo(questId)
    if questType then
        if questType == 1 then
            return "elite"
        elseif questType == 81 then
            return "dungeon"
        elseif questType == 62 then
            return "raid"
        elseif questType == 41 then
            return "pvp"
        elseif questType == 83 then
            return "legendary"
        end
    end
end

function DataSourceQuestie:GetNPC(npcId)
    local npc = QuestieDB:GetNPC(npcId)
    if npc then
        return {
            id = npcId,
            name = npc.name,
            spawns = Private:GetSpawns(npc),
            friendly = Private:IsNPCFriendly(npc, addon.player.factionName),
            flags = npc.npcFlags
        }
    end
end

function DataSourceQuestie:GetItem(itemId)
    local item = QuestieDB:GetItem(itemId)
    if item then
        return {
            id = itemId,
            name = item.name,
            spawns = Private:GetSpawns(item)
        }
    end
end

function DataSourceQuestie:GetObject(objectId)
    local object = QuestieDB:GetItem(objectId)
    if object then
        return {
            id = objectId,
            name = object.name,
            spawns = Private:GetSpawns(object)
        }
    end
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
    local questLogObjectives = State:GetQuestObjectives(questId)
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
                    elseif objective.Type == "killcredit" then
                        GetQuestObjectivesNPC(result, objective.IdList, "NPC", isComplete, objectiveIndex)
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
                    elseif objective.Type == "killcredit" then
                        GetQuestObjectivesNPC(result, objective.IdList, "NPC", isComplete, objectiveIndex)
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
    return QuestiePlayer.HasRequiredRace(requiredRaces) == true
end

function DataSourceQuestie:GetQuestHasRequiredClass(questId)
    local requiredClasses = QuestieDB.QueryQuestSingle(questId, "requiredClasses")
    return QuestiePlayer.HasRequiredClass(requiredClasses) == true
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
        local parentAreaId = addon:GetAreaParentId(areaId)
        if parentAreaId then
            local player = GetPlayerInfo(true)
            if player then
                return GetNearestNPC(npcs, player, parentAreaId)
            end
        end
    end
end

function DataSourceQuestie:GetNearestClassTrainerLocation()
    local npcs = Questie.db.global.classSpecificTownsfolk[addon.player.className]["Class Trainer"] or Questie.db.char.classSpecificTownsfolk[addon.player.className]["Class Trainer"]
    if npcs == nil then return nil end

    local nearest = nil
    local player = GetPlayerInfo(true)
    if player then
        local playerAreaId = addon:GetPlayerAreaId()
        if playerAreaId then
            local parentAreaId = addon:GetAreaParentId(playerAreaId)
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
    local npcs = Questie.db.global.classSpecificTownsfolk["MAGE"]["Portal Trainer"] or Questie.db.char.classSpecificTownsfolk[addon.player.className]["Portal Trainer"]
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
