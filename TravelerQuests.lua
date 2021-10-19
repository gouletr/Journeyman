local addonName, addon = ...
local L = addon.Locale
local Traveler = addon.Traveler

local Grail = Grail

function Traveler:GetQuestAcceptLocation(questId)
    local locations = Grail:QuestLocationsAccept(questId, false, true)
    if locations ~= nil then
        return locations[1]
    end
end
