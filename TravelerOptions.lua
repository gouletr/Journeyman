local addonName, addon = ...
local L = addon.Locale
local Traveler = addon.Traveler

function Traveler:InitializeOptions()
    LibStub("AceConfig-3.0"):RegisterOptionsTable(addonName, self:GetOptionsTable(), "traveler")

    local aceConfigDialog = LibStub("AceConfigDialog-3.0")
    aceConfigDialog:AddToBlizOptions(addonName, addonName, nil, "general")
    aceConfigDialog:AddToBlizOptions(addonName, "Journeys", nil, "journeys")
    aceConfigDialog:AddToBlizOptions(addonName, "Tracker", addonName, "tracker")
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
            profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
        }
    }
end

function Traveler:GetGeneralOptionsTable()
    return {
        name = "General",
        type = "group",
        args = {
            debug = {
                type = "toggle",
                name = "Show Debug Infos",
                desc = "Toggle showing debug informations.",
                get = function(info) return self.db.profile.general.debug end,
                set = function(info, value) self.db.profile.general.debug = value end
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
                func = "ImportFromCharacter"
            }
        }
    }
end

function Traveler:GetTrackerOptionsTable()
    return {
        name = "Tracker",
        type = "group",
        args = {
            show = {
                type = "toggle",
                name = L["SHOW_TRACKER"],
                desc = L["SHOW_TRACKER_DESC"],
                get = function(info) return self.db.char.tracker.show end,
                set = function(info, value)
                    if value then
                        self:ShowTracker()
                    else
                        self:HideTracker()
                    end
                end
            }
        }
    }
end
