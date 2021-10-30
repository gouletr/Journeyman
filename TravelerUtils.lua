local addonName, addon = ...
local L = addon.Locale
local Traveler = addon.Traveler

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
