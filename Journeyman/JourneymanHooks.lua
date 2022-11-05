local addonName, addon = ...
local Hooks = addon:NewModule("Hooks", "AceHook-3.0")
local L = addon.Locale

local Journeys, TaxiNodes, State

function Hooks:OnInitialize()
    Journeys = addon.Journeys
    TaxiNodes = addon.TaxiNodes
    State = addon.State
end

function Hooks:OnEnable()
    self:Hook("TakeTaxiNode", "OnTakeTaxiNode", true)
end

function Hooks:OnDisable()
end

function Hooks:OnTakeTaxiNode(slot)
    local taxiNodeId = TaxiNodes:GetTaxiNodeIdFromSlot(slot, addon.player.factionName)
    if taxiNodeId then
        if addon:IsMyJourneyEnabled() and addon.db.profile.myJourney.stepTypeFlyTo then
            Journeys:OnTakeFlightPath(taxiNodeId)
        end
        if addon.db.char.window.show then
            addon.player.flyingTo = taxiNodeId
            State:OnTakeFlightPath(taxiNodeId)
        end
    end
end
