local addonName, addon = ...

addon.Traveler = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceHook-3.0", "AceEvent-3.0", "AceConsole-3.0")
addon.Locale = LibStub("AceLocale-3.0"):GetLocale(addonName)

local L = addon.Locale
local Traveler = addon.Traveler

function Traveler:OnInitialize()
    self:InitializeDatabase()
    self:InitializeOptions()
    self:InitializeHooks()
    self:InitializeEvents()
    self:InitializeJourney()
    self.Tracker:Initialize()
end

function Traveler:OnEnable()
    self:RegisterChatCommand("journey", function()
        self:Print(dump(self.journey))
    end, true)
    self.Tracker:Update()
end

function Traveler:OnDisable()
    self.Tracker:Shutdown()
end

function Traveler:Debug(...)
    if self.db.profile.advanced.debug then
        self:Print("[DEBUG] " .. ...)
    end
end

function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end
