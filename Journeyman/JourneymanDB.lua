local addonName, addon = ...
local JourneymanDB, Private = addon:NewModule("JourneymanDB"), {}
local L = addon.Locale

local String = LibStub("LibCollections-1.0").String
local List = LibStub("LibCollections-1.0").List
local DataSource, TaxiNodes

local Cache = {
    values = {},
    queue = {},
    New = function(self, o)
        o = o or {}
        setmetatable(o, self)
        self.__index = self
        return o
    end,
    Get = function(self, key)
        return self.values[key]
    end,
    Add = function(self, key, value)
        if key and value then
            self.values[key] = value
            List:Add(self.queue, key)
            while List:Count(self.queue) > 100 do
                self.values[self.queue[1]] = nil
                List:RemoveAt(self.queue, 1)
            end
        end
    end,
}

function JourneymanDB:OnInitialize()
    DataSource = addon.DataSource
    TaxiNodes = addon.TaxiNodes
    Private.questCache = Cache:New()
    Private.npcCache = Cache:New()
    Private.itemCache = Cache:New()
    Private.objectCache = Cache:New()
    Private.taxiNodeCache = Cache:New()
end

function JourneymanDB:OnEnable()
end

function JourneymanDB:OnDisable()
end

function JourneymanDB:GetQuest(questId)
    if questId then
        local quest = Private.questCache:Get(questId)
        if quest then
            return quest
        end
        quest = DataSource:GetQuest(questId)
        Private.questCache:Add(questId, quest)
        return quest
    end
end

function JourneymanDB:GetQuestName(questId, showLevel, showId)
    local quest = self:GetQuest(questId)
    if quest then
        local prefix = ""
        if showLevel then
            if quest.type == "elite" then
                prefix = string.format("[%d+]", quest.level)
            elseif quest.type == "dungeon" then
                prefix = string.format("[%dD]", quest.level)
            elseif quest.type == "raid" then
                prefix = string.format("[%dR]", quest.level)
            elseif quest.type == "legendary" then
                prefix = string.format("[%d++]", quest.level)
            else
                prefix = string.format("[%d]", quest.level)
            end
        end

        local suffix = ""
        if showId then
            suffix = string.format("(%d)", quest.id)
        end

        return String:Join(" ", prefix, quest.name, suffix)
    end
end

function JourneymanDB:GetNPC(npcId)
    if npcId then
        local npc = Private.npcCache:Get(npcId)
        if npc then
            return npc
        end
        npc = DataSource:GetNPC(npcId)
        Private.npcCache:Add(npcId, npc)
        return npc
    end
end

function JourneymanDB:GetItem(itemId)
    if itemId then
        local item = Private.itemCache:Get(itemId)
        if item then
            return item
        end
        item = DataSource:GetItem(itemId)
        Private.itemCache:Add(itemId, item)
        return item
    end
end

function JourneymanDB:GetObject(objectId)
    if objectId then
        local object = Private.objectCache:Get(objectId)
        if object then
            return object
        end
        object = DataSource:GetObject(objectId)
        Private.objectCache:Add(objectId, object)
        return object
    end
end

function JourneymanDB:GetTaxiNode(taxiNodeId)
    if taxiNodeId then
        local taxiNode = Private.taxiNodeCache:Get(taxiNodeId)
        if taxiNode then
            return taxiNode
        end
        taxiNode = TaxiNodes:GetTaxiNode(taxiNodeId)
        Private.taxiNodeCache:Add(taxiNodeId, taxiNode)
        return taxiNode
    end
end
