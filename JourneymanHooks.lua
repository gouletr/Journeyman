local addonName, addon = ...
local Journeyman = addon.Journeyman
local L = addon.Locale

function Journeyman:InitializeHooks()
    self:Hook("TakeTaxiNode", "OnTakeTaxiNode", true)
end

function Journeyman:OnTakeTaxiNode(slot)
    local taxiNodeId = self:GetTaxiNodeId(slot)
    if taxiNodeId then
        self.Journey:OnTakeFlightPath(taxiNodeId)
        if self.db.char.window.show then
            self.flyingTo = taxiNodeId
            self.State:OnTakeFlightPath(taxiNodeId)
        end
    end
end
