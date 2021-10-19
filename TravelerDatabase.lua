local addonName, addon = ...
local L = addon.Locale
local Traveler = addon.Traveler

local databaseDefaults = {
    profile = {
        general = {
            debug = false
        },
        tracker = {
            locked = false,
            width = 300,
            height = 300,
            relativeTo = "CENTER",
            x = 0,
            y = 0,
            alpha = 0.5
        }
    },
    char = {
        tracker = {
            show = true
        },
        journey = {
            title = nil,
            chapters = {}
        }
    }
}

function Traveler:InitializeDatabase()
    self.db = LibStub("AceDB-3.0"):New(addonName.."Database", databaseDefaults, true)
end
