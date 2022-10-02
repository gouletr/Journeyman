local addonName, addon = ...
local Journeyman = addon.Journeyman
local L = addon.Locale

local TaxiNodes = Journeyman.TaxiNodes

function Journeyman:InitializeHooks()
    TaxiNodes = Journeyman.TaxiNodes
    self:Hook("TakeTaxiNode", "OnTakeTaxiNode", true)
end

function Journeyman:OnTakeTaxiNode(slot)
    local taxiNodeId = TaxiNodes:GetTaxiNodeIdFromSlot(slot)
    if taxiNodeId then
        if Journeyman:IsCharacterJourneyEnabled() and Journeyman.db.profile.myJourney.stepTypeFlyTo then
            self.Journey:OnTakeFlightPath(taxiNodeId)
        end
        if self.db.char.window.show then
            self.flyingTo = taxiNodeId
            self.State:OnTakeFlightPath(taxiNodeId)
        end
    end
end
