local addonName, addon = ...
local L = addon.Locale
local Traveler = addon.Traveler

function Traveler:InitializeHooks()
    self:Hook("TakeTaxiNode", "OnTakeTaxiNode", true)
end

function Traveler:OnTakeTaxiNode(slot)
    self:Debug("OnTakeTaxiNode "..slot)
    local name = TaxiNodeName(slot)
    self:JourneyAddFlyTo(slot, name)
end
