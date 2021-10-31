local addonName, addon = ...
local Traveler = addon.Traveler
local L = addon.Locale

local function Percent(value)
    local windowWidth = 600
    local widthMultiplier = 170
    return (value * windowWidth) / widthMultiplier
end

function Traveler:InitializeOptions()
    LibStub("AceConfig-3.0"):RegisterOptionsTable(addonName, self:GetOptionsTable(), "traveler")

    local aceConfigDialog = LibStub("AceConfigDialog-3.0")
    self.generalOptions = aceConfigDialog:AddToBlizOptions(addonName, addonName, nil, "general")
    self.journeysOptions = aceConfigDialog:AddToBlizOptions(addonName, "Journeys", addonName, "journeys")
    self.advancedOptions = aceConfigDialog:AddToBlizOptions(addonName, "Advanced", addonName, "advanced")
    self.profileOptions = aceConfigDialog:AddToBlizOptions(addonName, "Profiles", addonName, "profiles")
end

function Traveler:GetOptionsTable()
    return {
        type = "group",
        name = addonName.." v"..GetAddOnMetadata(addonName, "version"),
        args = {
            general = self:GetGeneralOptionsTable(),
            journeys = self:GetJourneysOptionsTable(),
            advanced = self:GetAdvancedOptionsTable(),
            profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
        }
    }
end

function Traveler:GetGeneralOptionsTable()
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
                name = L["SELECT_JOURNEY"],
                desc = L["SELECT_JOURNEY_DESC"],
                width = Percent(0.5),
                values = function()
                    local values = {}
                    for i,v in ipairs(self.journeys) do
                        values[i] = v.title
                    end
                    return values
                end,
                set = function(info, value)
                    if self.db.char.window.journey ~= value then
                        self.db.char.window.journey = value
                        self.db.char.window.chapter = 1
                        self.State:Reset()
                    end
                end,
                get = function(info) return self.db.char.window.journey end
            },
            reserved1 = {
                order = 2,
                type = "description",
                name = "",
                width = Percent(0.5)
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
                        self.Tracker:UpdateImmediate()
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
                        self.Tracker:UpdateImmediate()
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
                name = L["SHOW_WINDOW"],
                desc = L["SHOW_WINDOW_DESC"],
                width = Percent(0.5),
                get = function(info) return self.db.char.window.show end,
                set = function(info, value)
                    if self.db.char.window.show ~= value then
                        self.db.char.window.show = value
                        self.Tracker:UpdateImmediate()
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
                        self.Tracker:UpdateImmediate()
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
                        self.Tracker:UpdateImmediate()
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
                    self.Tracker.frame:ClearAllPoints()
                    self.Tracker.frame:SetPoint("CENTER", UIParent, "CENTER")
                    self.Tracker:UpdateImmediate()
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
                        self.Tracker:UpdateImmediate()
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
                        self.Tracker:UpdateImmediate()
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
                        self.State:UpdateImmediate()
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
                        self.State:UpdateImmediate()
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
                        self.State:UpdateImmediate()
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
                    self.Tracker:UpdateImmediate()
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
                        self.Tracker:UpdateImmediate()
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
                        self.Tracker:UpdateImmediate()
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
                        self.Tracker:UpdateImmediate()
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
                        self.Tracker:UpdateImmediate()
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
                        self.Tracker:UpdateImmediate()
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
                        self.Tracker:UpdateImmediate()
                    end
                end
            }
        }
    }
end

function Traveler:GetJourneysOptionsTable()
    return {
        name = "Journeys",
        type = "group",
        args = {
            import = {
                type = "execute",
                name = L["IMPORT_JOURNEY"],
                desc = L["IMPORT_JOURNEY_DESC"],
                func = function() self:JourneyImportFromCharacter() end,
                width = "full"
            },
            journeys = {
                type = "select",
                name = L["SELECT_JOURNEY"],
                desc = L["SELECT_JOURNEY_DESC"],
                width = Percent(0.25),
                values = function()
                    local values = {}
                    for i,v in ipairs(self.journeys) do
                        values[i] = v.title
                    end
                    return values
                end,
                set = function(info, value) end,
                get = function(info) end
            }
        }
    }
end

function Traveler:GetAdvancedOptionsTable()
    return {
        name = "Advanced",
        type = "group",
        args = {
            updateFrequency = {
                order = 0,
                type = "range",
                name = L["UPDATE_FREQUENCY"],
                desc = L["UPDATE_FREQUENCY_DESC"],
                min = 0.1,
                max = 5,
                step = 0.1,
                width = "full",
                confirm = true,
                get = function(info) return self.db.profile.advanced.updateFrequency end,
                set = function(info, value)
                    if self.db.profile.advanced.updateFrequency ~= value then
                        self.db.profile.advanced.updateFrequency = value
                        C_UI.Reload()
                    end
                end
            },
            header = {
                order = 10,
                type = "header",
                name = "Debugging Options"
            },
            debug = {
                order = 11,
                type = "toggle",
                name = L["ENABLE_DEBUG"],
                desc = L["ENABLE_DEBUG_DESC"],
                width = Percent(0.25),
                get = function(info) return self.db.profile.advanced.debug end,
                set = function(info, value)
                    if self.db.profile.advanced.debug ~= value then
                        self.db.profile.advanced.debug = value
                        self.Tracker:UpdateImmediate()
                    end
                end
            }
        }
    }
end
