local addonName, addon = ...
local L = addon.Locale
local Traveler = addon.Traveler
local QuestieDB = QuestieLoader and QuestieLoader:ImportModule("QuestieDB")
local QuestieLib = QuestieLoader and QuestieLoader:ImportModule("QuestieLib")
local DataSourceQuestie = {}

function DataSourceQuestie:IsInitialized()
    return QuestieDB ~= nil and QuestieDB.QueryQuest ~= nil and type(QuestieDB.QueryQuest) == "function"
end

function DataSourceQuestie:GetQuestName(questId)
    local quest = QuestieDB:GetQuest(questId)
    if quest ~= nil then return quest.name end
end

function DataSourceQuestie:GetColoredQuestName(questId)
    return QuestieLib:GetColoredQuestName(questId, true, false, true)
end

Traveler.DataSource = DataSourceQuestie
