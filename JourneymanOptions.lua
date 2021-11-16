local addonName, addon = ...
local addonVersion = GetAddOnMetadata(addonName, "version")
local Journeyman = addon.Journeyman
local L = addon.Locale

local function Percent(value)
    local windowWidth = 600
    local widthMultiplier = 170
    return (value * windowWidth) / widthMultiplier
end

function Journeyman:InitializeOptions()
    LibStub("AceConfig-3.0"):RegisterOptionsTable(addonName, self:GetOptionsTable(), addonName)

    local aceConfigDialog = LibStub("AceConfigDialog-3.0")
    self.generalPanel = aceConfigDialog:AddToBlizOptions(addonName, addonName, nil, "general")
    self.editorPanel = self:GetEditorPanel()
    self.advancedPanel = aceConfigDialog:AddToBlizOptions(addonName, "Advanced", addonName, "advanced")
    self.profilePanel = aceConfigDialog:AddToBlizOptions(addonName, "Profiles", addonName, "profiles")
end

function Journeyman:GetOptionsTable()
    return {
        type = "group",
        name = string.format("%s v%s", addonName, addonVersion),
        args = {
            general = self:GetGeneralOptionsTable(),
            advanced = self:GetAdvancedOptionsTable(),
            profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
        }
    }
end

function Journeyman:GetGeneralOptionsTable()
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
                disabled = function()
                    return #self.journeys <= 0
                end,
                values = function(info)
                    local values = {}
                    if self.journeys then
                        for i = 1, #self.journeys do
                            local journey = self.journeys[i]
                            values[journey.guid] = journey.title
                        end
                    end
                    return values
                end,
                sorting = function(info)
                    local sorting = {}
                    if self.journeys then
                        for i = 1, #self.journeys do
                            local journey = self.journeys[i]
                            sorting[i] = journey.guid
                        end
                    end
                    return sorting
                end,
                set = function(info, value)
                    if self.db.char.journey ~= value then
                        self.db.char.journey = value
                        self.db.char.chapter = 1
                        if self.db.char.updateJourney then
                            self.db.char.updateJourney = false
                            Journeyman:Print(L["UPDATE_ACTIVE_JOURNEY_DISABLED"])
                        end
                        Journeyman:Reset(true)
                    end
                end,
                get = function(info) return self.db.char.journey end
            },
            createNewJourney = {
                order = 2,
                type = "execute",
                name = L["CREATE_NEW_JOURNEY"],
                desc = L["CREATE_NEW_JOURNEY_DESC"],
                width = Percent(0.5),
                func = function()
                    local journey = Journeyman.Journey:CreateJourney()
                    if journey then
                        local chapter = Journeyman.Journey:CreateChapter(journey)
                        if chapter then
                            InterfaceOptionsFrame_OpenToCategory(Journeyman.Editor.frame)
                            Journeyman.Editor:SetSelectedJourneyIndex(#Journeyman.journeys)
                            Journeyman.Editor:SetSelectedChapterIndex(#journey.chapters)
                            Journeyman.Editor:Refresh()
                            Journeyman.db.char.journey = journey.guid
                            Journeyman:Reset(true)
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
                get = function(info) return self.db.profile.autoSetWaypoint end,
                set = function(info, value)
                    if self.db.profile.autoSetWaypoint ~= value then
                        self.db.profile.autoSetWaypoint = value
                        if value then
                            Journeyman:UpdateWaypoint()
                        end
                        Journeyman:Update()
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
                disabled = function() return not self.db.profile.autoSetWaypoint end,
                width = Percent(0.5),
                get = function(info) return self.db.profile.autoSetWaypointMin end,
                set = function(info, value)
                    if self.db.profile.autoSetWaypointMin ~= value then
                        self.db.profile.autoSetWaypointMin = value
                        Journeyman:Update()
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
                get = function(info) return self.db.char.window.show end,
                set = function(info, value)
                    if self.db.char.window.show ~= value then
                        self.db.char.window.show = value
                        if value then
                            Journeyman:Reset(true)
                        else
                            Journeyman.Window:Update(true)
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
                get = function(info) return self.db.profile.window.locked end,
                set = function(info, value)
                    if self.db.profile.window.locked ~= value then
                        self.db.profile.window.locked = value
                        self.Window:Update(true)
                    end
                end
            },
            clamped = {
                order = 23,
                type = "toggle",
                name = L["CLAMP_WINDOW"],
                desc = L["CLAMP_WINDOW_DESC"],
                width = Percent(0.5),
                get = function(info) return self.db.profile.window.clamped end,
                set = function(info, value)
                    if self.db.profile.window.clamped ~= value then
                        self.db.profile.window.clamped = value
                        self.Window:Update(true)
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
                    self.db.profile.window.relativePoint = "CENTER"
                    self.db.profile.window.x = 0
                    self.db.profile.window.y = 0
                    self.Window.frame:ClearAllPoints()
                    self.Window.frame:SetPoint("CENTER", UIParent, "CENTER")
                    self.Window:Update(true)
                end
            },
            showScrollBar = {
                order = 25,
                type = "toggle",
                name = L["SHOW_SCROLL_BAR"],
                desc = L["SHOW_SCROLL_BAR_DESC"],
                width = Percent(0.5),
                get = function(info) return self.db.profile.window.showScrollBar end,
                set = function(info, value)
                    if self.db.profile.window.showScrollBar ~= value then
                        self.db.profile.window.showScrollBar = value
                        self.Window:Update(true)
                    end
                end
            },
            showQuestLevel = {
                order = 26,
                type = "toggle",
                name = L["SHOW_QUEST_LEVEL"],
                desc = L["SHOW_QUEST_LEVEL_DESC"],
                width = Percent(0.5),
                get = function(info) return self.db.profile.window.showQuestLevel end,
                set = function(info, value)
                    if self.db.profile.window.showQuestLevel ~= value then
                        self.db.profile.window.showQuestLevel = value
                        self.Window:Update(true)
                    end
                end
            },
            showCompletedSteps = {
                order = 27,
                type = "toggle",
                name = L["SHOW_COMPLETED_STEPS"],
                desc = L["SHOW_COMPLETED_STEPS_DESC"],
                width = Percent(0.5),
                get = function(info) return self.db.profile.window.showCompletedSteps end,
                set = function(info, value)
                    if self.db.profile.window.showCompletedSteps ~= value then
                        self.db.profile.window.showCompletedSteps = value
                        Journeyman:Update(true)
                    end
                end
            },
            showSkippedSteps = {
                order = 28,
                type = "toggle",
                name = L["SHOW_SKIPPED_STEPS"],
                desc = L["SHOW_SKIPPED_STEPS_DESC"],
                width = Percent(0.5),
                get = function(info) return self.db.profile.window.showSkippedSteps end,
                set = function(info, value)
                    if self.db.profile.window.showSkippedSteps ~= value then
                        self.db.profile.window.showSkippedSteps = value
                        Journeyman:Update(true)
                    end
                end
            },
            stepsShown = {
                order = 29,
                type = "range",
                name = L["STEPS_SHOWN"],
                desc = L["STEPS_SHOWN_DESC"],
                min = 0,
                softMin = 1,
                softMax = 25,
                step = 1,
                width = Percent(0.5),
                get = function(info) return self.db.profile.window.stepsShown end,
                set = function(info, value)
                    if self.db.profile.window.stepsShown ~= value then
                        self.db.profile.window.stepsShown = value
                        Journeyman:Update(true)
                    end
                end
            },
            reserved2 = {
                order = 30,
                type = "description",
                name = "",
                width = Percent(0.004)
            },
            backgroundColor = {
                order = 31,
                type = "color",
                name = L["WINDOW_BG_COLOR"],
                desc = L["WINDOW_BG_COLOR_DESC"],
                hasAlpha = true,
                width = Percent(0.5),
                get = function(info)
                    local color = self.db.profile.window.backgroundColor
                    return color.r, color.g, color.b, color.a
                end,
                set = function(info, r, g, b, a)
                    self.db.profile.window.backgroundColor.r = r
                    self.db.profile.window.backgroundColor.g = g
                    self.db.profile.window.backgroundColor.b = b
                    self.db.profile.window.backgroundColor.a = a
                    self.Window:Update(true)
                end
            },
            width = {
                order = 32,
                type = "range",
                name = L["WINDOW_WIDTH"],
                desc = L["WINDOW_WIDTH_DESC"],
                min = 200,
                softMin = 200,
                softMax = 1000,
                step = 1,
                bigStep = 10,
                width = Percent(0.5),
                get = function(info) return self.db.profile.window.width end,
                set = function(info, value)
                    if self.db.profile.window.width ~= value then
                        self.db.profile.window.width = value
                        self.Window:Update(true)
                    end
                end
            },
            height = {
                order = 33,
                type = "range",
                name = L["WINDOW_HEIGHT"],
                desc = L["WINDOW_HEIGHT_DESC"],
                min = 100,
                softMin = 100,
                softMax = 1000,
                step = 1,
                bigStep = 10,
                width = Percent(0.5),
                get = function(info) return self.db.profile.window.height end,
                set = function(info, value)
                    if self.db.profile.window.height ~= value then
                        self.db.profile.window.height = value
                        self.Window:Update(true)
                    end
                end
            },
            fontSize = {
                order = 34,
                type = "range",
                name = L["FONT_SIZE"],
                desc = L["FONT_SIZE_DESC"],
                min = 8,
                max = 24,
                step = 1,
                width = Percent(0.5),
                get = function(info) return self.db.profile.window.fontSize end,
                set = function(info, value)
                    if self.db.profile.window.fontSize ~= value then
                        self.db.profile.window.fontSize = value
                        self.Window:Update(true)
                    end
                end
            },
            lineSpacing = {
                order = 35,
                type = "range",
                name = L["LINE_SPACING"],
                desc = L["LINE_SPACING_DESC"],
                min = 0,
                max = 24,
                step = 1,
                width = Percent(0.5),
                get = function(info) return self.db.profile.window.lineSpacing end,
                set = function(info, value)
                    if self.db.profile.window.lineSpacing ~= value then
                        self.db.profile.window.lineSpacing = value
                        self.Window:Update(true)
                    end
                end
            },
            windowStrata = {
                order = 36,
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
                get = function(info) return self.db.profile.window.strata end,
                set = function(info, value)
                    if self.db.profile.window.strata ~= value then
                        self.db.profile.window.strata = value
                        self.Window:Update(true)
                    end
                end
            },
            windowLevel = {
                order = 37,
                type = "range",
                name = L["WINDOW_LEVEL"],
                desc = L["WINDOW_LEVEL_DESC"],
                min = 0,
                max = 10000,
                step = 1,
                bigStep = 100,
                width = Percent(0.5),
                get = function(info) return self.db.profile.window.level end,
                set = function(info, value)
                    if self.db.profile.window.level ~= value then
                        self.db.profile.window.level = value
                        self.Window:Update(true)
                    end
                end
            }
        }
    }
end

function Journeyman:GetAdvancedOptionsTable()
    return {
        name = "Advanced",
        type = "group",
        args = {
            journeyHeader = {
                order = 0,
                type = "header",
                name = L["JOURNEY_OPTIONS"]
            },
            updateJourney = {
                order = 1,
                type = "toggle",
                name = L["UPDATE_ACTIVE_JOURNEY"] .. "*",
                desc = L["UPDATE_ACTIVE_JOURNEY_DESC"] .. "\n" .. L["SAVED_PER_CHARACTER"],
                width = Percent(1.0),
                confirm = true,
                confirmText = L["UPDATE_ACTIVE_JOURNEY_CONFIRM"],
                get = function(info) return self.db.char.updateJourney end,
                set = function(info, value)
                    if self.db.char.updateJourney ~= value then
                        self.db.char.updateJourney = value
                    end
                end
            },
            updateJourneyDesc = {
                order = 2,
                type = "description",
                name = L["UPDATE_ACTIVE_JOURNEY_TEXT"],
                width = Percent(1.0)
            },
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
                get = function(info) return self.db.profile.advanced.updateFrequency end,
                set = function(info, value)
                    if self.db.profile.advanced.updateFrequency ~= value then
                        self.db.profile.advanced.updateFrequency = value
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
                get = function(info) return self.db.profile.advanced.debug end,
                set = function(info, value)
                    if self.db.profile.advanced.debug ~= value then
                        self.db.profile.advanced.debug = value
                        self.Window:Update(true)
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

function Journeyman:GetEditorPanel()
    xpcall(function()
        InterfaceOptions_AddCategory(Journeyman.Editor.frame)
        return Journeyman.Editor.frame
    end, geterrorhandler())
end
