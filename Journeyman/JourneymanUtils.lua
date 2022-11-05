local addonName, addon = ...
local Utils, Private = addon:NewModule("Utils"), {}
local L = addon.Locale

function Utils:OnInitialize()
end

function Utils:OnEnable()
end

function Utils:OnDisable()
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
