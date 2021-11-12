local addonName, addon = ...
local Traveler = addon.Traveler
local L = addon.Locale

function Traveler:InitializeHooks()
    self:Hook("TakeTaxiNode", "OnTakeTaxiNode", true)
end

function Traveler:OnTakeTaxiNode(slot)
    self:Debug("OnTakeTaxiNode %s", dump(slot))

    local name = TaxiNodeName(slot)
    Traveler:Debug("OnTakeTaxiNode taxi node name = %s", dump(name))

    local areaId = Traveler:GetAreaIdFromLocalizedName(name)
    Traveler:Debug("OnTakeTaxiNode areaId = %s", dump(areaId))

    self.State:OnTakeFlightPath(areaId)
    self.Journey:OnTakeFlightPath(areaId)
end
