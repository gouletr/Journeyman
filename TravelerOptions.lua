local addonName, addon = ...
local L = addon.Locale
local Traveler = addon.Traveler

function Traveler:InitializeOptions()
    LibStub("AceConfig-3.0"):RegisterOptionsTable(addonName, self:GetOptionsTable(), "traveler")

    local aceConfigDialog = LibStub("AceConfigDialog-3.0")
    aceConfigDialog:AddToBlizOptions(addonName, addonName, nil, "general")
    aceConfigDialog:AddToBlizOptions(addonName, "Journeys", addonName, "journeys")
    aceConfigDialog:AddToBlizOptions(addonName, "Tracker", addonName, "tracker")
    aceConfigDialog:AddToBlizOptions(addonName, "Advanced", addonName, "advanced")
    aceConfigDialog:AddToBlizOptions(addonName, "Profiles", addonName, "profiles")
end

function Traveler:GetOptionsTable()
    return {
        type = "group",
        name = addonName.." v"..GetAddOnMetadata(addonName, "version"),
        args = {
            general = self:GetGeneralOptionsTable(),
            journeys = self:GetJourneysOptionsTable(),
            tracker = self:GetTrackerOptionsTable(),
            advanced = self:GetAdvancedOptionsTable(),
            profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
        }
    }
end

function Traveler:GetGeneralOptionsTable()
    return {
        name = "General",
        type = "group",
        args = {
            showTracker = {
                order = 0,
                type = "toggle",
                name = L["SHOW_TRACKER"],
                desc = L["SHOW_TRACKER_DESC"],
                get = function(info) return self.db.char.tracker.show end,
                set = function(info, value)
                    if self.db.char.tracker.show ~= value then
                        self.db.char.tracker.show = value
                        self.Tracker:Update()
                    end
                end
            },
            selectJourney = {
                order = 1,
                type = "select",
                name = L["SELECT_JOURNEY"],
                desc = L["SELECT_JOURNEY_DESC"],
                values = function()
                    local values = {}
                    for i,v in ipairs(self.journeys) do
                        values[i] = v.title
                    end
                    return values
                end,
                set = function(info, value)
                    if self.db.char.tracker.journey ~= value then
                        self.db.char.tracker.journey = value
                        self.db.char.tracker.chapter = 1
                        self.db.char.state = {}
                        self.Tracker:ResetState()
                        self.Tracker:Update()
                    end
                end,
                get = function(info) return self.db.char.tracker.journey end
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

function Traveler:GetTrackerOptionsTable()
    return {
        name = "Tracker",
        type = "group",
        args = {
        }
    }
end

function Traveler:GetAdvancedOptionsTable()
    return {
        name = "Advanced",
        type = "group",
        args = {
            debug = {
                type = "toggle",
                name = L["ENABLE_DEBUG"],
                desc = L["ENABLE_DEBUG_DESC"],
                get = function(info) return self.db.profile.general.debug end,
                set = function(info, value) self.db.profile.general.debug = value end
            }
        }
    }
end
