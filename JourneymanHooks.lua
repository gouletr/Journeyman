local addonName, addon = ...
local Journeyman = addon.Journeyman
local L = addon.Locale

local function GetTaxiNodeId(slot)
    local name = TaxiNodeName(slot)
    if name then
        return Journeyman:GetTaxiNodeIdFromLocalizedName(name)
    end
end

function Journeyman:InitializeHooks()
    self:Hook("TakeTaxiNode", "OnTakeTaxiNode", true)
end

function Journeyman:OnTakeTaxiNode(slot)
    local taxiNodeId = GetTaxiNodeId(slot)
    if taxiNodeId then
        self.flyingTo = taxiNodeId
        self.State:OnTakeFlightPath(taxiNodeId)
        self.Journey:OnTakeFlightPath(taxiNodeId)
    end
end
