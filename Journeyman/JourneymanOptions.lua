local addonName, addon = ...
local Options, Private = addon:NewModule("Options"), {}
local L = addon.Locale

local addonVersion = GetAddOnMetadata(addonName, "version")

local List = LibStub("LibCollections-1.0").List
local AceGUI = LibStub("AceGUI-3.0")
local Journeys, Database, Editor, Window

local function Percent(value)
    local windowWidth = 600 - 20
    local widthMultiplier = 170
    return (value * windowWidth) / widthMultiplier
end

function Options:OnInitialize()
    Journeys = addon.Journeys
    Database = addon.Database
    Editor = addon.Editor
    Window = addon.Window
end

function Options:OnEnable()
    LibStub("AceConfig-3.0"):RegisterOptionsTable(addonName, self:GetOptionsTable(), addonName)

    local aceConfigDialog = LibStub("AceConfigDialog-3.0")
    self.generalPanel = aceConfigDialog:AddToBlizOptions(addonName, addonName, nil, "general")
    self.myJourneyPanel = aceConfigDialog:AddToBlizOptions(addonName, "My Journey", addonName, "myjourney")
    self.editorPanel = self:GetEditorPanel()
    self.advancedPanel = aceConfigDialog:AddToBlizOptions(addonName, "Advanced", addonName, "advanced")
    self.profilePanel = aceConfigDialog:AddToBlizOptions(addonName, "Profiles", addonName, "profiles")
end

function Options:OnDisable()
end

function Options:GetOptionsTable()
    return {
        type = "group",
        name = string.format("%s v%s", addonName, addonVersion),
        args = {
            general = self:GetGeneralOptionsTable(),
            myjourney = self:GetMyJourneyOptionsTable(),
            advanced = self:GetAdvancedOptionsTable(),
            profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(addon.db)
        }
    }
end

function Options:GetGeneralOptionsTable()
    return {
        type = "group",
        name = "General",
        args = {
            journeyHeader = {
                order = 0,
                type = "header",
                name = L["JOURNEY_OPTIONS"]
            },
            journey = {
                order = 1,
                type = "select",
                name = L["SELECT_JOURNEY"] .. "*",
                desc = L["SELECT_JOURNEY_DESC"] .. "\n" .. L["SAVED_PER_CHARACTER"],
                width = Percent(0.5),
                disabled = function() return #addon.journeys <= 0 end,
                values = function(info)
                    local values = {}
                    if addon.journeys then
                        for i = 1, #addon.journeys do
                            local journey = addon.journeys[i]
                            values[journey.guid] = journey.title
                        end
                    end
                    return values
                end,
                sorting = function(info)
                    local sorting = {}
                    if addon.journeys then
                        for i = 1, #addon.journeys do
                            local journey = addon.journeys[i]
                            sorting[i] = journey.guid
                        end
                    end
                    return sorting
                end,
                set = function(info, value)
                    if addon.db.char.journey ~= value then
                        addon.db.char.journey = value
                        addon.db.char.chapter = 1
                        -- if addon.db.char.updateJourney then
                            -- addon.db.char.updateJourney = false
                            -- addon:Print(L["UPDATE_ACTIVE_JOURNEY_DISABLED"])
                        -- end
                        addon:Reset(true)
                    end
                end,
                get = function(info) return addon.db.char.journey end
            },
            createNewJourney = {
                order = 2,
                type = "execute",
                name = L["CREATE_NEW_JOURNEY"],
                desc = L["CREATE_NEW_JOURNEY_DESC"],
                width = Percent(0.5),
                func = function()
                    local journey = Journeys:AddNewJourney()
                    if journey then
                        local chapter = Journeys:AddNewChapter(journey)
                        if chapter then
                            InterfaceOptionsFrame_OpenToCategory(Editor.frame)
                            Editor:SetSelectedJourneyIndex(#addon.journeys)
                            Editor:SetSelectedChapterIndex(1)
                            Editor:SetSelectedStepIndex(-1)
                            Editor:Refresh()
                            addon.db.char.journey = journey.guid
                            addon:Reset(true)
                        end
                    end
                end
            },
            autoSetWaypoint = {
                order = 3,
                type = "toggle",
                name = L["AUTO_SET_WAYPOINT"],
                desc = L["AUTO_SET_WAYPOINT_DESC"],
                width = Percent(0.5),
                get = function(info) return addon.db.profile.autoSetWaypoint end,
                set = function(info, value)
                    if addon.db.profile.autoSetWaypoint ~= value then
                        addon.db.profile.autoSetWaypoint = value
                        addon:Update()
                    end
                end
            },
            autoSetWaypointMin = {
                order = 4,
                type = "range",
                name = L["AUTO_SET_WAYPOINT_MIN"],
                desc = L["AUTO_SET_WAYPOINT_MIN_DESC"],
                min = 0,
                softMin = 0,
                softMax = 100,
                step = 1,
                bigStep = 5,
                disabled = function() return not addon.db.profile.autoSetWaypoint end,
                width = Percent(0.5),
                get = function(info) return addon.db.profile.autoSetWaypointMin end,
                set = function(info, value)
                    if addon.db.profile.autoSetWaypointMin ~= value then
                        addon.db.profile.autoSetWaypointMin = value
                        addon:Update()
                    end
                end
            },
            windowHeader = {
                order = 20,
                type = "header",
                name = L["WINDOW_OPTIONS"]
            },
            show = {
                order = 21,
                type = "toggle",
                name = L["SHOW_WINDOW"] .. "*",
                desc = L["SHOW_WINDOW_DESC"] .. "\n" .. L["SAVED_PER_CHARACTER"],
                width = Percent(0.5),
                get = function(info) return addon.db.char.window.show end,
                set = function(info, value)
                    if addon.db.char.window.show ~= value then
                        addon.db.char.window.show = value
                        if value then
                            addon:Reset(true)
                        else
                            Window:Update(true)
                        end
                    end
                end
            },
            locked = {
                order = 22,
                type = "toggle",
                name = L["LOCK_WINDOW"],
                desc = L["LOCK_WINDOW_DESC"],
                width = Percent(0.5),
                get = function(info) return addon.db.profile.window.locked end,
                set = function(info, value)
                    if addon.db.profile.window.locked ~= value then
                        addon.db.profile.window.locked = value
                        Window:Update(true)
                    end
                end
            },
            clamped = {
                order = 23,
                type = "toggle",
                name = L["CLAMP_WINDOW"],
                desc = L["CLAMP_WINDOW_DESC"],
                width = Percent(0.5),
                get = function(info) return addon.db.profile.window.clamped end,
                set = function(info, value)
                    if addon.db.profile.window.clamped ~= value then
                        addon.db.profile.window.clamped = value
                        Window:Update(true)
                    end
                end
            },
            resetPosition = {
                order = 24,
                type = "execute",
                name = L["RESET_POSITION"],
                desc = L["RESET_POSITION_DESC"],
                width = Percent(0.5),
                func = function()
                    addon.db.profile.window.relativePoint = "CENTER"
                    addon.db.profile.window.x = 0
                    addon.db.profile.window.y = 0
                    Window.frame:ClearAllPoints()
                    Window.frame:SetPoint("CENTER", UIParent, "CENTER")
                    Window:Update(true)
                end
            },
            showScrollBar = {
                order = 25,
                type = "toggle",
                name = L["SHOW_SCROLL_BAR"],
                desc = L["SHOW_SCROLL_BAR_DESC"],
                width = Percent(0.5),
                get = function(info) return addon.db.profile.window.showScrollBar end,
                set = function(info, value)
                    if addon.db.profile.window.showScrollBar ~= value then
                        addon.db.profile.window.showScrollBar = value
                        Window:Update(true)
                    end
                end
            },
            autoScroll = {
                order = 26,
                type = "toggle",
                name = L["AUTO_SCROLL"],
                desc = L["AUTO_SCROLL_DESC"],
                width = Percent(0.5),
                get = function(info) return addon.db.profile.window.autoScroll end,
                set = function(info, value)
                    if addon.db.profile.window.autoScroll ~= value then
                        addon.db.profile.window.autoScroll = value
                        Window:Update(true)
                    end
                end
            },
            showCompletedSteps = {
                order = 27,
                type = "toggle",
                name = L["SHOW_COMPLETED_STEPS"],
                desc = L["SHOW_COMPLETED_STEPS_DESC"],
                width = Percent(0.5),
                get = function(info) return addon.db.profile.window.showCompletedSteps end,
                set = function(info, value)
                    if addon.db.profile.window.showCompletedSteps ~= value then
                        addon.db.profile.window.showCompletedSteps = value
                        addon:Update(true)
                    end
                end
            },
            showSkippedSteps = {
                order = 28,
                type = "toggle",
                name = L["SHOW_SKIPPED_STEPS"],
                desc = L["SHOW_SKIPPED_STEPS_DESC"],
                width = Percent(0.5),
                get = function(info) return addon.db.profile.window.showSkippedSteps end,
                set = function(info, value)
                    if addon.db.profile.window.showSkippedSteps ~= value then
                        addon.db.profile.window.showSkippedSteps = value
                        addon:Update(true)
                    end
                end
            },
            showQuestLevel = {
                order = 29,
                type = "toggle",
                name = L["SHOW_QUEST_LEVEL"],
                desc = L["SHOW_QUEST_LEVEL_DESC"],
                width = Percent(0.5),
                get = function(info) return addon.db.profile.window.showQuestLevel end,
                set = function(info, value)
                    if addon.db.profile.window.showQuestLevel ~= value then
                        addon.db.profile.window.showQuestLevel = value
                        Window:Update(true)
                    end
                end
            },
            hardcoreMode = {
                order = 30,
                type = "toggle",
                name = L["HARDCORE_MODE"].."*",
                desc = L["HARDCORE_MODE_DESC"].."\n"..L["SAVED_PER_CHARACTER"],
                width = Percent(0.5),
                get = function(info) return addon.db.char.hardcoreMode end,
                set = function(info, value)
                    if addon.db.char.hardcoreMode ~= value then
                        addon.db.char.hardcoreMode = value
                        addon:Reset(true)
                    end
                end
            },
            stepsShown = {
                order = 32,
                type = "range",
                name = L["STEPS_SHOWN"],
                desc = L["STEPS_SHOWN_DESC"],
                min = 0,
                softMin = 1,
                softMax = 25,
                step = 1,
                width = Percent(0.5),
                get = function(info) return addon.db.profile.window.stepsShown end,
                set = function(info, value)
                    if addon.db.profile.window.stepsShown ~= value then
                        addon.db.profile.window.stepsShown = value
                        addon:Update(true)
                    end
                end
            },
            reserved2 = {
                order = 33,
                type = "description",
                name = "",
                width = Percent(0.004)
            },
            backgroundColor = {
                order = 34,
                type = "color",
                name = L["WINDOW_BG_COLOR"],
                desc = L["WINDOW_BG_COLOR_DESC"],
                hasAlpha = true,
                width = Percent(0.5),
                get = function(info)
                    local color = addon.db.profile.window.backgroundColor
                    return color.r, color.g, color.b, color.a
                end,
                set = function(info, r, g, b, a)
                    addon.db.profile.window.backgroundColor.r = r
                    addon.db.profile.window.backgroundColor.g = g
                    addon.db.profile.window.backgroundColor.b = b
                    addon.db.profile.window.backgroundColor.a = a
                    Window:Update(true)
                end
            },
            width = {
                order = 35,
                type = "range",
                name = L["WINDOW_WIDTH"],
                desc = L["WINDOW_WIDTH_DESC"],
                min = 200,
                softMin = 200,
                softMax = 1000,
                step = 1,
                bigStep = 10,
                width = Percent(0.5),
                get = function(info) return addon.db.profile.window.width end,
                set = function(info, value)
                    if addon.db.profile.window.width ~= value then
                        addon.db.profile.window.width = value
                        Window:Update(true)
                    end
                end
            },
            height = {
                order = 36,
                type = "range",
                name = L["WINDOW_HEIGHT"],
                desc = L["WINDOW_HEIGHT_DESC"],
                min = 100,
                softMin = 100,
                softMax = 1000,
                step = 1,
                bigStep = 10,
                width = Percent(0.5),
                get = function(info) return addon.db.profile.window.height end,
                set = function(info, value)
                    if addon.db.profile.window.height ~= value then
                        addon.db.profile.window.height = value
                        Window:Update(true)
                    end
                end
            },
            stepSpacing = {
                order = 37,
                type = "range",
                name = L["WINDOW_STEP_SPACING"],
                desc = L["WINDOW_STEP_SPACING_DESC"],
                min = 0,
                max = 20,
                step = 1,
                width = Percent(0.5),
                get = function(info) return addon.db.profile.window.stepSpacing end,
                set = function(info, value)
                    if addon.db.profile.window.stepSpacing ~= value then
                        addon.db.profile.window.stepSpacing = value
                        Window:Update(true)
                    end
                end
            },
            lineSpacing = {
                order = 38,
                type = "range",
                name = L["LINE_SPACING"],
                desc = L["LINE_SPACING_DESC"],
                min = 0,
                max = 20,
                step = 1,
                width = Percent(0.5),
                get = function(info) return addon.db.profile.window.lineSpacing end,
                set = function(info, value)
                    if addon.db.profile.window.lineSpacing ~= value then
                        addon.db.profile.window.lineSpacing = value
                        Window:Update(true)
                    end
                end
            },
            fontSize = {
                order = 39,
                type = "range",
                name = L["FONT_SIZE"],
                desc = L["FONT_SIZE_DESC"],
                min = 8,
                max = 24,
                step = 1,
                width = Percent(0.5),
                get = function(info) return addon.db.profile.window.fontSize end,
                set = function(info, value)
                    if addon.db.profile.window.fontSize ~= value then
                        addon.db.profile.window.fontSize = value
                        Window:Update(true)
                    end
                end
            },
            indentSize = {
                order = 40,
                type = "range",
                name = L["INDENT_SIZE"],
                desc = L["INDENT_SIZE_DESC"],
                min = 0,
                max = 50,
                step = 1,
                width = Percent(0.5),
                get = function(info) return addon.db.profile.window.indentSize end,
                set = function(info, value)
                    if addon.db.profile.window.indentSize ~= value then
                        addon.db.profile.window.indentSize = value
                        Window:Update(true)
                    end
                end
            },
            windowStrata = {
                order = 41,
                type = "select",
                name = L["WINDOW_STRATA"],
                desc = L["WINDOW_STRATA_DESC"],
                width = Percent(0.5),
                values = {
                    ["BACKGROUND"] = "BACKGROUND",
                    ["LOW"] = "LOW",
                    ["MEDIUM"] = "MEDIUM",
                    ["HIGH"] = "HIGH",
                    ["DIALOG"] = "DIALOG",
                    ["FULLSCREEN"] = "FULLSCREEN",
                    ["FULLSCREEN_DIALOG"] = "FULLSCREEN_DIALOG",
                    ["TOOLTIP"] = "TOOLTIP"
                },
                sorting = {"BACKGROUND", "LOW", "MEDIUM", "HIGH", "DIALOG", "FULLSCREEN", "FULLSCREEN_DIALOG", "TOOLTIP"},
                get = function(info) return addon.db.profile.window.strata end,
                set = function(info, value)
                    if addon.db.profile.window.strata ~= value then
                        addon.db.profile.window.strata = value
                        Window:Update(true)
                    end
                end
            },
            windowLevel = {
                order = 42,
                type = "range",
                name = L["WINDOW_LEVEL"],
                desc = L["WINDOW_LEVEL_DESC"],
                min = 0,
                max = 9999,
                step = 1,
                bigStep = 100,
                width = Percent(0.5),
                get = function(info) return addon.db.profile.window.level end,
                set = function(info, value)
                    if addon.db.profile.window.level ~= value then
                        addon.db.profile.window.level = value
                        Window:Update(true)
                    end
                end
            }
        }
    }
end

function Options:GetMyJourneyOptionsTable()
    return {
        name = "My Journey",
        type = "group",
        args = {
            headerOptions = {
                order = 0,
                type = "header",
                name = L["MY_JOURNEY_HEADER_OPTIONS"]
            },
            enabled = {
                order = 1,
                type = "toggle",
                name = L["MY_JOURNEY_ENABLE"].."*",
                desc = L["MY_JOURNEY_ENABLE_DESC"].."\n"..L["SAVED_PER_CHARACTER"],
                width = Percent(1.0),
                get = function(info) return addon.db.char.myJourney.enabled end,
                set = function(info, value)
                    if addon.db.char.myJourney.enabled ~= value then
                        addon.db.char.myJourney.enabled = value
                    end
                end
            },
            atMaxLevel = {
                order = 2,
                type = "toggle",
                name = L["MY_JOURNEY_AT_MAX_LEVEL"],
                desc = L["MY_JOURNEY_AT_MAX_LEVEL_DESC"],
                width = Percent(0.5),
                disabled = function(info) return not addon.db.char.myJourney.enabled end,
                get = function(info) return addon.db.profile.myJourney.atMaxLevel end,
                set = function(info, value)
                    if addon.db.profile.myJourney.atMaxLevel ~= value then
                        addon.db.profile.myJourney.atMaxLevel = value
                    end
                end
            },
            abandonedQuests = {
                order = 3,
                type = "toggle",
                name = L["MY_JOURNEY_ABANDONED_QUESTS"],
                desc = L["MY_JOURNEY_ABANDONED_QUESTS_DESC"],
                width = Percent(0.5),
                disabled = function(info) return not addon.db.char.myJourney.enabled end,
                get = function(info) return addon.db.profile.myJourney.abandonedQuests end,
                set = function(info, value)
                    if addon.db.profile.myJourney.abandonedQuests ~= value then
                        addon.db.profile.myJourney.abandonedQuests = value
                    end
                end
            },
            headerStepTypes = {
                order = 4,
                type = "header",
                name = L["MY_JOURNEY_HEADER_STEP_TYPES"]
            },
            stepTypeAcceptQuest = {
                order = 5,
                type = "toggle",
                name = L["MY_JOURNEY_STEP_ACCEPT_QUEST"],
                desc = L["MY_JOURNEY_STEP_ACCEPT_QUEST_DESC"],
                width = Percent(0.5),
                disabled = function(info) return not addon.db.char.myJourney.enabled end,
                get = function(info) return addon.db.profile.myJourney.stepTypeAcceptQuest end,
                set = function(info, value)
                    if addon.db.profile.myJourney.stepTypeAcceptQuest ~= value then
                        addon.db.profile.myJourney.stepTypeAcceptQuest = value
                    end
                end
            },
            stepTypeCompleteQuest = {
                order = 6,
                type = "toggle",
                name = L["MY_JOURNEY_STEP_COMPLETE_QUEST"],
                desc = L["MY_JOURNEY_STEP_COMPLETE_QUEST_DESC"],
                width = Percent(0.5),
                disabled = function(info) return not addon.db.char.myJourney.enabled end,
                get = function(info) return addon.db.profile.myJourney.stepTypeCompleteQuest end,
                set = function(info, value)
                    if addon.db.profile.myJourney.stepTypeCompleteQuest ~= value then
                        addon.db.profile.myJourney.stepTypeCompleteQuest = value
                    end
                end
            },
            stepTypeTurnInQuest = {
                order = 7,
                type = "toggle",
                name = L["MY_JOURNEY_STEP_TURNIN_QUEST"],
                desc = L["MY_JOURNEY_STEP_TURNIN_QUEST_DESC"],
                width = Percent(0.5),
                disabled = function(info) return not addon.db.char.myJourney.enabled end,
                get = function(info) return addon.db.profile.myJourney.stepTypeTurnInQuest end,
                set = function(info, value)
                    if addon.db.profile.myJourney.stepTypeTurnInQuest ~= value then
                        addon.db.profile.myJourney.stepTypeTurnInQuest = value
                    end
                end
            },
            stepTypeGoToZone = {
                order = 8,
                type = "toggle",
                name = L["MY_JOURNEY_STEP_GO_TO_ZONE"],
                desc = L["MY_JOURNEY_STEP_GO_TO_ZONE_DESC"],
                width = Percent(0.5),
                disabled = function(info) return not addon.db.char.myJourney.enabled end,
                get = function(info) return addon.db.profile.myJourney.stepTypeGoToZone end,
                set = function(info, value)
                    if addon.db.profile.myJourney.stepTypeGoToZone ~= value then
                        addon.db.profile.myJourney.stepTypeGoToZone = value
                    end
                end
            },
            stepTypeReachLevel = {
                order = 9,
                type = "toggle",
                name = L["MY_JOURNEY_STEP_REACH_LEVEL"],
                desc = L["MY_JOURNEY_STEP_REACH_LEVEL_DESC"],
                width = Percent(0.5),
                disabled = function(info) return not addon.db.char.myJourney.enabled end,
                get = function(info) return addon.db.profile.myJourney.stepTypeReachLevel end,
                set = function(info, value)
                    if addon.db.profile.myJourney.stepTypeReachLevel ~= value then
                        addon.db.profile.myJourney.stepTypeReachLevel = value
                    end
                end
            },
            stepTypeBindHearthstone = {
                order = 10,
                type = "toggle",
                name = L["MY_JOURNEY_STEP_BIND_HEARTHSTONE"],
                desc = L["MY_JOURNEY_STEP_BIND_HEARTHSTONE_DESC"],
                width = Percent(0.5),
                disabled = function(info) return not addon.db.char.myJourney.enabled end,
                get = function(info) return addon.db.profile.myJourney.stepTypeBindHearthstone end,
                set = function(info, value)
                    if addon.db.profile.myJourney.stepTypeBindHearthstone ~= value then
                        addon.db.profile.myJourney.stepTypeBindHearthstone = value
                    end
                end
            },
            stepTypeUseHearthstone = {
                order = 11,
                type = "toggle",
                name = L["MY_JOURNEY_STEP_USE_HEARTHSTONE"],
                desc = L["MY_JOURNEY_STEP_USE_HEARTHSTONE_DESC"],
                width = Percent(0.5),
                disabled = function(info) return not addon.db.char.myJourney.enabled end,
                get = function(info) return addon.db.profile.myJourney.stepTypeUseHearthstone end,
                set = function(info, value)
                    if addon.db.profile.myJourney.stepTypeUseHearthstone ~= value then
                        addon.db.profile.myJourney.stepTypeUseHearthstone = value
                    end
                end
            },
            stepTypeLearnFlightPath = {
                order = 12,
                type = "toggle",
                name = L["MY_JOURNEY_STEP_LEARN_FLIGHT_PATH"],
                desc = L["MY_JOURNEY_STEP_LEARN_FLIGHT_PATH_DESC"],
                width = Percent(0.5),
                disabled = function(info) return not addon.db.char.myJourney.enabled end,
                get = function(info) return addon.db.profile.myJourney.stepTypeLearnFlightPath end,
                set = function(info, value)
                    if addon.db.profile.myJourney.stepTypeLearnFlightPath ~= value then
                        addon.db.profile.myJourney.stepTypeLearnFlightPath = value
                    end
                end
            },
            stepTypeFlyTo = {
                order = 13,
                type = "toggle",
                name = L["MY_JOURNEY_STEP_FLY_TO"],
                desc = L["MY_JOURNEY_STEP_FLY_TO_DESC"],
                width = Percent(0.5),
                disabled = function(info) return not addon.db.char.myJourney.enabled end,
                get = function(info) return addon.db.profile.myJourney.stepTypeFlyTo end,
                set = function(info, value)
                    if addon.db.profile.myJourney.stepTypeFlyTo ~= value then
                        addon.db.profile.myJourney.stepTypeFlyTo = value
                    end
                end
            },
            stepTypeTrainClass = {
                order = 14,
                type = "toggle",
                name = L["MY_JOURNEY_STEP_TRAIN_CLASS"],
                desc = L["MY_JOURNEY_STEP_TRAIN_CLASS_DESC"],
                width = Percent(0.5),
                disabled = function(info) return not addon.db.char.myJourney.enabled end,
                get = function(info) return addon.db.profile.myJourney.stepTypeTrainClass end,
                set = function(info, value)
                    if addon.db.profile.myJourney.stepTypeTrainClass ~= value then
                        addon.db.profile.myJourney.stepTypeTrainClass = value
                        if value then
                            addon.db.profile.myJourney.stepTypeTrainSpells = false
                        end
                    end
                end
            },
            stepTypeTrainSpells = {
                order = 15,
                type = "toggle",
                name = L["MY_JOURNEY_STEP_TRAIN_SPELLS"],
                desc = L["MY_JOURNEY_STEP_TRAIN_SPELLS_DESC"],
                width = Percent(0.5),
                disabled = function(info) return not addon.db.char.myJourney.enabled end,
                get = function(info) return addon.db.profile.myJourney.stepTypeTrainSpells end,
                set = function(info, value)
                    if addon.db.profile.myJourney.stepTypeTrainSpells ~= value then
                        addon.db.profile.myJourney.stepTypeTrainSpells = value
                        if value then
                            addon.db.profile.myJourney.stepTypeTrainClass = false
                        end
                    end
                end
            },
            stepTypeDieAndRes = {
                order = 16,
                type = "toggle",
                name = L["MY_JOURNEY_STEP_DIE_AND_RES"],
                desc = L["MY_JOURNEY_STEP_DIE_AND_RES_DESC"],
                width = Percent(0.5),
                disabled = function(info) return not addon.db.char.myJourney.enabled end,
                get = function(info) return addon.db.profile.myJourney.stepTypeDieAndRes end,
                set = function(info, value)
                    if addon.db.profile.myJourney.stepTypeDieAndRes ~= value then
                        addon.db.profile.myJourney.stepTypeDieAndRes = value
                    end
                end
            },
            exportJourney = {
                order = 17,
                type = "execute",
                name = L["EXPORT_JOURNEY"],
                desc = L["EXPORT_JOURNEY_DESC"],
                width = Percent(1.0),
                func = function()
                    local journey = addon.myJourney
                    if journey then
                        local window = AceGUI:Create("Frame")
                        window:SetTitle(L["EXPORT_JOURNEY"])
                        window:SetCallback("OnClose", function(widget) AceGUI:Release(widget) end)
                        window:SetLayout("Fill")

                        local editBox = AceGUI:Create("MultiLineEditBox")
                        editBox:DisableButton(true)
                        editBox:SetFocus()
                        editBox.label:SetText(L["COPY_TEXT_BELOW"])
                        window:AddChild(editBox)

                        local export = Database:ExportJourneyAsText(journey)
                        if export then
                            editBox:SetText(export)
                            editBox:HighlightText()
                        end
                    end
                end
            }
        }
    }
end

function Options:GetAdvancedOptionsTable()
    return {
        name = "Advanced",
        type = "group",
        args = {
            -- journeyHeader = {
                -- order = 0,
                -- type = "header",
                -- name = L["JOURNEY_OPTIONS"]
            -- },
            -- updateJourney = {
                -- order = 1,
                -- type = "toggle",
                -- name = L["UPDATE_ACTIVE_JOURNEY"] .. "*",
                -- desc = L["UPDATE_ACTIVE_JOURNEY_DESC"] .. "\n" .. L["SAVED_PER_CHARACTER"],
                -- width = Percent(1.0),
                -- confirm = true,
                -- confirmText = L["UPDATE_ACTIVE_JOURNEY_CONFIRM"],
                -- get = function(info) return addon.db.char.updateJourney end,
                -- set = function(info, value)
                    -- if addon.db.char.updateJourney ~= value then
                        -- addon.db.char.updateJourney = value
                    -- end
                -- end
            -- },
            -- updateJourneyDesc = {
                -- order = 2,
                -- type = "description",
                -- name = L["UPDATE_ACTIVE_JOURNEY_TEXT"],
                -- width = Percent(1.0)
            -- },
            updateHeader = {
                order = 10,
                type = "header",
                name = L["UPDATE_OPTIONS"]
            },
            updateFrequency = {
                order = 11,
                type = "range",
                name = L["UPDATE_FREQUENCY"],
                desc = L["UPDATE_FREQUENCY_DESC"],
                min = 0.1,
                max = 5,
                step = 0.1,
                bigStep = 0.1,
                width = Percent(0.5),
                confirm = true,
                confirmText = L["UPDATE_FREQUENCY_CONFIRM"],
                get = function(info) return addon.db.profile.advanced.updateFrequency end,
                set = function(info, value)
                    if addon.db.profile.advanced.updateFrequency ~= value then
                        addon.db.profile.advanced.updateFrequency = value
                        C_UI.Reload()
                    end
                end
            },
            updateFrequencyDesc = {
                order = 12,
                type = "description",
                name = L["UPDATE_FREQUENCY_TEXT"],
                width = Percent(1.0)
            },
            header = {
                order = 20,
                type = "header",
                name = L["DEBUGGING_OPTIONS"]
            },
            debug = {
                order = 21,
                type = "toggle",
                name = L["ENABLE_DEBUG"],
                desc = L["ENABLE_DEBUG_DESC"],
                width = Percent(0.25),
                get = function(info) return addon.db.profile.advanced.debug end,
                set = function(info, value)
                    if addon.db.profile.advanced.debug ~= value then
                        addon.db.profile.advanced.debug = value
                        if addon.db.profile.advanced.debug then
                            _G["Journeyman"] = addon
                        else
                            _G["Journeyman"] = nil
                        end
                        Window:Update(true)
                    end
                end
            },
            debugDesc = {
                order = 22,
                type = "description",
                name = L["ENABLE_DEBUG_TEXT"],
                width = Percent(1.0)
            }
        }
    }
end

function Options:GetEditorPanel()
    xpcall(function()
        InterfaceOptions_AddCategory(Editor.frame)
        return Editor.frame
    end, geterrorhandler())
end
