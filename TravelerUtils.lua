local addonName, addon = ...
local Traveler = addon.Traveler
local L = addon.Locale
local Utils = {}
Traveler.Utils = Utils

function Utils:Clone(t)
    local c
    if type(t) == "table" then
        c = {}
        for k, v in next, t, nil do
            c[self:Clone(k)] = self:Clone(v)
        end
        setmetatable(c, self:Clone(getmetatable(t)))
    else -- number, string, boolean, etc.
        c = t
    end
    return c
end

function Utils:Add(t, v)
    t[#t + 1] = v
end

function Utils:Remove(t, v)
    if t == nil then return end
    local j, n = 1, #t
    for i = 1, n do
        if t[i] ~= v then
            if i ~= j then
                t[j] = t[i]
                t[i] = nil
            end
            j = j + 1
        else
            t[i] = nil
        end
    end
end

function Utils:RemoveIf(t, f)
    if t == nil then return end
    local j, n = 1, #t
    for i = 1, n do
        if not f(i) then
            if i ~= j then
                t[j] = t[i]
                t[i] = nil
            end
            j = j + 1
        else
            t[i] = nil
        end
    end
end

function Utils:CreateLabel(name, parent, clickable)
    local label
    if clickable then
        label = CreateFrame("BUTTON", name, parent, BackdropTemplateMixin and "BackdropTemplate")
    else
        label = CreateFrame("FRAME", name, parent, BackdropTemplateMixin and "BackdropTemplate")
    end

    local fontString = label:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    fontString:SetAllPoints(label)
    fontString:SetFontObject("GameFontNormal")

    label.fontString = fontString
    label.SetText = function(self, fmt, ...) self.fontString:SetFormattedText(fmt, ...) end
    label.SetFontSize = function(self, size) self.fontString:SetFont(GameFontNormal:GetFont(), size) end
    label.SetTextColor = function(self, r, g, b, a) self.fontString:SetTextColor(r, g, b, a) end
    label.SetJustifyH = function(self, value) self.fontString:SetJustifyH(value) end
    label.SetJustifyV = function(self, value) self.fontString:SetJustifyV(value) end
    label.SetWordWrap = function(self, value) self.fontString:SetWordWrap(value) end
    label.SetMaxLines = function(self, value) self.fontString:SetMaxLines(value) end
    label.GetTextColor = function(self) return self.fontString:GetTextColor() end
    label.GetNumLines = function(self) return self.fontString:GetNumLines() end
    return label
end
