local addonName, addon = ...
addon.Journeyman = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceHook-3.0", "AceEvent-3.0", "AceConsole-3.0")
addon.Locale = LibStub("AceLocale-3.0"):GetLocale(addonName)

local Journeyman = addon.Journeyman
local L = addon.Locale

local TaxiNodes = Journeyman.TaxiNodes
local String = LibStub("LibCollections-1.0").String
local List = LibStub("LibCollections-1.0").List
local Dict = LibStub("LibCollections-1.0").Dictionary
local HBD = LibStub("HereBeDragons-2.0")

local QUEST_COLOR_RED = "FFFF1A1A"
local QUEST_COLOR_ORANGE = "FFFF8040"
local QUEST_COLOR_YELLOW = "FFFFFF00"
local QUEST_COLOR_GREEN = "FF40C040"
local QUEST_COLOR_GREY = "FFC0C0C0"

Journeyman.BYTE_ORDER_MARK = "!JM1"
Journeyman.JOURNEY_AS_DATA = "data"
Journeyman.JOURNEY_AS_TEXT = "text"

Journeyman.STEP_TYPE_UNDEFINED = "UNDEFINED"
Journeyman.STEP_TYPE_ACCEPT_QUEST = "ACCEPT"
Journeyman.STEP_TYPE_COMPLETE_QUEST = "COMPLETE"
Journeyman.STEP_TYPE_TURNIN_QUEST = "TURNIN"
Journeyman.STEP_TYPE_GO_TO_COORD = "GOTO"
Journeyman.STEP_TYPE_GO_TO_AREA = "GOTOAREA"
Journeyman.STEP_TYPE_GO_TO_ZONE = "GOTOZONE"
Journeyman.STEP_TYPE_REACH_LEVEL = "LEVEL"
Journeyman.STEP_TYPE_REACH_REPUTATION = "REPUTATION"
Journeyman.STEP_TYPE_BIND_HEARTHSTONE = "BIND"
Journeyman.STEP_TYPE_USE_HEARTHSTONE = "HEARTH"
Journeyman.STEP_TYPE_LEARN_FLIGHT_PATH = "LEARNFP"
Journeyman.STEP_TYPE_FLY_TO = "FLYTO"
Journeyman.STEP_TYPE_TRAIN_CLASS = "TRAIN"
Journeyman.STEP_TYPE_TRAIN_SPELLS = "TRAINSPELL"
Journeyman.STEP_TYPE_LEARN_FIRST_AID = "LEARNFIRSTAID"
Journeyman.STEP_TYPE_LEARN_COOKING = "LEARNCOOKING"
Journeyman.STEP_TYPE_LEARN_FISHING = "LEARNFISHING"
Journeyman.STEP_TYPE_ACQUIRE_ITEMS = "ACQUIREITEM"
Journeyman.STEP_TYPE_DIE_AND_RES = "DIE"

Journeyman.STEP_STATE_NONE = 0
Journeyman.STEP_STATE_COMPLETED = 1
Journeyman.STEP_STATE_SKIPPED = 2

Journeyman.ITEM_HEARTHSTONE = 6948

Journeyman.NPC_STORMWIND_PORTAL_TRAINER = 2485
Journeyman.NPC_IRONFORGE_PORTAL_TRAINER = 2489
Journeyman.NPC_DARNASSUS_PORTAL_TRAINER = 4165
Journeyman.NPC_HORSE_RIDING_INSTRUCTOR = 4732
Journeyman.NPC_NIGHTSABER_RIDING_INSTRUCTOR = 4753
Journeyman.NPC_MECHANOSTRIDER_PILOT = 7954
Journeyman.NPC_RAM_RIDING_INSTRUCTOR = 4772

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
Journeyman.SPELL_HORSE_RIDING = 824
Journeyman.SPELL_RAM_RIDING = 826
Journeyman.SPELL_TIGER_RIDING = 828
Journeyman.SPELL_MECHANOSTRIDER_PILOTING = 10907

Journeyman.ICON_HUNTERS_MARK = 132212

Journeyman.FalseQuestItems = {
    737,   -- Holy Spring Water
    2799,  -- Gorilla Fang
    8564,  -- Hippogryph Egg
    11242, -- Evoroot
    12738, -- Dalson Outhouse Key
    12739, -- Dalson Cabinet Key
    12840, -- Minion's Scourgestone
    12841, -- Invader's Scourgestone
    12843, -- Corruptor's Scourgestone
    21377, -- Deadwood Headdress Feather
}

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
    if current.instanceId ~= previous.instanceId then
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

function Journeyman:OnInitialize()
    TaxiNodes = Journeyman.TaxiNodes

    self.factionNameLocalToFactionId = {}

    self.player = {}
    self.player.name = UnitName("player")

    local factionName, factionNameLocal = UnitFactionGroup("player")
    self.player.factionName = factionName
    self.player.factionNameLocal = factionNameLocal
    self.player.factionGained = {}

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

    self.Journey:Initialize()

    self:InitializeDatabase()
    self.Editor:Initialize()
    self:InitializeOptions()
    self.State:Initialize()
    self:InitializeHooks()
    self:InitializeEvents()
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
    self.activeJourney = nil
    self.activeJourneyChapter = nil
    self.loadJourneyDataTask = nil
    if self.db.char.window.show then
        self.State:Reset(immediate)
    end
end

function Journeyman:Update(immediate)
    self.State:Update(immediate)
end

function Journeyman:UpdatePosition()
    -- Get player location
    local location = nil
    local playerX, playerY, playerMapId = HBD:GetPlayerZonePosition()
    local instanceId = select(8, GetInstanceInfo())
    if instanceId and playerMapId and playerX and playerY then
        location = { instanceId = instanceId, mapId = playerMapId, x = playerX, y = playerY }
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
            info.objectives = Journeyman.State:GetQuestObjectives(info.questId)
            questLog[info.questId] = info
        end
    end
    return questLog
end

function Journeyman:GetQuestName(questId, showLevel, showId)
    local questName = Journeyman.DataSource:GetQuestName(questId, showLevel, showId)
    if not String:IsNilOrEmpty(questName) then
        return questName
    end
    return string.format("quest:%s", questId)
end

function Journeyman:GetQuestColor(questId)
    local questLevel = Journeyman.DataSource:GetQuestLevel(questId)
    if questLevel then
        local colorHex
        local levelDiff = questLevel - self.player.level
        if levelDiff >= 5 then
            return QUEST_COLOR_RED
        elseif levelDiff >= 3 then
            return QUEST_COLOR_ORANGE
        elseif levelDiff >= -2 then
            return QUEST_COLOR_YELLOW
        elseif -levelDiff <= Journeyman.player.greenRange then
            return QUEST_COLOR_GREEN
        else
            return QUEST_COLOR_GREY
        end
    end
    return "FFFFFFFF"
end

function Journeyman:GetItemName(itemId, callback)
    if itemId and type(itemId) == "number" then
        local itemName = GetItemInfo(itemId)
        if itemName == nil then
            if callback and type(callback) == "function" then
                local item = Item:CreateFromItemID(itemId)
                if not item:IsItemEmpty() then
                    item:ContinueOnItemLoad(callback)
                end
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
                if not item:IsItemEmpty() then
                    item:ContinueOnItemLoad(callback)
                end
            end
            return "item:"..itemId
        end
        return itemLink
    end
end

function Journeyman:GetItemCountInBags(itemId)
    if itemId and type(itemId) == "number" then
        local counter = 0
        for bag = BACKPACK_CONTAINER, NUM_BAG_SLOTS do
            for slot = 1, GetContainerNumSlots(bag) do
                local _, count, _, _, _, _, _, _, _, id = GetContainerItemInfo(bag, slot)
                if id == itemId then
                    counter = counter + count
                end
            end
        end
        return counter
    end
end

function Journeyman:IsItemQuestItem(itemId)
    if type(itemId) == "number" then
        -- Database correction: some items are falsely reported as quest items
        if List:Contains(self.FalseQuestItems, itemId) then
            return false
        end
        -- Check if this is a quest item
        local classId = select(6, GetItemInfoInstant(itemId))
        if classId then
            return classId == Enum.ItemClass.Questitem
        end
        return false
    end
end

function Journeyman:GetSpellName(spellId, callback)
    if spellId and type(spellId) == "number" then
        local spellName = GetSpellInfo(spellId)
        local spellSubText = GetSpellSubtext(spellId)
        if spellName == nil or spellSubText == nil then
            if callback and type(callback) == "function" then
                local spell = Spell:CreateFromSpellID(spellId)
                if not spell:IsSpellEmpty() then
                    spell:ContinueOnSpellLoad(callback)
                end
            end
            return "spell:"..spellId
        end
        if not String:IsNilOrEmpty(spellSubText) then
            spellName = string.format("%s (%s)", spellName, spellSubText)
        end
        return spellName
    end
end

function Journeyman:IsSpellKnown(spellId)
    return IsPlayerSpell(spellId) or IsSpellKnown(spellId) or IsSpellKnown(spellId, true)
end

function Journeyman:GetFactionName(factionId)
    if factionId and type(factionId) == "number" then
        if factionId > 0 then
            local factionName = GetFactionInfoByID(factionId)
            if not String:IsNilOrEmpty(factionName) then
                return factionName
            end
        end
        return "faction:"..factionId
    end
end

function Journeyman:GetFactionId(factionNameLocal)
    if self.factionNameLocalToFactionId[factionNameLocal] == nil then
        local n = GetNumFactions()
        for i = 1, n do
            local name, _, _, _, _, _, _, _, isHeader, _, hasRep, _, _, id = GetFactionInfo(i)
            if hasRep or not isHeader then
                name = String:Trim(name)
                if self.factionNameLocalToFactionId[name] == nil then
                    self.factionNameLocalToFactionId[name] = id
                end
            end
        end
    end
    return self.factionNameLocalToFactionId[factionNameLocal]
end

function Journeyman:GetStandingLabel(standingId)
    if standingId and type(standingId) == "number" then
        local standingLabel = getglobal("FACTION_STANDING_LABEL"..standingId)
        if not String:IsNilOrEmpty(standingLabel) then
            return standingLabel
        end
        return "standing:"..standingId
    end
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
        local playerPosition = C_Map.GetPlayerMapPosition(mapId, "player")
        local areaIds = C_MapExplorationInfo.GetExploredAreaIDsAtPosition(mapId, playerPosition)
        if areaIds == nil then
            local subZoneText = GetSubZoneText()
            if not String:IsNilOrEmpty(subZoneText) then
                areaIds = self:GetAreaIdsFromLocalizedName(subZoneText)
            end
            if areaIds == nil then
                local mapName = self:GetMapNameById(mapId)
                if not String:IsNilOrEmpty(mapName) then
                    areaIds = self:GetAreaIdsFromLocalizedName(self:GetMapNameById(mapId))
                end
            end
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

function Journeyman:GetJourney(journey)
    assert(type(journey) ~= "table")
    if self.journeys then
        if type(journey) == "number" then
            return self.journeys[journey]
        elseif type(journey) == "string" then
            return self:GetJourney(self:GetJourneyIndex(journey))
        end
    end
end

function Journeyman:GetJourneyIndex(journey)
    assert(type(journey) ~= "number")
    if self.journeys then
        if type(journey) == "table" then
            return List:FindIndex(self.journeys, function(j) return j == journey end)
        elseif type(journey) == "string" then
            return List:FindIndex(self.journeys, function(j) return j.guid == journey end)
        end
    end
end

function Journeyman:GetJourneyState(journey)
    if type(journey) == "table" then
        if self.db.char.state[journey.guid] == nil then
            self.db.char.state[journey.guid] = {}
        end
        return self.db.char.state[journey.guid]
    elseif type(journey) == "number" then
        return self:GetJourneyState(self:GetJourney(journey))
    elseif type(journey) == "string" then
        if self.db.char.state[journey] == nil then
            self.db.char.state[journey] = {}
        end
        return self.db.char.state[journey]
    end
end

function Journeyman:IsMyJourneyEnabled()
    if not self.db.char.myJourney.enabled then
        return false
    end
    if not self.db.profile.myJourney.atMaxLevel then
        local maxLevel
        if WOW_PROJECT_ID == WOW_PROJECT_CLASSIC then
            maxLevel = 60
        elseif WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC then
            maxLevel = 70
        elseif WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC then
            maxLevel = 80
        else
            Journeyman:Error("Unsupported WoW version (WOW_PROJECT_ID = %s)", WOW_PROJECT_ID)
        end
        if self.player.level >= maxLevel then
            return false
        end
    end
    return true
end

function Journeyman:GetMyJourney()
    if self.myJourney == nil then
        self.myJourney = Journeyman.Journey:CreateJourney(self.player.name.."'s Journey")
    end
    return self.myJourney
end

function Journeyman:GetActiveJourney()
    if self.activeJourney == nil then
        self.activeJourney = self:GetJourney(self.db.char.journey)
    end
    return self.activeJourney
end

function Journeyman:GetActiveJourneyState()
    return self:GetJourneyState(self:GetActiveJourney())
end

function Journeyman:ResetJourneyState(journey)
    if type(journey) == "table" then
        self.db.char.state[journey.guid] = nil
    elseif type(journey) == "number" then
        self:ResetJourneyState(self:GetJourney(journey))
    elseif type(journey) == "string" then
        self.db.char.state[journey] = nil
    end
end

function Journeyman:ResetActiveJourneyState()
    self:ResetActiveJourneyState(self:GetActiveJourney())
end

function Journeyman:GetJourneyChapter(journey, chapterIndex)
    assert(type(chapterIndex) == "number")
    if type(journey) ~= "table" then
        journey = self:GetJourney(journey)
    end
    if journey and journey.chapters and chapterIndex and chapterIndex > 0 and chapterIndex <= #journey.chapters then
        return journey.chapters[chapterIndex]
    end
end

function Journeyman:GetJourneyChapterIndex(journey, chapter)
    assert(type(chapter) == "table")
    if type(journey) ~= "table" then
        journey = self:GetJourney(journey)
    end
    if journey and journey.chapters then
        return List:IndexOf(journey.chapters, chapter)
    end
end

function Journeyman:GetJourneyChapterState(journey, chapter)
    if type(journey) ~= "table" then
        journey = self:GetJourney(journey)
    end
    if type(chapter) ~= "number" then
        chapter = self:GetJourneyChapterIndex(journey, chapter)
    end
    if journey and journey.chapters and chapter and chapter > 0 and chapter <= #journey.chapters then
        local state = self:GetJourneyState(journey)
        if state[chapter] == nil then
            state[chapter] = {}
        end
        return state[chapter]
    end
end

function Journeyman:GetActiveJourneyChapter()
    if self.activeJourneyChapter == nil then
        self.activeJourneyChapter = self:GetJourneyChapter(self:GetActiveJourney(), self.db.char.chapter)
    end
    return self.activeJourneyChapter
end

function Journeyman:GetActiveJourneyChapterState()
    return self:GetJourneyChapterState(self:GetActiveJourney(), self:GetActiveJourneyChapter())
end

function Journeyman:ResetJourneyChapterState(journey, chapter)
    if type(journey) ~= "table" then
        journey = self:GetJourney(journey)
    end
    if type(chapter) ~= "number" then
        chapter = self:GetJourneyChapterIndex(journey, chapter)
    end
    if journey and journey.chapters and chapter and chapter > 0 and chapter <= #journey.chapters then
        if self.db.char.state[journey.guid] then
            self.db.char.state[journey.guid][chapter] = nil
        end
    end
end

function Journeyman:ResetActiveJourneyChapterState()
    self:ResetJourneyChapterState(self:GetActiveJourney(), self:GetActiveJourneyChapter())
end

local function AddJourneyQuestObjectiveData(journey, questId, questData, objective, parentObjective)
    if objective.type == "NPC" or objective.type == "Vendor" then
        local npcId = objective.id
        local npcData = journey.npcs[npcId]
        if npcData == nil then
            npcData = { quests = {} }
            journey.npcs[npcId] = npcData
        end
        local quest = { id = questId, objectiveType = objective.type, objectiveIndex = objective.objectiveIndex }
        if parentObjective then
            if parentObjective.type == "NPC" or parentObjective.type == "Vendor" then
                quest.npcId = parentObjective.id
            elseif parentObjective.type == "Item" then
                quest.itemId = parentObjective.id
            end
        end
        List:Add(npcData.quests, quest)
        List:Add(questData.npcs, npcId)
    elseif objective.type == "Item" then
        local itemId = objective.id
        local classId = select(6, GetItemInfoInstant(itemId))
        if classId ~= Enum.ItemClass.Container then -- Hack: skip container items to avoid showing junk boxes
            local itemData = journey.items[itemId]
            if itemData == nil then
                itemData = { quests = {} }
                journey.items[itemId] = itemData
            end
            local quest = { id = questId, objectiveType = objective.type, objectiveIndex = objective.objectiveIndex }
            if parentObjective then
                if parentObjective.type == "NPC" or parentObjective.type == "Vendor" then
                    quest.npcId = parentObjective.id
                elseif parentObjective.type == "Item" then
                    quest.itemId = parentObjective.id
                end
            end
            List:Add(itemData.quests, quest)
            List:Add(questData.items, itemId)
        end
    end

    if objective.sources then
        List:ForEach(objective.sources, function(source)
            AddJourneyQuestObjectiveData(journey, questId, questData, source, objective)
        end)
    end
end

local function AddJourneyQuestData(journey, questId)
    local questData = journey.quests[questId]
    if questData == nil then
        questData = { npcs = {}, items = {} }
        journey.quests[questId] = questData

        local objectives = Journeyman.DataSource:GetQuestObjectives(questId)
        if objectives then
            List:ForEach(objectives, function(objective)
                AddJourneyQuestObjectiveData(journey, questId, questData, objective)
            end)
        end
    end
end

local function LoadJourneyData(journey, callback)
    if not Journeyman.worldLoaded or not Journeyman.DataSource:IsInitialized() then
        coroutine.yield()
    end

    journey.quests = {}
    journey.npcs = {}
    journey.items = {}

    -- Get quest and item data for entire journey
    List:ForEach(journey.chapters, function(chapter)
        List:ForEach(chapter.steps, function(step)
            -- Only consider 'complete quest' step type
            if step.type == Journeyman.STEP_TYPE_COMPLETE_QUEST then
                local data = Journeyman:GetStepData(step)
                if data and data.questId then
                    AddJourneyQuestData(journey, data.questId)
                end
            end
        end)
        coroutine.yield() -- Yield after every chapter
    end)

    -- Execute callback after loading is finished
    if callback and type(callback) == "function" then
        callback()
    end
end

function Journeyman:GetJourneyQuestData(journey, questId, callback)
    if not self.db.char.window.show then
        return nil
    end

    -- If data is loading, return nil
    if self.loadJourneyDataTask then
        return nil
    end

    -- Get journey
    if type(journey) ~= "table" then
        journey = self:GetJourney(journey)
    end
    if journey == nil then
        return nil
    end

    -- If data is not loaded, start task
    if journey.quests == nil then
        self.loadJourneyDataTask = coroutine.create(LoadJourneyData)
        coroutine.resume(self.loadJourneyDataTask, journey, callback)
        return nil
    end

    return journey.quests[questId]
end

function Journeyman:GetActiveJourneyQuestData(questId, callback)
    return self:GetJourneyQuestData(self:GetActiveJourney(), questId, callback)
end

function Journeyman:GetJourneyItemData(journey, itemId, callback)
    if not self.db.char.window.show then
        return nil
    end

    -- If data is loading, return nil
    if self.loadJourneyDataTask then
        return nil
    end

    -- Get journey
    if type(journey) ~= "table" then
        journey = self:GetJourney(journey)
    end
    if journey == nil then
        return nil
    end

    -- If data is not loaded, start task
    if journey.items == nil then
        self.loadJourneyDataTask = coroutine.create(LoadJourneyData)
        coroutine.resume(self.loadJourneyDataTask, journey, callback)
        return nil
    end

    return journey.items[itemId]
end

function Journeyman:GetActiveJourneyItemData(itemId, callback)
    return self:GetJourneyItemData(self:GetActiveJourney(), itemId, callback)
end

function Journeyman:GetJourneyNPCData(journey, npcId, callback)
    if not self.db.char.window.show then
        return nil
    end

    -- If data is loading, return nil
    if self.loadJourneyDataTask then
        return nil
    end

    -- Get journey
    if type(journey) ~= "table" then
        journey = self:GetJourney(journey)
    end
    if journey == nil then
        return nil
    end

    -- If data is not loaded, start task
    if journey.npcs == nil then
        self.loadJourneyDataTask = coroutine.create(LoadJourneyData)
        coroutine.resume(self.loadJourneyDataTask, journey, callback)
        return nil
    end

    return journey.npcs[npcId]
end

function Journeyman:GetActiveJourneyNPCData(npcId, callback)
    return self:GetJourneyNPCData(self:GetActiveJourney(), npcId, callback)
end

function Journeyman:IsStepComplete(step)
    -- Some step type never store completed state (so they can be reverted at any moment)
    if step.type == Journeyman.STEP_TYPE_COMPLETE_QUEST then
        return false
    end

    local state = self:GetActiveJourneyChapterState()[step.indexInChapter] or Journeyman.STEP_STATE_NONE
    return bit.band(state, Journeyman.STEP_STATE_COMPLETED) == Journeyman.STEP_STATE_COMPLETED
end

function Journeyman:IsStepSkipped(step)
    local state = self:GetActiveJourneyChapterState()[step.indexInChapter] or Journeyman.STEP_STATE_NONE
    return bit.band(state, Journeyman.STEP_STATE_SKIPPED) == Journeyman.STEP_STATE_SKIPPED
end

function Journeyman:SetStepState(step, state)
    if state == Journeyman.STEP_STATE_NONE then
        self:GetActiveJourneyChapterState()[step.indexInChapter] = nil
    else
        self:GetActiveJourneyChapterState()[step.indexInChapter] = state
    end
end

function Journeyman:ResetStepState(step)
    self:GetActiveJourneyChapterState()[step.indexInChapter] = nil
end

function Journeyman:SetStepStateCompleted(step, value)
    -- Do not store completed state for some step type (so they can be reverted at any moment)
    if step.type == Journeyman.STEP_TYPE_COMPLETE_QUEST then
        return
    end

    local state = self:GetActiveJourneyChapterState()[step.indexInChapter] or Journeyman.STEP_STATE_NONE
    if value == true then
        state = bit.bor(state, Journeyman.STEP_STATE_COMPLETED)
    elseif value == false then
        state = bit.band(state, bit.bnot(Journeyman.STEP_STATE_COMPLETED))
    end
    self:SetStepState(step, state)
end

function Journeyman:SetStepStateSkipped(step, value)
    local state = self:GetActiveJourneyChapterState()[step.indexInChapter] or Journeyman.STEP_STATE_NONE
    if value == true then
        state = bit.bor(state, Journeyman.STEP_STATE_SKIPPED)
    elseif value == false then
        state = bit.band(state, bit.bnot(Journeyman.STEP_STATE_SKIPPED))
    end
    self:SetStepState(step, state)
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
    if step.type == Journeyman.STEP_TYPE_UNDEFINED or step.data == nil then
        return nil
    end

    local data
    if type(step.data) == "table" then
        return step.data
    elseif type(step.data) == "string" then
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
                if xp and xp >= 1 then
                    data.xp = xp
                end
            end
        elseif step.type == Journeyman.STEP_TYPE_REACH_REPUTATION then
            local values = String:Split(step.data, ",")
            local factionId = tonumber(values[1])
            local standingId = tonumber(values[2])
            if factionId and standingId then
                data = { factionId = factionId, standingId = standingId }
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
        elseif step.type == Journeyman.STEP_TYPE_ACQUIRE_ITEMS then
            local values = String:Split(step.data, ",")
            local items = {}
            if math.fmod(#values, 2) == 0 then
                for i = 1, #values, 2 do
                    local id = tonumber(values[i])
                    local count = math.max(tonumber(values[i + 1]), 1)
                    if id and count and GetItemInfoInstant(id) ~= nil then
                        List:Add(items, { id = id, count = count })
                    end
                end
            end
            if #items > 0 then
                data = { items = items }
            end
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
        local questName = self:GetQuestName(questId, showQuestLevel, showId)
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
            text = string.format("%s + %s xp", text, data.xp)
        end
        return text

    elseif step.type == Journeyman.STEP_TYPE_REACH_REPUTATION then
        local factionId = data and data.factionId or 0
        local factionName = self:GetFactionName(factionId)
        local standingId = data and data.standingId or 0
        local standingLabel = self:GetStandingLabel(standingId)
        return string.format(L["STEP_TEXT_REACH_REPUTATION"], standingLabel, factionName)

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
        local taxiNodeName = TaxiNodes:GetLocalizedName(taxiNodeId, showId)
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

    elseif step.type == Journeyman.STEP_TYPE_ACQUIRE_ITEMS then
        local items = ""
        if data and data.items then
            local itemNames = {}
            List:ForEach(data.items, function(item)
                List:Add(itemNames, self:GetItemLink(item.id, callback).."x"..item.count)
            end)
            items = String:Join(", ", itemNames)
        end
        return string.format(L["STEP_TEXT_ACQUIRE_ITEMS"], items)

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
        if location.type == "NPC" then
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

local function GetNPCNamesRecurse(objectives)
    local result = {}
    List:ForEach(objectives, function(objective)
        if not objective.isComplete then
            if objective.type == "NPC" then
                List:Add(result, objective.name)
            end
            if objective.sources then
                List:AddRange(result, GetNPCNamesRecurse(objective.sources))
            end
        end
    end)
    return result
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
    local suffix = "/cleartarget [noexists][dead]\n/tm [exists] 8\n"
    if step then
        if step.type == Journeyman.STEP_TYPE_ACCEPT_QUEST then
            local location = self.DataSource:GetNearestQuestStarter(step.data.questId)
            if location and not String:IsNilOrEmpty(location.name) then
                local command = string.format("/tar [noexists][dead] %s\n", location.name)
                if body:len() + command:len() + suffix:len() <= 255 then
                    body = body..command
                end
            end
        elseif step.type == Journeyman.STEP_TYPE_COMPLETE_QUEST then
            local objectives = self.DataSource:GetQuestObjectives(step.data.questId, step.data.objectives)
            if objectives then
                local names = GetNPCNamesRecurse(objectives)
                local n = #names
                for i = 1, n do
                    local name = names[i]
                    if name and not String:IsNilOrEmpty(name) then
                        local command = string.format("/tar [noexists][dead] %s\n", name)
                        if body:len() + command:len() + suffix:len() <= 255 then
                            body = body..command
                        else
                            break
                        end
                    end
                end
            end
        elseif step.type == Journeyman.STEP_TYPE_TURNIN_QUEST then
            local location = self.DataSource:GetNearestQuestFinisher(step.data.questId)
            if location and not String:IsNilOrEmpty(location.name) then
                local command = string.format("/tar [noexists][dead] %s\n", location.name)
                if body:len() + command:len() + suffix:len() <= 255 then
                    body = body..command
                end
            end
        elseif step.type == Journeyman.STEP_TYPE_ACQUIRE_ITEMS then
            local items = {}
            local hasAll = List:All(step.data.items, function(item) return Journeyman:GetItemCountInBags(item.id) >= item.count end)
            local items = List:Select(step.data.items, function(item)
                if hasAll or Journeyman:GetItemCountInBags(item.id) < item.count then
                    return item.id
                end
            end)
            local location = Journeyman.DataSource:GetNearestItemLocation(items)
            if location and not String:IsNilOrEmpty(location.name) then
                local command = string.format("/tar [noexists][dead] %s\n", location.name)
                if body:len() + command:len() + suffix:len() <= 255 then
                    body = body..command
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
