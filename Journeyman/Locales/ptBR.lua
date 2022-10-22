local addonName, addon = ...
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "ptBR")
if not L then return end

-- This localization is missing, if you want to contribute please contact author!

if WOW_PROJECT_ID == WOW_PROJECT_CLASSIC then
    L["REGEX_COMBAT_FACTION_CHANGE"] = "Your (.+) reputation has increased by (%d+)."
    L["REGEX_COMBAT_XP_GAIN"] = "(.+) dies, you gain (%d+) experience."
elseif WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC then
    L["REGEX_COMBAT_FACTION_CHANGE"] = "Reputation with (.+) increased by (%d+)."
    L["REGEX_COMBAT_XP_GAIN"] = "(.+) dies, you gain (%d+) experience."
elseif WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC then
    L["REGEX_COMBAT_FACTION_CHANGE"] = "Reputation with (.+) increased by (%d+)."
    L["REGEX_COMBAT_XP_GAIN"] = "(.+) dies, you gain (%d+) experience."
else
    error(string.format("Unsupported WoW version (WOW_PROJECT_ID = %s)", WOW_PROJECT_ID))
end
