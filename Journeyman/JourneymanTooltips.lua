local addonName, addon = ...
local Tooltips, Private = addon:NewModule("Tooltips"), {}
local L = addon.Locale

local strsplit, unpack = strsplit, unpack
local String = LibStub("LibCollections-1.0").String
local List = LibStub("LibCollections-1.0").List
local State

local function OnTooltipSetUnit(tooltip, ...)
    local unitName, unitId = tooltip:GetUnit()
    if String:IsNilOrEmpty(unitName) or String:IsNilOrEmpty(unitId) then
        return
    end

    local unitGuid = UnitGUID(unitId)
    if String:IsNilOrEmpty(unitGuid) then
        return
    end

    local unitType, _, serverId, instanceId, zoneId, id, spawnId = strsplit("-", unitGuid)
    if String:IsNilOrEmpty(id) then
        return
    end
    id = tonumber(id)

    local args = {...}
    local npcData = addon:GetActiveJourneyNPCData(id, function()
        OnTooltipSetUnit(tooltip, unpack(args))
    end)

    if npcData and List:Count(npcData.quests) > 0 then
        -- Make sure state is up-to-date
        State:Update(true)

        -- Get quests to show
        local quests = List:Where(npcData.quests, function(quest)
            return State:IsQuestAvailable(quest.id) and not State:IsQuestInQuestLog(quest.id) and not State:IsQuestTurnedIn(quest.id) and quest.itemId and (quest.objectiveType == "Vendor" or not addon:IsItemQuestItem(quest.itemId))
        end)

        -- Display each quest to show
        List:ForEach(quests, function(quest)
            local questName = addon:GetQuestName(quest.id, addon.db.profile.window.showQuestLevel)
            if not String:IsNilOrEmpty(questName) then
                -- Add quest name
                local questColor = addon:GetQuestColor(quest.id)
                tooltip:AddLine(string.format("|c%s%s|r", questColor, questName))

                -- Add quest objective
                local objectives = State:GetQuestObjectives(quest.id)
                if objectives then
                    local objective = objectives[quest.objectiveIndex]
                    if objective then
                        local itemName = addon:GetItemName(quest.itemId, function()
                            OnTooltipSetUnit(tooltip, unpack(args))
                        end)
                        tooltip:AddLine(string.format("   %s/%s %s", objective.numFulfilled, objective.numRequired, itemName), 1, 1, 1)
                    end
                end
            end
        end)

        tooltip:Show()
    end
end

local function OnTooltipSetItem(tooltip, ...)
    local itemName, itemLink = tooltip:GetItem()
    if String:IsNilOrEmpty(itemName) or String:IsNilOrEmpty(itemLink) then
        return
    end

    local itemId = GetItemInfoInstant(itemLink)
    if not itemId then
        return
    end

    local args = {...}
    local itemData = addon:GetActiveJourneyItemData(itemId, function()
        OnTooltipSetItem(tooltip, unpack(args))
    end)

    if itemData and List:Count(itemData.quests) > 0 then
        -- Make sure state is up-to-date
        State:Update(true)

        -- Get quests to show
        local quests = List:Where(itemData.quests, function(quest)
            return State:IsQuestAvailable(quest.id) and not State:IsQuestInQuestLog(quest.id) and not State:IsQuestTurnedIn(quest.id)
        end)

        -- Display each quest to show
        List:ForEach(quests, function(quest)
            local questName = addon:GetQuestName(quest.id, addon.db.profile.window.showQuestLevel)
            if not String:IsNilOrEmpty(questName) then
                -- Add quest name
                local questColor = addon:GetQuestColor(quest.id)
                tooltip:AddLine(string.format("|c%s%s|r", questColor, questName))

                -- Add quest objective
                local objectives = State:GetQuestObjectives(quest.id)
                if objectives then
                    local objective = objectives[quest.objectiveIndex]
                    if objective then
                        tooltip:AddLine(string.format("   %s/%s %s", objective.numFulfilled, objective.numRequired, itemName), 1, 1, 1)
                    end
                end
            end
        end)

        tooltip:Show()
    end
end

function Tooltips:OnInitialize()
    State = addon.State
end

function Tooltips:OnEnable()
    GameTooltip:HookScript("OnTooltipSetUnit", OnTooltipSetUnit)
    GameTooltip:HookScript("OnTooltipSetItem", OnTooltipSetItem)
    ItemRefTooltip:HookScript("OnTooltipSetItem", OnTooltipSetItem)
    ShoppingTooltip1:HookScript("OnTooltipSetItem", OnTooltipSetItem)
    ShoppingTooltip2:HookScript("OnTooltipSetItem", OnTooltipSetItem)
end

function Tooltips:OnDisable()
end
