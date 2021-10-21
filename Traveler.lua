local addonName, addon = ...

addon.Traveler = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceHook-3.0", "AceEvent-3.0", "AceConsole-3.0")
addon.Locale = LibStub("AceLocale-3.0"):GetLocale(addonName)

local L = addon.Locale
local Traveler = addon.Traveler
Traveler:SetEnabledState(false)

local Grail = Grail
local requiredGrailVersion = 116

function Traveler:OnInitialize()
    -- Check Grail version
    if Grail.versionNumber < requiredGrailVersion then
        self:Printf(L["GRAIL_VERSION_REQUIRED"], requiredGrailVersion)
        return
    else
        self:SetEnabledState(true)
    end
end

function Traveler:OnEnable()
    self:InitializeDatabase()
    self:InitializeOptions()
    self:InitializeHooks()
    self:InitializeEvents()
    self:InitializeTracker()
    self:InitializeJourney()

    self:RegisterChatCommand("journey", function()
        self:Print(dump(self.journey))
    end, true)

    if self.db.char.tracker.show then
        self:ShowTracker()
    else
        self:HideTracker()
    end
end

function Traveler:OnDisable()
end

function Traveler:Debug(...)
    if self.db.profile.general.debug then
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
