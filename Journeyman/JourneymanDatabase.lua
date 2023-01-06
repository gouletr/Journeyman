local addonName, addon = ...
local Database, Private = addon:NewModule("Database"), {}
local L = addon.Locale

local String = LibStub("LibCollections-1.0").String
local List = LibStub("LibCollections-1.0").List
local Dictionary = LibStub("LibCollections-1.0").Dictionary
local LibAceSerializer = LibStub:GetLibrary("AceSerializer-3.0")
local LibDeflate = LibStub:GetLibrary("LibDeflate")
local Utils, Journeys

local databaseDefaults = {
    profile = {
        window = {
            locked = false,
            clamped = true,
            showScrollBar = false,
            showQuestLevel = true,
            showCompletedSteps = false,
            showSkippedSteps = true,
            stepsShown = 5,
            autoScroll = true,
            backgroundColor = {
                r = 0,
                g = 0,
                b = 0,
                a = 0.5
            },
            width = 300,
            height = 300,
            relativePoint = "CENTER",
            x = 0,
            y = 0,
            fontSize = 12,
            lineSpacing = 2,
            indentSize = 0,
            stepSpacing = 8,
            strata = "BACKGROUND",
            level = 0
        },
        myJourney = {
            atMaxLevel = false,
            abandonedQuests = true,
            stepTypeAcceptQuest = true,
            stepTypeCompleteQuest = true,
            stepTypeTurnInQuest = true,
            stepTypeGoToZone = true,
            stepTypeReachLevel = true,
            stepTypeBindHearthstone = true,
            stepTypeUseHearthstone = true,
            stepTypeLearnFlightPath = true,
            stepTypeFlyTo = true,
            stepTypeTrainClass = false,
            stepTypeTrainSpells = true,
            stepTypeDieAndRes = true
        },
        autoSetWaypoint = true,
        autoSetWaypointMin = 15,
        advanced = {
            debug = false,
            updateFrequency = 1.0
        }
    },
    char = {
        window = {
            show = true
        },
        myJourney = {
            enabled = true
        },
        journey = "",
        chapter = 1,
        state = {},
        hardcoreMode = false,
        taxiNodeIds = {}
    }
}

function Database:OnInitialize()
    Utils = addon.Utils
    Journeys = addon.Journeys

    -- Create database
    addon.db = LibStub("AceDB-3.0"):New(addonName.."Database", databaseDefaults, true)
    if addon.db.profile.advanced.debug then
        _G["Journeyman"] = addon
    end
end

function Database:OnEnable()
    -- Initialize known taxi node ids per race
    if WOW_PROJECT_ID == WOW_PROJECT_CLASSIC then
        if addon.player.raceName == "HUMAN" then
            addon.db.char.taxiNodeIds[2] = true -- Stormwind, Elwynn
        elseif addon.player.raceName == "ORC" or addon.player.raceName == "TROLL" then
            addon.db.char.taxiNodeIds[23] = true -- Orgrimmar, Durotar
        elseif addon.player.raceName == "DWARF" or addon.player.raceName == "GNOME" then
            addon.db.char.taxiNodeIds[6] = true -- Ironforge, Dun Morogh
        elseif addon.player.raceName == "NIGHTELF" then
            addon.db.char.taxiNodeIds[26] = true -- Auberdine, Darkshore
            addon.db.char.taxiNodeIds[27] = true -- Rut'theran Village, Teldrassil
        elseif addon.player.raceName == "SCOURGE" then
            addon.db.char.taxiNodeIds[11] = true -- Undercity, Tirisfal
        elseif addon.player.raceName == "TAUREN" then
            addon.db.char.taxiNodeIds[22] = true -- Thunder Bluff, Mulgore
        end
    elseif WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC then
        if addon.player.raceName == "HUMAN" then
            addon.db.char.taxiNodeIds[2] = true -- Stormwind, Elwynn
        elseif addon.player.raceName == "ORC" or addon.player.raceName == "TROLL" then
            addon.db.char.taxiNodeIds[23] = true -- Orgrimmar, Durotar
        elseif addon.player.raceName == "DWARF" or addon.player.raceName == "GNOME" then
            addon.db.char.taxiNodeIds[6] = true -- Ironforge, Dun Morogh
        elseif addon.player.raceName == "NIGHTELF" then
            addon.db.char.taxiNodeIds[26] = true -- Auberdine, Darkshore
            addon.db.char.taxiNodeIds[27] = true -- Rut'theran Village, Teldrassil
        elseif addon.player.raceName == "SCOURGE" then
            addon.db.char.taxiNodeIds[11] = true -- Undercity, Tirisfal
        elseif addon.player.raceName == "TAUREN" then
            addon.db.char.taxiNodeIds[22] = true -- Thunder Bluff, Mulgore
        elseif addon.player.raceName == "BLOODELF" then
            addon.db.char.taxiNodeIds[82] = true -- Silvermoon City
        elseif addon.player.raceName == "DRAENEI" then
            addon.db.char.taxiNodeIds[94] = true -- The Exodar
        end
    elseif WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC then
        if addon.player.raceName == "HUMAN" then
            addon.db.char.taxiNodeIds[2] = true -- Stormwind, Elwynn
        elseif addon.player.raceName == "ORC" or addon.player.raceName == "TROLL" then
            addon.db.char.taxiNodeIds[23] = true -- Orgrimmar, Durotar
        elseif addon.player.raceName == "DWARF" or addon.player.raceName == "GNOME" then
            addon.db.char.taxiNodeIds[6] = true -- Ironforge, Dun Morogh
        elseif addon.player.raceName == "NIGHTELF" then
            addon.db.char.taxiNodeIds[26] = true -- Auberdine, Darkshore
            addon.db.char.taxiNodeIds[27] = true -- Rut'theran Village, Teldrassil
        elseif addon.player.raceName == "SCOURGE" then
            addon.db.char.taxiNodeIds[11] = true -- Undercity, Tirisfal
        elseif addon.player.raceName == "TAUREN" then
            addon.db.char.taxiNodeIds[22] = true -- Thunder Bluff, Mulgore
        elseif addon.player.raceName == "BLOODELF" then
            addon.db.char.taxiNodeIds[82] = true -- Silvermoon City
        elseif addon.player.raceName == "DRAENEI" then
            addon.db.char.taxiNodeIds[94] = true -- The Exodar
        end
    else
        addon:Error("Unsupported WoW version (WOW_PROJECT_ID = %s)", WOW_PROJECT_ID)
    end

    -- Deserialize database
    self:DeserializeDatabase()
end

function Database:OnDisable()
end

function Database:SerializeDatabase()
    -- Serialize journeys
    if addon.journeys and type(addon.journeys) == "table" then
        addon.db.global.journeys = {}
        for i = 1, #addon.journeys do
            local journey = addon.journeys[i]
            if journey then
                local serialized = self:ExportJourney(journey)
                if serialized then
                    List:Add(addon.db.global.journeys, serialized)
                end
            end
        end
    end

    -- Serialize character journey
    if addon.myJourney and type(addon.myJourney) == "table" then
        local myJourney = self:ExportJourney(addon.myJourney)
        if myJourney then
            addon.db.char.myJourney.journey = myJourney
        end
    end
end

function Database:DeserializeDatabase()
    -- Deserialize journeys
    if addon.db.global.journeys and type(addon.db.global.journeys) == "table" then
        -- Migrate from profile db
        if addon.db.profile.journeys and type(addon.db.profile.journeys) == "table" then
            List:ForEach(addon.db.profile.journeys, function(journey)
                List:Add(addon.db.global.journeys, journey)
            end)
            addon.db.profile.journeys = nil
        end

        -- Import journeys
        addon.journeys = {}
        List:ForEach(addon.db.global.journeys, function(journey)
            local deserialized = self:ImportJourney(journey)
            if deserialized then
                -- Make sure title is unique
                if List:Any(addon.journeys, function(j) return j.title == deserialized.title end) then
                    local title = deserialized.title
                    local count = 1
                    while List:Count(addon.journeys, function(j) return j.title == title.." ("..count..")" end) > 0 do
                        count = count + 1
                    end
                    deserialized.title = title.." ("..count..")"
                end
                -- Make sure guid is unique
                if List:Any(addon.journeys, function(j) return j.guid == deserialized.guid end) then
                    deserialized.guid = Utils:CreateGUID()
                end
                -- Add journey
                List:Add(addon.journeys, deserialized)
            end
        end)

        -- Import character journey
        local myJourney = self:ImportJourney(addon.db.char.myJourney.journey)
        if myJourney then
            addon.myJourney = myJourney
        end
    end

    -- Validate active chapter
    local journey = addon:GetActiveJourney()
    if journey then
        if #journey.chapters <= 0 then
            addon.db.char.chapter = -1
        elseif addon.db.char.chapter <= 0 or addon.db.char.chapter > #journey.chapters then
            addon.db.char.chapter = 1
        end
    end

    -- Cleanup states
    local guids = {}
    Dictionary:ForEach(addon.db.char.state, function(guid, state) List:Add(guids, guid) end)
    List:ForEach(guids, function(guid)
        if addon:GetJourney(guid) == nil or (addon.db.char.state[guid] and Dictionary:Count(addon.db.char.state[guid]) == 0) then
            addon.db.char.state[guid] = nil
        end
    end)
end

function Database:ExportJourney(deserializedJourney)
    local journey = { chapters = {} }

    if deserializedJourney.guid and type(deserializedJourney.guid) == "string" then
        journey.guid = deserializedJourney.guid
    else
        journey.guid = Utils:CreateGUID()
    end

    if deserializedJourney.title and type(deserializedJourney.title) == "string" then
        journey.title = deserializedJourney.title
    else
        journey.title = L["NEW_JOURNEY_TITLE"]
    end

    if deserializedJourney.chapters and type(deserializedJourney.chapters) == "table" then
        for chapterIndex = 1, #deserializedJourney.chapters do
            local deserializedChapter = deserializedJourney.chapters[chapterIndex]

            local chapter = { steps = {} }

            if deserializedChapter.title and type(deserializedChapter.title) == "string" then
                chapter.title = deserializedChapter.title
            else
                chapter.title = L["NEW_CHAPTER_TITLE"]
            end

            if deserializedChapter.steps and type(deserializedChapter.steps) == "table" then
                for stepIndex = 1, #deserializedChapter.steps do
                    local deserializedStep = deserializedChapter.steps[stepIndex]

                    local step = {}

                    if deserializedStep.type and type(deserializedStep.type) == "string" then
                        step.type = deserializedStep.type
                    else
                        step.type = addon.STEP_TYPE_UNDEFINED
                    end

                    if deserializedStep.data and type(deserializedStep.data) == "number" then
                        step.data = tostring(deserializedStep.data)
                    elseif deserializedStep.data and type(deserializedStep.data) == "string" then
                        step.data = deserializedStep.data
                    else
                        step.data = ""
                    end

                    if deserializedStep.requiredRaces and type(deserializedStep.requiredRaces) == "number" then
                        step.requiredRaces = deserializedStep.requiredRaces
                    end

                    if deserializedStep.requiredClasses and type(deserializedStep.requiredClasses) == "number" then
                        step.requiredClasses = deserializedStep.requiredClasses
                    end

                    if deserializedStep.note and type(deserializedStep.note) == "string" then
                        step.note = deserializedStep.note
                    end

                    List:Add(chapter.steps, step)
                end
            end

            List:Add(journey.chapters, chapter)
        end
    end

    local result, serializedJourney = self:Serialize(journey)
    if not result then
        return nil, serializedJourney
    end

    return serializedJourney
end

local function ExportCommand(type)
    if type == addon.STEP_TYPE_UNDEFINED then
        return "undefined"
    elseif type == addon.STEP_TYPE_ACCEPT_QUEST then
        return "accept"
    elseif type == addon.STEP_TYPE_COMPLETE_QUEST then
        return "complete"
    elseif type == addon.STEP_TYPE_TURNIN_QUEST then
        return "turnin"
    elseif type == addon.STEP_TYPE_GO_TO_COORD then
        return "goto"
    elseif type == addon.STEP_TYPE_GO_TO_AREA then
        return "gotoarea"
    elseif type == addon.STEP_TYPE_GO_TO_ZONE then
        return "gotozone"
    elseif type == addon.STEP_TYPE_REACH_LEVEL then
        return "level"
    elseif type == addon.STEP_TYPE_REACH_REPUTATION then
        return "reputation"
    elseif type == addon.STEP_TYPE_BIND_HEARTHSTONE then
        return "bind"
    elseif type == addon.STEP_TYPE_USE_HEARTHSTONE then
        return "hearth"
    elseif type == addon.STEP_TYPE_LEARN_FLIGHT_PATH then
        return "learnfp"
    elseif type == addon.STEP_TYPE_FLY_TO then
        return "flyto"
    elseif type == addon.STEP_TYPE_TRAIN_CLASS then
        return "trainclass"
    elseif type == addon.STEP_TYPE_TRAIN_SPELLS then
        return "trainspells"
    elseif type == addon.STEP_TYPE_LEARN_FIRST_AID then
        return "learnfirstaid"
    elseif type == addon.STEP_TYPE_LEARN_COOKING then
        return "learncooking"
    elseif type == addon.STEP_TYPE_LEARN_FISHING then
        return "learnfishing"
    elseif type == addon.STEP_TYPE_ACQUIRE_ITEMS then
        return "getitems"
    elseif type == addon.STEP_TYPE_DIE_AND_RES then
        return "die"
    else
        addon:Error("Step type %s not implemented.", type)
    end
end

function Database:ImportJourney(serializedJourney)
    local result, deserializedJourney = self:Deserialize(serializedJourney)
    if not result then
        return nil, deserializedJourney
    end

    local journey = { chapters = {} }

    if deserializedJourney.guid and type(deserializedJourney.guid) == "string" then
        journey.guid = deserializedJourney.guid
    else
        journey.guid = Utils:CreateGUID()
    end

    if deserializedJourney.title and type(deserializedJourney.title) == "string" then
        journey.title = deserializedJourney.title
    else
        journey.title = L["NEW_JOURNEY_TITLE"]
    end

    if deserializedJourney.chapters and type(deserializedJourney.chapters) == "table" then
        for chapterIndex = 1, #deserializedJourney.chapters do
            local deserializedChapter = deserializedJourney.chapters[chapterIndex]

            local chapter = { journey = journey, steps = {} }

            if deserializedChapter.title and type(deserializedChapter.title) == "string" then
                chapter.title = deserializedChapter.title
            else
                chapter.title = L["NEW_CHAPTER_TITLE"]
            end

            if deserializedChapter.steps and type(deserializedChapter.steps) == "table" then
                for stepIndex = 1, #deserializedChapter.steps do
                    local deserializedStep = deserializedChapter.steps[stepIndex]

                    local step = {}

                    if deserializedStep.type and type(deserializedStep.type) == "string" then
                        step.type = deserializedStep.type
                    else
                        step.type = addon.STEP_TYPE_UNDEFINED
                    end

                    if deserializedStep.data and type(deserializedStep.data) == "number" then
                        step.data = tostring(deserializedStep.data)
                    elseif deserializedStep.data and type(deserializedStep.data) == "string" then
                        step.data = deserializedStep.data
                    else
                        step.data = ""
                    end

                    if deserializedStep.requiredRaces and type(deserializedStep.requiredRaces) == "number" then
                        step.requiredRaces = deserializedStep.requiredRaces
                    end

                    if deserializedStep.requiredClasses and type(deserializedStep.requiredClasses) == "number" then
                        step.requiredClasses = deserializedStep.requiredClasses
                    end

                    if deserializedStep.note and type(deserializedStep.note) == "string" then
                        step.note = deserializedStep.note
                    end

                    List:Add(chapter.steps, step)
                end
            end

            List:Add(journey.chapters, chapter)
        end
    end

    return journey
end

function Database:Serialize(...)
    local serialized = LibAceSerializer:Serialize(...)
    if serialized == nil then
        return false, "Failed to serialize."
    end

    local compressed = LibDeflate:CompressDeflate(serialized)
    if compressed == nil then
        return false, "Failed to compress."
    end

    local encoded = LibDeflate:EncodeForPrint(compressed)
    if encoded == nil then
        return false, "Failed to encode."
    end

    return true, encoded
end

function Database:Deserialize(str)
    if String:IsNilOrEmpty(str) then
        return false, "Expected string, got nil or empty string."
    end

    local decoded = LibDeflate:DecodeForPrint(str)
    if decoded == nil then
        return false, "Failed to decode."
    end

    local decompressed, extraBytes = LibDeflate:DecompressDeflate(decoded)
    if decompressed == nil or extraBytes > 0 then
        return false, string.format("Failed to decompress (%d extra bytes).", extraBytes)
    end

    local result, deserialized = LibAceSerializer:Deserialize(decompressed)
    if result == false then
        return false, "Failed to deserialize."
    end

    return true, deserialized
end

local function ExportData(data)
    if type(data) == "table" then
        local items = {}
        Dictionary:ForEach(data, function(key, value)
            if type(value) ~= "table" then
                List:Add(items, tostring(key).."="..ExportData(value))
            end
        end)
        return String:Join(" ", items)
    elseif type(data) == "string" then
        local number = tonumber(data)
        if number then
            return ExportData(number)
        else
            if String:Contains(data, " ") then
                return "\""..data.."\""
            else
                return data
            end
        end
    elseif type(data) == "number" then
        if math.floor(data) == data then
            return tostring(data) -- integer
        else
            return string.format("%.2f", data) -- decimal
        end
    else
        addon:Error("Export type %s not implemented", type(data))
    end
end

local function ExportRaces(races)
    if races then
        local requiredRaces = {}
        Dictionary:ForEach(addon.raceMask, function(raceId, raceMask)
            if bit.band(races, raceMask) == raceMask then
                List:Add(requiredRaces, addon.raceName[raceMask])
            end
        end)
        if #requiredRaces > 0 then
            return "requiredRaces="..String:Join(",", requiredRaces)
        end
    end
end

local function ExportClasses(classes)
    if classes then
        local requiredClasses = {}
        Dictionary:ForEach(addon.classMask, function(classId, classMask)
            if bit.band(classes, classMask) == classMask then
                List:Add(requiredClasses, addon.className[classMask])
            end
        end)
        if #requiredClasses > 0 then
            return "requiredClasses="..String:Join(",", requiredClasses)
        end
    end
end

local function ExportNote(note)
    if note then
        return "note=\""..note.."\""
    end
end

function Database:ExportJourneyAsText(journey)
    local export = "journey "..ExportData(journey.title).." "..ExportData(journey.guid).."\n"
    List:ForEach(journey.chapters, function(chapter)
        export = export.."chapter "..ExportData(chapter.title).."\n"
        List:ForEach(chapter.steps, function(step)
            local command = ExportCommand(step.type)
            if not String:IsNilOrEmpty(command) then
                local arguments = {}
                List:Add(arguments, command)
                List:Add(arguments, ExportData(step.data))
                List:Add(arguments, ExportRaces(step.requiredRaces))
                List:Add(arguments, ExportClasses(step.requiredClasses))
                List:Add(arguments, ExportNote(step.note))
                export = export..string.format("%s\n", String:Trim(String:Join(" ", arguments)))
            end
        end)
    end)
    return export
end

local function ParseWords(line)
    local tokens = {}
    local word = ""
    local insideQuotes = false
    local insideDoubleQuotes = false
    local n = line:len()
    for i = 1, n do
        local char = line:sub(i, i)
        if char == ' ' then
            if insideQuotes or insideDoubleQuotes then
                word = word..char
            elseif not String:IsNilOrEmpty(word) then
                List:Add(tokens, word)
                word = ""
            end
        elseif char == '\"' then
            if insideQuotes then
                word = word..char
            elseif insideDoubleQuotes then
                if not String:IsNilOrEmpty(word) then
                    List:Add(tokens, word)
                    word = ""
                end
                insideDoubleQuotes = false
            else
                insideDoubleQuotes = true
            end
        elseif char == '\'' then
            if insideDoubleQuotes then
                word = word..char
            elseif insideQuotes then
                if not String:IsNilOrEmpty(word) then
                    List:Add(tokens, word)
                    word = ""
                end
                insideQuotes = false
            else
                insideQuotes = true
            end
        else
            word = word..char
        end
    end
    if not String:IsNilOrEmpty(word) then
        List:Add(tokens, word)
    end
    return tokens
end

local function ParseCommandJourney(arguments, context)
    if context.journey then
        addon:Error("Parsing error, journey already defined.")
        return
    end

    local title = arguments[1]
    if String:IsNilOrEmpty(title) then
        addon:Error("Parsing error, missing journey title.")
        return
    end

    local guid = arguments[2]
    if String:IsNilOrEmpty(guid) then
        addon:Error("Parsing error, missing journey guid.")
        return
    end

    context.journey = Journeys:CreateJourney(title, guid)
end

local function ParseCommandChapter(arguments, context)
    local title = arguments[1]
    if String:IsNilOrEmpty(title) then
        addon:Error("Parsing error, missing chapter title.")
        return
    end

    context.chapter = Journeys:AddNewChapter(context.journey, title)
end

local function ParseCommand(type, arguments, context)
    local data, requiredRaces, requiredClasses, note = ""
    if arguments then
        List:ForEach(arguments, function(argument)
            local tokens = String:Split(argument, "=")
            local count = List:Count(tokens)
            if count == 1 then
                data = String:Trim(String:Trim(argument, '\"'), '\'')
            elseif count == 2 then
                local field = tokens[1]
                local value = tokens[2]
                if field == "requiredRaces" then
                    local races = String:Split(value, ",")
                    List:ForEach(races, function(race)
                        if requiredRaces == nil then
                            requiredRaces = 0
                        end
                        local mask = Journeyman["RACE_"..race:upper()]
                        if mask then
                            requiredRaces = bit.bor(requiredRaces, mask)
                        end
                    end)
                elseif field == "requiredClasses" then
                    local classes = String:Split(value, ",")
                    List:ForEach(classes, function(class)
                        if requiredClasses == nil then
                            requiredClasses = 0
                        end
                        local mask = Journeyman["CLASS_"..class:upper()]
                        if mask then
                            requiredClasses = bit.bor(requiredClasses, mask)
                        end
                    end)
                elseif field == "note" then
                    note = String:Trim(String:Trim(value, '\"'), '\'')
                else
                    addon:Error("Parsing error, unknown optional field: %s", field)
                end
            else
                addon:Error("Parsing error, unknown argument: %s", argument)
            end
        end)
    end

    if data then
        context.step = Journeys:AddNewStep(context.journey, context.chapter, type, data, nil, requiredRaces, requiredClasses, note)
    end
end

local function ParseCommands(words, context)
    local command = words[1]
    if not String:IsNilOrEmpty(command) then
        local arguments = List:Skip(words, 1)
        if command == "journey" then
            ParseCommandJourney(arguments, context)
        elseif command == "chapter" then
            ParseCommandChapter(arguments, context)
        else
            if not context.journey then
                addon:Error("Parsing error, no journey defined.")
                return
            end

            if not context.journey then
                addon:Error("Parsing error, no chapter defined.")
                return
            end

            if command == "accept" then
                ParseCommand(addon.STEP_TYPE_ACCEPT_QUEST, arguments, context)
            elseif command == "complete" then
                ParseCommand(addon.STEP_TYPE_COMPLETE_QUEST, arguments, context)
            elseif command == "turnin" then
                ParseCommand(addon.STEP_TYPE_TURNIN_QUEST, arguments, context)
            elseif command == "goto" then
                ParseCommand(addon.STEP_TYPE_GO_TO_COORD, arguments, context)
            elseif command == "gotoarea" then
                ParseCommand(addon.STEP_TYPE_GO_TO_AREA, arguments, context)
            elseif command == "gotozone" then
                ParseCommand(addon.STEP_TYPE_GO_TO_ZONE, arguments, context)
            elseif command == "level" then
                ParseCommand(addon.STEP_TYPE_REACH_LEVEL, arguments, context)
            elseif command == "reputation" then
                ParseCommand(addon.STEP_TYPE_REACH_REPUTATION, arguments, context)
            elseif command == "bind" then
                ParseCommand(addon.STEP_TYPE_BIND_HEARTHSTONE, arguments, context)
            elseif command == "hearth" then
                ParseCommand(addon.STEP_TYPE_USE_HEARTHSTONE, arguments, context)
            elseif command == "learnfp" then
                ParseCommand(addon.STEP_TYPE_LEARN_FLIGHT_PATH, arguments, context)
            elseif command == "flyto" then
                ParseCommand(addon.STEP_TYPE_FLY_TO, arguments, context)
            elseif command == "trainclass" then
                ParseCommand(addon.STEP_TYPE_TRAIN_CLASS, arguments, context)
            elseif command == "trainspells" then
                ParseCommand(addon.STEP_TYPE_TRAIN_SPELLS, arguments, context)
            elseif command == "learnfirstaid" then
                ParseCommand(addon.STEP_TYPE_LEARN_FIRST_AID, arguments, context)
            elseif command == "learncooking" then
                ParseCommand(addon.STEP_TYPE_LEARN_COOKING, arguments, context)
            elseif command == "learnfishing" then
                ParseCommand(addon.STEP_TYPE_LEARN_FISHING, arguments, context)
            elseif command == "getitems" then
                ParseCommand(addon.STEP_TYPE_ACQUIRE_ITEMS, arguments, context)
            elseif command == "die" then
                ParseCommand(addon.STEP_TYPE_DIE_AND_RES, arguments, context)
            else
                ParseCommand(addon.STEP_TYPE_UNDEFINED, arguments, context)
            end
        end
    end
end

function Database:ImportJourneyFromText(text)
    -- Get lines
    local lines = {}
    for line in text:gmatch("[^\r\n]+") do
        if not String:IsNilOrEmpty(line) then
            List:Add(lines, line)
        end
    end

    -- Parse words into commands
    local journey, chapter, step
    local context = {}
    List:ForEach(lines, function(line)
        local words = ParseWords(line)
        if words then
            ParseCommands(words, context)
        end
    end)
    return context.journey
end
