local addonName, addon = ...
addon.Journeyman = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceHook-3.0", "AceEvent-3.0", "AceConsole-3.0")
addon.Locale = LibStub("AceLocale-3.0"):GetLocale(addonName)

local Journeyman = addon.Journeyman
local L = addon.Locale

local String = LibStub("LibCollections-1.0").String
local List = LibStub("LibCollections-1.0").List
local Dict = LibStub("LibCollections-1.0").Dictionary
local HBD = LibStub("HereBeDragons-2.0")

Journeyman.BYTE_ORDER_MARK = "!JM1"
Journeyman.STEP_TYPE_UNDEFINED = "UNDEFINED"
Journeyman.STEP_TYPE_ACCEPT_QUEST = "ACCEPT"
Journeyman.STEP_TYPE_COMPLETE_QUEST = "COMPLETE"
Journeyman.STEP_TYPE_TURNIN_QUEST = "TURNIN"
Journeyman.STEP_TYPE_GO_TO_COORD = "GOTO"
Journeyman.STEP_TYPE_GO_TO_AREA = "GOTOAREA"
Journeyman.STEP_TYPE_GO_TO_ZONE = "GOTOZONE"
Journeyman.STEP_TYPE_REACH_LEVEL = "LEVEL"
Journeyman.STEP_TYPE_BIND_HEARTHSTONE = "BIND"
Journeyman.STEP_TYPE_USE_HEARTHSTONE = "HEARTH"
Journeyman.STEP_TYPE_LEARN_FLIGHT_PATH = "LEARNFP"
Journeyman.STEP_TYPE_FLY_TO = "FLYTO"
Journeyman.STEP_TYPE_TRAIN_CLASS = "TRAIN"
Journeyman.STEP_TYPE_TRAIN_SPELLS = "TRAINSPELL"
Journeyman.STEP_TYPE_LEARN_FIRST_AID = "LEARNFIRSTAID"
Journeyman.STEP_TYPE_LEARN_COOKING = "LEARNCOOKING"
Journeyman.STEP_TYPE_LEARN_FISHING = "LEARNFISHING"
Journeyman.STEP_TYPE_DIE_AND_RES = "DIE"

Journeyman.ITEM_HEARTHSTONE = 6948

Journeyman.NPC_STORMWIND_PORTAL_TRAINER = 2485
Journeyman.NPC_IRONFORGE_PORTAL_TRAINER = 2489
Journeyman.NPC_DARNASSUS_PORTAL_TRAINER = 4165

Journeyman.SPELL_HEARTHSTONE = 8690
Journeyman.SPELL_ASTRAL_RECALL = 556
Journeyman.SPELL_FIRST_AID_APPRENTICE = 3273
Journeyman.SPELL_COOKING_APPRENTICE = 2550
Journeyman.SPELL_FISHING_APPRENTICE = 7620
Journeyman.SPELL_TELEPORT_TO_STORMWIND = 3561
Journeyman.SPELL_TELEPORT_TO_IRONFORGE = 3562
Journeyman.SPELL_TELEPORT_TO_DARNASSUS = 3565
Journeyman.SPELL_PORTAL_TO_STORMWIND = 10059
Journeyman.SPELL_PORTAL_TO_IRONFORGE = 11416
Journeyman.SPELL_PORTAL_TO_DARNASSUS = 11419

Journeyman.ICON_HUNTERS_MARK = 132212

-- Store races info
Journeyman.raceName = {}
Journeyman.raceNameLocal = {}
Journeyman.raceId = {}
Journeyman.raceMask = {}
for i = 1, 64 do
    local raceInfo = C_CreatureInfo.GetRaceInfo(i)
    if raceInfo then
        local raceMask = bit.lshift(1, raceInfo.raceID - 1)
        local raceName = raceInfo.clientFileString:upper()
        local raceNameLocal = raceInfo.raceName
        local raceId = raceInfo.raceID
        Journeyman["RACE_"..raceName] = raceMask
        Journeyman.raceName[raceMask] = raceName
        Journeyman.raceNameLocal[raceMask] = raceNameLocal
        Journeyman.raceId[raceMask] = raceId
        Journeyman.raceMask[raceId] = raceMask
    else
        break
    end
end

-- Store classes info
Journeyman.className = {}
Journeyman.classNameLocal = {}
Journeyman.classId = {}
Journeyman.classMask = {}
local numClasses = GetNumClasses()
for i = 1, numClasses do
    local classNameLocal, className, classId = GetClassInfo(i)
    if classNameLocal and className and classId then
        local classMask = bit.lshift(1, classId - 1)
        Journeyman["CLASS_"..className] = classMask
        Journeyman.className[classMask] = className
        Journeyman.classNameLocal[classMask] = classNameLocal
        Journeyman.classId[classMask] = classId
        Journeyman.classMask[classId] = classMask
    end
end

local tinsert = table.insert

local function Equals(a, b, epsilon)
    local diff = math.abs(a - b)
    return diff <= epsilon
end

local function LocationEquals(current, previous)
    if current == nil and previous == nil then
        return true
    end
    if current == nil or previous == nil then
        return false
    end
    if current.mapId ~= previous.mapId then
        return false
    end
    if not Equals(current.x, previous.x, 0.0001) then
        return false
    end
    if not Equals(current.y, previous.y, 0.0001) then
        return false
    end
    return true
end

-- Some taxi nodes were never implemented in game, or are innacessible, or don't need to be considered (e.g. battlegrounds)
local taxiNodeIdsToSkip = {1, 3, 9, 15, 24, 34, 35, 36, 46, 47, 50, 51, 54, 57, 59, 60, 78, 84, 85, 86, 87}
local skipTaxiNodeIds = {}
for i = 1, #taxiNodeIdsToSkip do
    skipTaxiNodeIds[taxiNodeIdsToSkip[i]] = true
end

function Journeyman:OnInitialize()
    self.player = {}

    local factionName, factionNameLocal = UnitFactionGroup("player")
    self.player.factionName = factionName
    self.player.factionNameLocal = factionNameLocal

    local raceNameLocal, raceName, raceId = UnitRace("player")
    self.player.raceName = raceName
    self.player.raceNameLocal = raceNameLocal
    self.player.raceId = raceId
    self.player.raceMask = bit.lshift(1, raceId - 1)

    local classNameLocal, className, classId = UnitClass("player")
    self.player.className = className
    self.player.classNameLocal = classNameLocal
    self.player.classId = classId
    self.player.classMask = bit.lshift(1, classId - 1)

    self.player.level = UnitLevel("player")
    self.player.xp = UnitXP("player")
    self.player.maxXP = UnitXPMax("player")
    self.player.greenRange = GetQuestGreenRange("player")
    self.player.location = nil

    self:InitializeDatabase()
    self.Editor:Initialize()
    self:InitializeOptions()
    self.State:Initialize()
    self:InitializeHooks()
    self:InitializeEvents()
    self.Journey:Initialize()
    self.Window:Initialize()
end

function Journeyman:OnEnable()
    self:Reset()

    -- Install update ticker
    local updateFrequency = min(max(Journeyman.db.profile.advanced.updateFrequency, 0.1), 5)
    self.updateTicker = C_Timer.NewTicker(updateFrequency, function()
        -- Check for state and window update
        self.State:CheckForUpdate()
        self.Window:CheckForUpdate()
    end)

    -- High frequency ticker for goto steps
    C_Timer.NewTicker(0.25, function()
        if self:UpdatePosition() then
            self:OnLocationChanged()
        end
    end)
end

function Journeyman:OnDisable()
    self.Editor:Shutdown()
    self.Window:Shutdown()
    self:ShutdownEvents()
    self.State:Shutdown()
end

function Journeyman:Reset(immediate)
    if self.db.char.window.show then
        self.State:Reset(immediate)
    end
end

function Journeyman:Update(immediate)
    if self.db.char.window.show then
        self.State:Update(immediate)
    end
end

function Journeyman:UpdatePosition()
    if not Journeyman.db.char.window.show then
        return
    end

    -- Get player location
    local location = nil
    local playerX, playerY, playerMapId = HBD:GetPlayerZonePosition()
    if playerMapId and playerX and playerY then
        location = { mapId = playerMapId, x = playerX, y = playerY }
    end

    -- Check if location changed
    local locationChanged = LocationEquals(location, self.player.location) == false

    -- Store player location
    self.player.location = location

    return locationChanged
end

Journeyman._Print = Journeyman.Print
Journeyman.Print = function(self, fmt, ...)
    Journeyman._Print(self, string.format(fmt, ...))
end

function Journeyman:Debug(fmt, ...)
    if self.db.profile.advanced.debug then
        self:Print("[DEBUG] " .. string.format(fmt, ...))
    end
end

function Journeyman:Error(fmt, ...)
    if self.db.profile.advanced.debug then
        local text = string.format(fmt, ...)
        self:Print("[ERROR] " .. text)
        error(text)
    end
end

function Journeyman:GetQuestLogNumEntries()
    if C_QuestLog.GetNumQuestLogEntries ~= nil then
        return C_QuestLog.GetNumQuestLogEntries()
    else
        return GetNumQuestLogEntries()
    end
end

function Journeyman:GetQuestLogInfo(questLogIndex)
    if C_QuestLog.GetInfo then
        local info = C_QuestLog.GetInfo(questLogIndex)
        if info then
            return {
                title = info.title,
                level = info.level,
                suggestedGroup = info.suggestedGroup,
                isHeader = info.isHeader,
                isCollapsed = info.isCollapsed,
                isComplete = C_QuestLog.IsComplete(info.questID),
                isFailed = C_QuestLog.IsFailed(info.questID),
                frequency = info.frequency,
                questId = info.questID,
                questLogIndex = questLogIndex
            }
        end
    else
        local title, level, suggestedGroup, isHeader, isCollapsed, isComplete, frequency, questId = GetQuestLogTitle(questLogIndex)
        if title then
            return {
                title = title,
                level = level,
                suggestedGroup = suggestedGroup,
                isHeader = isHeader,
                isCollapsed = isCollapsed,
                isComplete = isComplete == 1,
                isFailed = isComplete == -1,
                frequency = frequency,
                questId = questId,
                questLogIndex = questLogIndex
            }
        end
    end
end

function Journeyman:GetQuestLog()
    local questLog = {}
    local entriesCount = self:GetQuestLogNumEntries()
    for i = 1, entriesCount do
        local info = self:GetQuestLogInfo(i)
        if info and not info.isHeader then
            info.objectives = C_QuestLog.GetQuestObjectives(info.questId)
            questLog[info.questId] = info
        end
    end
    return questLog
end

function Journeyman:GetItemName(itemId, callback)
    if itemId and type(itemId) == "number" then
        local itemName = GetItemInfo(itemId)
        if itemName == nil then
            if callback and type(callback) == "function" then
                local item = Item:CreateFromItemID(itemId)
                item:ContinueOnItemLoad(callback)
            end
            return "item:"..itemId
        end
        return itemName
    end
end

function Journeyman:GetItemLink(itemId, callback)
    if itemId and type(itemId) == "number" then
        local itemName, itemLink = GetItemInfo(itemId)
        if itemName == nil then
            if callback and type(callback) == "function" then
                local item = Item:CreateFromItemID(itemId)
                item:ContinueOnItemLoad(callback)
            end
            return "item:"..itemId
        end
        return itemLink
    end
end

function Journeyman:GetSpellName(spellId, callback)
    if spellId and type(spellId) == "number" then
        local spellName = GetSpellInfo(spellId)
        if spellName == nil then
            if callback and type(callback) == "function" then
                local spell = Spell:CreateFromSpellID(spellId)
                spell:ContinueOnSpellLoad(callback)
            end
            return "spell:"..spellId
        end
        return spellName
    end
end

function Journeyman:IsSpellKnown(spellId)
    return IsPlayerSpell(spellId) or IsSpellKnown(spellId) or IsSpellKnown(spellId, true)
end

function Journeyman:GetMapName(showId)
    local mapId = C_Map.GetBestMapForUnit("player")
    return self:GetMapNameById(mapId, showId)
end

function Journeyman:GetMapNameById(mapId, showId)
    local mapInfo = mapId and C_Map.GetMapInfo(mapId) or nil
    if mapInfo then
        local mapName = mapInfo.name
        if showId then
            mapName = mapName.." ("..mapId..")"
        end
        return mapName
    end
end

function Journeyman:GetPlayerAreaId()
    local mapId = C_Map.GetBestMapForUnit("player")
    if mapId then
        local pos = C_Map.GetPlayerMapPosition(mapId, "player")
        local areaIds = C_MapExplorationInfo.GetExploredAreaIDsAtPosition(mapId, pos)
        if areaIds == nil then
            areaIds = self:GetAreaIdsFromLocalizedName(self:GetMapNameById(mapId))
        end
        if areaIds then
            return List:First(areaIds, function(areaId) return not String:IsNilOrEmpty(C_Map.GetAreaInfo(areaId)) end)
        end
    end
end

function Journeyman:GetAreaIdsFromLocalizedName(name)
    if String:IsNilOrEmpty(name) then
        return nil
    end

    if self.areaLocalizedNameToAreaIds == nil then
        self.areaLocalizedNameToAreaIds = {}
    end

    local areaIds = self.areaLocalizedNameToAreaIds[name]
    if areaIds ~= nil then
        return areaIds
    end

    Dict:ForEach(L.areaTable, function(k, v)
        if self.areaLocalizedNameToAreaIds[v.AreaName_lang] == nil then
            self.areaLocalizedNameToAreaIds[v.AreaName_lang] = {}
        end
        List:Add(self.areaLocalizedNameToAreaIds[v.AreaName_lang], k)
    end)

    return self.areaLocalizedNameToAreaIds[name]
end

function Journeyman:GetAreaIdFromLocalizedName(name)
    local areaIds = self:GetAreaIdsFromLocalizedName(name)
    if areaIds then
        return List:First(areaIds, function(areaId) return not String:IsNilOrEmpty(C_Map.GetAreaInfo(areaId)) end)
    end
end

function Journeyman:GetAreaNameById(areaId, showId)
    if areaId and type(areaId) == "number" then
        local info = L.areaTable[areaId]
        if info then
            local areaName = info.AreaName_lang
            if showId then
                areaName = areaName.." ("..areaId..")"
            end
            return areaName
        end
    end
end

function Journeyman:GetAreaParentId(areaId)
    if areaId and type(areaId) == "number" then
        local info = L.areaTable[areaId]
        if info then
            if info.ParentAreaID ~= 0 then
                return info.ParentAreaID
            else
                return areaId
            end
        end
    end
end

function Journeyman:GetTaxiNodeId(slot)
    local name = TaxiNodeName(slot)
    if name then
        return Journeyman:GetTaxiNodeIdFromLocalizedName(name)
    end
end

function Journeyman:GetTaxiNodeIdFromLocalizedName(name)
    if self.taxiNodeNameToTaxiNodeId == nil then
        self.taxiNodeNameToTaxiNodeId = {}
        for k, v in pairs(L.taxiNodes) do
            if self:IsTaxiNodeAvailable(k) then
                if self.taxiNodeNameToTaxiNodeId[v.Name_lang] == nil then
                    self.taxiNodeNameToTaxiNodeId[v.Name_lang] = k
                else
                    --Journeyman:Debug("taxiNodeNameToTaxiNodeId table already contains key pair ('%s', %d), when trying to add ('%s', %d)", v.Name_lang, self.taxiNodeNameToTaxiNodeId[v.Name_lang], v.Name_lang, k)
                end
            end
        end
    end
    return self.taxiNodeNameToTaxiNodeId[name]
end

function Journeyman:IsTaxiNodeAvailable(taxiNodeId)
    if skipTaxiNodeIds[taxiNodeId] then
        return false
    end

    local taxiNodeFaction = Journeyman:GetTaxiNodeFaction(taxiNodeId)
    if self.player.factionName ~= taxiNodeFaction and taxiNodeFaction ~= "Neutral" then
        return false
    end

    return true
end

function Journeyman:GetTaxiNodeName(taxiNodeId, showId)
    if taxiNodeId and type(taxiNodeId) == "number" then
        local info = L.taxiNodes[taxiNodeId]
        if info then
            local taxiNodeName = info.Name_lang
            if showId then
                taxiNodeName = taxiNodeName.." ("..taxiNodeId..")"
            end
            return taxiNodeName
        end
    end
end

function Journeyman:GetTaxiNodeWorldCoordinates(taxiNodeId)
    if taxiNodeId and type(taxiNodeId) == "number" then
        local info = L.taxiNodes[taxiNodeId]
        if info then
            return { instanceId = info.ContinentID, x = info.Pos[2], y = info.Pos[1] }
        end
    end
end

function Journeyman:GetTaxiNodeFaction(taxiNodeId)
    if taxiNodeId and type(taxiNodeId) == "number" then
        local info = L.taxiNodes[taxiNodeId]
        if info then
            if info.Flags == 1 then
                return "Alliance"
            elseif info.Flags == 2 then
                return "Horde"
            elseif info.Flags == 3 then
                return "Neutral"
            end
        end
    end
end

function Journeyman:IsStepTypeQuest(step)
    return step.type == self.STEP_TYPE_ACCEPT_QUEST or step.type == self.STEP_TYPE_COMPLETE_QUEST or step.type == self.STEP_TYPE_TURNIN_QUEST
end

function Journeyman:IsStepTypeUnique(step)
    return self:IsStepTypeQuest(step) or
        step.type == Journeyman.STEP_TYPE_REACH_LEVEL or
        step.type == Journeyman.STEP_TYPE_LEARN_FLIGHT_PATH or
        step.type == Journeyman.STEP_TYPE_TRAIN_SPELLS or
        step.type == Journeyman.STEP_TYPE_LEARN_FIRST_AID or
        step.type == Journeyman.STEP_TYPE_LEARN_COOKING or
        step.type == Journeyman.STEP_TYPE_LEARN_FISHING
end

function Journeyman:GetStepData(step)
    if step.type == Journeyman.STEP_TYPE_UNDEFINED then
        return nil
    end

    local data
    if step.data and type(step.data) == "string" then
        if self:IsStepTypeQuest(step) then
            local values = String:Split(step.data, ",")
            local questId = tonumber(values[1])
            if questId then
                data = { questId = questId }
                if #values > 1 then
                    local objectives = {}
                    for i=2, #values do
                        local objectiveIndex = tonumber(values[i])
                        if objectiveIndex then
                            tinsert(objectives, objectiveIndex)
                        end
                    end
                    if #objectives > 0 then
                        data.objectives = objectives
                    end
                end
            end
        elseif step.type == Journeyman.STEP_TYPE_GO_TO_COORD then
            local values = String:Split(step.data, ",")
            local mapId = tonumber(values[1])
            local mapName = Journeyman:GetMapNameById(mapId)
            local x = tonumber(values[2])
            local y = tonumber(values[3])
            local desc = values[4]
            if mapId and mapName and x and y then
                if desc == nil or desc:len() == 0 then
                     desc = x..", "..y
                end
                data = { mapId = mapId, mapName = mapName, x = x, y = y, desc = desc }
            end
        elseif step.type == Journeyman.STEP_TYPE_GO_TO_ZONE then
            local values = String:Split(step.data, ",")
            local mapId = tonumber(values[1])
            local mapName = Journeyman:GetMapNameById(mapId)
            if mapId and mapName then
                local x = tonumber(values[2])
                local y = tonumber(values[3])
                data = { mapId = mapId, mapName = mapName, x = x, y = y }
            end
        elseif step.type == Journeyman.STEP_TYPE_GO_TO_AREA then
            local values = String:Split(step.data, ",")
            local areaId = tonumber(values[1])
            local areaName = Journeyman:GetAreaNameById(areaId)
            local x = tonumber(values[2])
            local y = tonumber(values[3])
            local desc = values[4]
            if areaId and areaName and x and y then
                if desc == nil or desc:len() == 0 then
                     desc = x..", "..y
                end
                data = { areaId = areaId, areaName = areaName, x = x, y = y, desc = desc }
            end
        elseif step.type == Journeyman.STEP_TYPE_REACH_LEVEL then
            local values = String:Split(step.data, ",")
            local level = tonumber(values[1])
            local xp = tonumber(values[2])
            if level then
                data = { level = level }
                if xp then
                    data.xp = xp
                end
            end
        elseif step.type == Journeyman.STEP_TYPE_BIND_HEARTHSTONE or step.type == Journeyman.STEP_TYPE_USE_HEARTHSTONE then
            local areaId = tonumber(step.data)
            if areaId then
                data = { areaId = areaId }
            end
        elseif step.type == Journeyman.STEP_TYPE_LEARN_FLIGHT_PATH or step.type == Journeyman.STEP_TYPE_FLY_TO then
            local taxiNodeId = tonumber(step.data)
            if taxiNodeId then
                data = { taxiNodeId = taxiNodeId }
            end
        elseif step.type == Journeyman.STEP_TYPE_TRAIN_CLASS then
            data = {}
        elseif step.type == Journeyman.STEP_TYPE_TRAIN_SPELLS then
            local values = String:Split(step.data, ",")
            local spells = {}
            for i = 1, #values do
                local spellId = tonumber(values[i])
                if spellId then
                    tinsert(spells, spellId)
                end
            end
            if #spells > 0 then
                data = { spells = spells }
            end
        elseif step.type == Journeyman.STEP_TYPE_LEARN_FIRST_AID then
            data = {}
        elseif step.type == Journeyman.STEP_TYPE_LEARN_COOKING then
            data = {}
        elseif step.type == Journeyman.STEP_TYPE_LEARN_FISHING then
            data = {}
        elseif step.type == Journeyman.STEP_TYPE_DIE_AND_RES then
            data = {}
        else
            Journeyman:Error("Step type %s not implemented.", step.type)
        end
    end
    return data
end

function Journeyman:GetStepText(step, showQuestLevel, showId, callback)
    if step.type == Journeyman.STEP_TYPE_UNDEFINED then
        return string.format("<%s>", L["UNDEFINED"])
    end

    local data = self:GetStepData(step)
    if self:IsStepTypeQuest(step) then
        local questId = data and data.questId or 0
        local questName = self.DataSource:GetQuestName(questId, showQuestLevel, showId)
        if questName == nil then
            questName = string.format("quest:%d", questId)
        end

        if step.type == Journeyman.STEP_TYPE_ACCEPT_QUEST then
            return string.format(L["STEP_TEXT_ACCEPT_QUEST"], questName)
        elseif step.type == Journeyman.STEP_TYPE_COMPLETE_QUEST then
            return string.format(L["STEP_TEXT_COMPLETE_QUEST"], questName)
        elseif step.type == Journeyman.STEP_TYPE_TURNIN_QUEST then
            return string.format(L["STEP_TEXT_TURNIN_QUEST"], questName)
        else
            Journeyman:Error("Step type %s not implemented.", step.type)
        end

    elseif step.type == Journeyman.STEP_TYPE_GO_TO_COORD then
        local mapId = data and data.mapId or 0
        local mapName = Journeyman:GetMapNameById(mapId, showId)
        if mapName == nil then
            mapName = string.format("map:%d", mapId)
        end

        local desc = data and data.desc or nil
        if desc == nil then
            local x = data and data.x or 0
            local y = data and data.y or 0
            desc = x..", "..y
        end

        return string.format(L["STEP_TEXT_GO_TO_COORD"], desc, mapName)

    elseif step.type == Journeyman.STEP_TYPE_GO_TO_ZONE then
        local mapId = data and data.mapId or 0
        local mapName = Journeyman:GetMapNameById(mapId, showId)
        if mapName == nil then
            mapName = string.format("map:%d", mapId)
        end

        return string.format(L["STEP_TEXT_GO_TO_ZONE"], mapName)

    elseif step.type == Journeyman.STEP_TYPE_GO_TO_AREA then
        local areaId = data and data.areaId or 0
        local areaName = Journeyman:GetAreaNameById(areaId, showId)
        if areaName == nil then
            areaName = string.format("area:%d", areaId)
        end

        local desc = data and data.desc or nil
        if desc == nil then
            local x = data and data.x or 0
            local y = data and data.y or 0
            desc = x..", "..y
        end

        return string.format(L["STEP_TEXT_GO_TO_AREA"], desc, areaName)

    elseif step.type == Journeyman.STEP_TYPE_REACH_LEVEL then
        local level = data and data.level or 0
        local text = string.format(L["STEP_TEXT_REACH_LEVEL"], level)
        if data and data.xp then
            text = text..string.format(" +%s xp", data.xp)
        end
        return text

    elseif step.type == Journeyman.STEP_TYPE_BIND_HEARTHSTONE or step.type == Journeyman.STEP_TYPE_USE_HEARTHSTONE then
        local itemLink = Journeyman:GetItemLink(Journeyman.ITEM_HEARTHSTONE, callback)
        if itemLink == nil then
            itemLink = string.format("<%s>", L["NO_VALUE"])
        elseif type(itemLink) ~= "string" then
            itemLink = string.format("<%s>", L["NOT_A_STRING"])
        end

        local areaId = data and data.areaId or 0
        local areaName = self:GetAreaNameById(areaId, showId)
        if areaName == nil then
            areaName = string.format("area:%d", areaId)
        end

        if step.type == Journeyman.STEP_TYPE_BIND_HEARTHSTONE then
            return string.format(L["STEP_TEXT_BIND_HEARTHSTONE"], itemLink, areaName)
        else
            return string.format(L["STEP_TEXT_USE_HEARTHSTONE"], itemLink, areaName)
        end

    elseif step.type == Journeyman.STEP_TYPE_LEARN_FLIGHT_PATH or step.type == Journeyman.STEP_TYPE_FLY_TO then
        local taxiNodeId = data and data.taxiNodeId or 0
        local taxiNodeName = self:GetTaxiNodeName(taxiNodeId, showId)
        if taxiNodeName == nil then
            taxiNodeName = string.format("taxi:%d", taxiNodeId)
        end

        if step.type == Journeyman.STEP_TYPE_LEARN_FLIGHT_PATH then
            return string.format(L["STEP_TEXT_LEARN_FLIGHT_PATH"], taxiNodeName)
        else
            return string.format(L["STEP_TEXT_FLY_TO"], taxiNodeName)
        end

    elseif step.type == Journeyman.STEP_TYPE_TRAIN_CLASS then
        return L["STEP_TEXT_TRAIN_CLASS"]

    elseif step.type == Journeyman.STEP_TYPE_TRAIN_SPELLS then
        local spells = ""
        if data and data.spells then
            local spellNames = {}
            List:ForEach(data.spells, function(spellId)
                List:Add(spellNames, self:GetSpellName(spellId, callback))
            end)
            spells = String:Join(", ", spellNames)
        end
        return string.format(L["STEP_TEXT_TRAIN_SPELLS"], spells)

    elseif step.type == Journeyman.STEP_TYPE_LEARN_FIRST_AID then
        return L["STEP_TEXT_LEARN_FIRST_AID"]

    elseif step.type == Journeyman.STEP_TYPE_LEARN_COOKING then
        return L["STEP_TEXT_LEARN_COOKING"]

    elseif step.type == Journeyman.STEP_TYPE_LEARN_FISHING then
        return L["STEP_TEXT_LEARN_FISHING"]

    elseif step.type == Journeyman.STEP_TYPE_DIE_AND_RES then
        return L["STEP_TEXT_DIE_AND_RES"]

    else
        Journeyman:Error("Step type %s not implemented.", step.type)
    end
end

function Journeyman:SetWaypoint(step, force)
    if step == nil or TomTom == nil or TomTom.AddWaypoint == nil or TomTom.RemoveWaypoint == nil then
        return false
    end

    -- Remove last waypoint
    if self.db.char.waypoint then
        TomTom:RemoveWaypoint(self.db.char.waypoint)
        self.db.char.waypoint = nil
    end

    -- Add new waypoint
    local location = nil
    if step.hasChildren then
        location = step.location
    else
        location = self.State:GetStepLocation(step)
    end

    if location == nil then
        return true
    end

    -- Waypoint settings based on step information
    local minDistance = 0
    local clearDistance = 0
    local arrivalDistance = 5
    if step.type == self.STEP_TYPE_COMPLETE_QUEST then
        if location.type == "NPC" or location.type == "NPC Drop" then
            minDistance = 15
            clearDistance = 15
            arrivalDistance = 30
        end
    end

    -- Add waypoint if forced, or if no distance, or if distance is greater or equal to minimum distance
    if force or location.distance == nil or location.distance >= minDistance then
        self.db.char.waypoint = TomTom:AddWaypoint(location.mapId, location.x / 100.0, location.y / 100.0,
        {
            title = location.name,
            persistent = false,
            minimap = true,
            world = true,
            crazy = true,
            cleardistance = clearDistance,
            arrivaldistance = arrivalDistance
        })
    end

    return true
end

function Journeyman:SetMacro(step)
    if InCombatLockdown() then
        return false
    end

    -- Find macro
    local macroId, macroIcon, macroBody
    for i = 1, GetNumMacros() do
        local name, icon, body, isLocal = GetMacroInfo(i)
        if name and name == addonName then
            macroId = i
            macroIcon = icon
            macroBody = body
            break
        end
    end

    -- Create macro if not found
    if macroId == nil then
        macroId = CreateMacro(addonName, Journeyman.ICON_HUNTERS_MARK)
        if macroId then
            local name, icon, body, isLocal = GetMacroInfo(macroId)
            macroIcon = icon
            macroBody = body
        end
    end

    -- Early exit if we can't create a new macro
    if macroId == nil then
        Journeyman:Error("Failed to create targeting macro.")
        return true
    end

    -- Update macro body
    local body = ""
    local suffix = "/cleartarget [noexists][dead][help]\n/tm [exists] 8\n"
    if step and step.type == self.STEP_TYPE_COMPLETE_QUEST then
        -- Get quest objectives
        local objectives = self.DataSource:GetQuestObjectives(step.data.questId, step.data.objectives)
        if objectives then
            -- Get NPC objective names
            local names = {}
            for i, objective in ipairs(objectives or {}) do
                if objective and objective.type == "NPC" and not objective.isComplete then
                    tinsert(names, objective.name)
                end
            end

            -- Append NPC names to macro
            for i, name in ipairs(names) do
                local target = string.format("/tar [noexists][dead][help] %s\n", name)
                if body:len() + target:len() + suffix:len() <= 255 then
                    body = body..target
                else
                    break
                end
            end

        end
    end

    -- Append suffix
    body = body..suffix

    -- Update macro
    if body ~= macroBody then
        EditMacro(macroId, addonName, macroIcon, body)
    end

    return true
end

function Journeyman:ReplaceAllShortLinks(input, callback)
    local result = input
    local matches = {}

    -- Get all short links
    for match, npcId in input:gmatch("(npc:(%d+))") do
        List:Add(matches, { match = match, npcId = tonumber(npcId) })
    end
    for match, itemId in input:gmatch("(item:(%d+))") do
        List:Add(matches, { match = match, itemId = tonumber(itemId) })
    end
    for match, spellId in input:gmatch("(spell:(%d+))") do
        List:Add(matches, { match = match, spellId = tonumber(spellId) })
    end
    for match, mapId in input:gmatch("(map:(%d+))") do
        List:Add(matches, { match = match, mapId = tonumber(mapId) })
    end
    for match, questId in input:gmatch("(quest:(%d+))") do
        List:Add(matches, { match = match, questId = tonumber(questId) })
    end

    -- Replace all short links we found
    List:ForEach(matches, function(m)
        if m.npcId then
            local npcName = Journeyman.DataSource:GetNPCName(m.npcId)
            if not String:IsNilOrEmpty(npcName) and npcName ~= m.match then
                result = result:gsub(m.match, npcName)
            end
        elseif m.itemId then
            local itemLink = Journeyman:GetItemLink(m.itemId, callback)
            if not String:IsNilOrEmpty(itemLink) and itemLink ~= m.match then
                result = result:gsub(m.match, itemLink)
            end
        elseif m.spellId then
            local spellName = Journeyman:GetSpellName(m.spellId, callback)
            if not String:IsNilOrEmpty(spellName) and spellName ~= m.match then
                result = result:gsub(m.match, spellName)
            end
        elseif m.mapId then
            local mapName = Journeyman:GetMapNameById(m.mapId)
            if not String:IsNilOrEmpty(mapName) and mapName ~= m.match then
                result = result:gsub(m.match, mapName)
            end
        elseif m.questId then
            local questName = Journeyman.DataSource:GetQuestName(m.questId, Journeyman.db.profile.window.showQuestLevel)
            if not String:IsNilOrEmpty(questName) and questName ~= m.match then
                result = result:gsub(m.match, questName)
            end
        end
    end)
    return result
end
