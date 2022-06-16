local addonName, addon = ...
local Journeyman = addon.Journeyman
local L = addon.Locale

local Utils = {}
Journeyman.Utils = Utils

local tinsert, tremove = table.insert, table.remove

function Utils:IsNilOrEmpty(value)
    return value == nil or type(value) ~= "string" or string.len(value) == 0
end

function Utils:Split(s, separator)
    local t = {}
    for v in string.gmatch(s, "([^"..separator.."]+)") do
        tinsert(t, v)
    end
    return t
end

function Utils:Join(separator, values)
    local result = ""
    local n = #values
    for i = 1, n do
        local value = values[i]
        if not self:IsNilOrEmpty(value) then
            result = result..value
            if i < n then
                result = result..separator
            end
        end
    end
    return result
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

function Utils:CountBits(value)
    if value == nil then
        return 0
    end
    local count = 0
    while value > 0 do
        value = bit.band(value, value - 1)
        count = count + 1
    end
    return count
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
