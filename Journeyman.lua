local addonName, addon = ...
addon.Journeyman = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceHook-3.0", "AceEvent-3.0", "AceConsole-3.0")
addon.Locale = LibStub("AceLocale-3.0"):GetLocale(addonName)

local Journeyman = addon.Journeyman
local L = addon.Locale
local HBD = LibStub("HereBeDragons-2.0")

Journeyman.BYTE_ORDER_MARK = "!JM1"
Journeyman.STEP_TYPE_UNDEFINED = "UNDEFINED"
Journeyman.STEP_TYPE_ACCEPT_QUEST = "ACCEPT"
Journeyman.STEP_TYPE_COMPLETE_QUEST = "COMPLETE"
Journeyman.STEP_TYPE_TURNIN_QUEST = "TURNIN"
Journeyman.STEP_TYPE_GO_TO = "GOTO"
Journeyman.STEP_TYPE_REACH_LEVEL = "LEVEL"
Journeyman.STEP_TYPE_BIND_HEARTHSTONE = "BIND"
Journeyman.STEP_TYPE_USE_HEARTHSTONE = "HEARTH"
Journeyman.STEP_TYPE_LEARN_FLIGHT_PATH = "LEARNFP"
Journeyman.STEP_TYPE_FLY_TO = "FLYTO"
Journeyman.STEP_TYPE_TRAIN_CLASS = "TRAIN"
Journeyman.ITEM_HEARTHSTONE = 6948
Journeyman.SPELL_HEARTHSTONE = 8690
Journeyman.SPELL_ASTRAL_RECALL = 556
Journeyman.ICON_HUNTERS_MARK = 132212

local tinsert = table.insert

local function Equals(a, b, epsilon)
    local diff = math.abs(a - b)
    return diff <= epsilon
end

-- Some taxi nodes were never implemented in game, or are innacessible, or don't need to be considered (e.g. battlegrounds)
local taxiNodeIdsToSkip = {1, 3, 9, 15, 24, 34, 35, 36, 46, 47, 50, 51, 54, 57, 59, 60, 78, 84, 85, 86, 87}
local skipTaxiNodeIds = {}
for i = 1, #taxiNodeIdsToSkip do
    skipTaxiNodeIds[taxiNodeIdsToSkip[i]] = true
end

function Journeyman:OnInitialize()
    self.waypointNeedUpdate = false
    self.macroNeedUpdate = false

    self.player = {}

    local factionName, factionNameLocal = UnitFactionGroup("player")
    self.player.factionName = factionName
    self.player.factionNameLocal = factionNameLocal

    local raceNameLocal, raceName, raceId = UnitRace("player")
    self.player.raceName = raceName
    self.player.raceNameLocal = raceNameLocal
    self.player.raceId = raceId

    local classNameLocal, className, classId = UnitClass("player")
    self.player.className = className
    self.player.classNameLocal = classNameLocal
    self.player.classId = classId

    self.player.level = UnitLevel("player")
    self.player.xp = UnitXP("player")
    self.player.maxXP = UnitXPMax("player")
    self.player.greenRange = GetQuestGreenRange("player")
    self.player.onTaxi = UnitOnTaxi("player")
    self.player.location = nil
    self.player.lastLocation = nil

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
        -- Store some values
        self.player.level = UnitLevel("player")
        self.player.xp = UnitXP("player")
        self.player.maxXP = UnitXPMax("player")
        self.player.greenRange = GetQuestGreenRange("player")

        -- Check for state and window update
        self.State:CheckForUpdate()
        self.Window:CheckForUpdate()

        -- Check for waypoint and macro update
        if not self.State.needUpdate then
            local step = self.State:GetCurrentStep()

            -- Check for waypoint update
            if self.waypointNeedUpdate and self.player.location and not self.player.onTaxi then
                if self.db.profile.autoSetWaypoint then
                    self:SetWaypoint(step, false)
                end
                self.waypointNeedUpdate = false
            end

            -- Check for macro update
            if self.macroNeedUpdate then
                self:SetMacro(step)
            end
        end
    end)

    -- High frequency ticker for goto steps
    C_Timer.NewTicker(0.25, function()
        if not Journeyman.db.char.window.show or Journeyman.State.steps == nil then
            return
        end

        local now = GetTimePreciseSec()

        -- Store player is on taxi
        self.player.onTaxi = UnitOnTaxi("player")

        -- If player is on taxi, do not track location
        if self.player.onTaxi then
            self.player.location = nil
            self.player.lastLocation = nil
            return
        end

        -- Get player location
        local playerX, playerY, playerMapId = HBD:GetPlayerZonePosition()
        if playerMapId and playerX and playerY then
            self.player.location = { mapId = playerMapId, x = playerX, y = playerY }
        else
            -- Could not get location, bail
            self.player.location = nil
            self.player.lastLocation = nil
            return
        end

        -- Check if we have last location, otherwise store and bail
        if self.player.lastLocation == nil then
            self.player.lastLocation = { mapId = playerMapId, x = playerX, y = playerY }
            return
        end

        -- Check if location changed for at least second decimal point
        if playerMapId == self.player.lastLocation.mapId and Equals(playerX, self.player.lastLocation.x, 0.0001) and Equals(playerY, self.player.lastLocation.y, 0.0001) then
            return
        end

        -- Compare all incomplete goto step that matches the mapId
        for i = 1, #Journeyman.State.steps do
            local step = Journeyman.State.steps[i]
            if step and step.type == Journeyman.STEP_TYPE_GO_TO and not step.isComplete then
                if step.data.mapId == playerMapId then
                    local distance = HBD:GetZoneDistance(playerMapId, playerX, playerY, step.data.mapId, step.data.x / 100.0, step.data.y / 100.0)
                    if distance and distance <= 15 then
                        self:OnLocationReached(step.data)
                    end
                end
            end
        end

        -- Store last location
        self.player.lastLocation = { mapId = playerMapId, x = playerX, y = playerY }

        local elapsed = (GetTimePreciseSec() - now) * 1000
        if elapsed > 1 then
            Journeyman:Debug("Goto ticker took %.2fms", elapsed)
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
        self:UpdateWaypoint()
        self:UpdateMacro()
        self.State:Reset(immediate)
    end
end

function Journeyman:Update(immediate)
    if self.db.char.window.show then
        self:UpdateWaypoint()
        self:UpdateMacro()
        self.State:Update(immediate)
    end
end

function Journeyman:UpdateWaypoint()
    self.waypointNeedUpdate = true
end

function Journeyman:UpdateMacro()
    self.macroNeedUpdate = true
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
            return "item:" .. itemId
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
            return "item:" .. itemId
        end
        return itemLink
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

function Journeyman:GetAreaIdFromBindLocationLocalizedName(name)
    if self.bindLocationNameToAreaId == nil then
        self.bindLocationNameToAreaId = {}
        local innkeeperZones = self.DataSource:GetAllInnkeeperZones()
        if innkeeperZones then
            for k, v in pairs(L.areaTable) do
                if innkeeperZones[k] or innkeeperZones[v.ParentAreaID] then
                    if self.bindLocationNameToAreaId[v.AreaName_lang] == nil then
                        self.bindLocationNameToAreaId[v.AreaName_lang] = k
                    else
                        --Journeyman:Debug("bindLocationNameToAreaId table already contains key pair ('%s', %d), when trying to add ('%s', %d)", v.AreaName_lang, self.bindLocationNameToAreaId[v.AreaName_lang], v.AreaName_lang, k)
                    end
                end
            end
        end
    end
    return self.bindLocationNameToAreaId[name]
end

function Journeyman:GetAreaName(areaId, showId)
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
            return { [1] = info.Pos[2], [2] = info.Pos[1] }
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

function Journeyman:IsStepUnique(step)
    return self:IsStepTypeQuest(step) or step.type == Journeyman.STEP_TYPE_REACH_LEVEL
end

function Journeyman:GetStepData(step)
    if step.type == Journeyman.STEP_TYPE_UNDEFINED then
        return nil
    end

    local data
    if step.data and type(step.data) == "string" then
        if self:IsStepTypeQuest(step) then
            local values = self.Utils:Split(step.data, ",")
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
        elseif step.type == Journeyman.STEP_TYPE_GO_TO then
            local values = self.Utils:Split(step.data, ",")
            local mapId = tonumber(values[1])
            local mapName = Journeyman:GetMapNameById(mapId)
            local x = tonumber(values[2])
            local y = tonumber(values[3])
            local desc = values[4]
            if mapId and mapName and x and y then
                if desc == nil or desc:len() == 0 then
                     desc = x..","..y
                end
                data = { mapId = mapId, mapName = mapName, x = x, y = y, desc = desc }
            end
        elseif step.type == Journeyman.STEP_TYPE_REACH_LEVEL then
            local values = self.Utils:Split(step.data, ",")
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

    elseif step.type == Journeyman.STEP_TYPE_GO_TO then
        local mapId = data and data.mapId or 0
        local mapName = Journeyman:GetMapNameById(mapId, showId)
        if mapName == nil then
            mapName = string.format("map:%d", mapId)
        end

        local desc = data and data.desc or nil
        if desc == nil then
            local x = data and data.x or 0
            local y = data and data.y or 0
            desc = x..","..y
        end

        return string.format(L["STEP_TEXT_GO_TO"], desc, mapName)

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
        local areaName = self:GetAreaName(areaId, showId)
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
        return string.format(L["STEP_TEXT_TRAIN_CLASS"])

    else
        Journeyman:Error("Step type %s not implemented.", step.type)
    end
end

function Journeyman:SetWaypoint(step, force)
    if step == nil or TomTom == nil or TomTom.AddWaypoint == nil or TomTom.RemoveWaypoint == nil then
        return
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
        return
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

    -- Add waypoint if greater or equal to minimum distance
    if force or location.distance >= minDistance then
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
end

function Journeyman:SetMacro(step)
    if InCombatLockdown() then
        return
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
        return
    end

    -- Update macro body
    local body = "/cleartarget [noexists][dead][help]\n/tm [exists] 8\n"
    if step and step.type == self.STEP_TYPE_COMPLETE_QUEST then
        -- Get quest objectives
        local objectives = self.DataSource:GetQuestObjectives(step.data.questId)
        if objectives then
            -- Get NPC objective names
            local names = {}
            for i, objective in ipairs(objectives or {}) do
                if objective and objective.type == "NPC" and not objective.isComplete then
                    tinsert(names, objective.name)
                end
            end

            if #names == 0 then
                -- Wipe macro body, nothing to do
                body = ""
            else
                -- Append NPC names to macro
                for i, name in ipairs(names) do
                    local target = string.format("/tar [noexists][dead][help] %s\n", name)
                    if string.len(body) + string.len(target) <= 255 then
                        body = target..body
                    else
                        break
                    end
                end
            end
        end
    end

    -- Update macro
    if body ~= macroBody then
        EditMacro(macroId, addonName, macroIcon, body)
    end

    self.macroNeedUpdate = false
end

function Journeyman:ReplaceAllItemStringToHyperlinks(input, callback)
    if input and type(input) == "string" then
        local result = input
        local itemString, itemId
        for itemString, itemId in input:gmatch("(item:(%d+))") do
            local itemLink = Journeyman:GetItemLink(tonumber(itemId), callback)
            if itemLink and itemLink ~= itemString then
                result = result:gsub(itemString, itemLink)
            else
                break
            end
        end
        return result
    end
end
