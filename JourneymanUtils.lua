local addonName, addon = ...
local Journeyman = addon.Journeyman
local L = addon.Locale
local Utils = {}
Journeyman.Utils = Utils

local tinsert = table.insert

function Utils:Contains(t, value)
    for i, v in ipairs(t) do
        if v == value then
            return true
        end
    end
    return false
end

function Utils:Split(s, separator)
    local t = {}
    for v in string.gmatch(s, "([^"..separator.."]+)") do
        tinsert(t, v)
    end
    return t
end

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

local random = math.random
function Utils:CreateGUID()
    local template ='xxxxxxxxxxxx4xxxyxxxxxxxxxxxxxxx'
    local guid = string.gsub(template, '[xy]', function(c)
        local v = (c == 'x') and random(0, 0xf) or random(8, 0xb)
        return string.format('%x', v)
    end)
    return guid
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
