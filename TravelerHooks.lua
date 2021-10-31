local addonName, addon = ...
local Traveler = addon.Traveler
local L = addon.Locale

function Traveler:InitializeHooks()
    self:Hook("TakeTaxiNode", "OnTakeTaxiNode", true)
end

function Traveler:OnTakeTaxiNode(slot)
    self:Debug("OnTakeTaxiNode "..slot)
    local name = TaxiNodeName(slot)
    self:JourneyAddFlyTo(slot, name)
end
