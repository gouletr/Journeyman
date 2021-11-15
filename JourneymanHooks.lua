local addonName, addon = ...
local Traveler = addon.Traveler
local L = addon.Locale

local function GetTaxiNodeId(slot)
    local name = TaxiNodeName(slot)
    if name then
        return Traveler:GetTaxiNodeIdFromLocalizedName(name)
    end
end

function Traveler:InitializeHooks()
    self:Hook("TakeTaxiNode", "OnTakeTaxiNode", true)
end

function Traveler:OnTakeTaxiNode(slot)
    local taxiNodeId = GetTaxiNodeId(slot)
    if taxiNodeId then
        self.State:OnTakeFlightPath(taxiNodeId)
        self.Journey:OnTakeFlightPath(taxiNodeId)
    end
end
