local addonName, addon = ...
local Traveler = addon.Traveler
local L = addon.Locale

function Traveler:InitializeHooks()
    self:Hook("TakeTaxiNode", "OnTakeTaxiNode", true)
end

function Traveler:OnTakeTaxiNode(slot)
    self:Debug("OnTakeTaxiNode %s", dump(slot))

    local name = TaxiNodeName(slot)
    if name then
        Traveler:Debug("OnTakeTaxiNode taxi node name = %s", dump(name))

        local areaName = string.match(name, "[^,]*")
        Traveler:Debug("OnTakeTaxiNode area name = %s", areaName)

        local areaId = Traveler:GetAreaIdFromLocalizedName(areaName)
        Traveler:Debug("OnTakeTaxiNode areaId = %s", dump(areaId))

        if areaId then
            self.State:OnTakeFlightPath(areaId)
            self.Journey:OnTakeFlightPath(areaId)
        end
    end
end
