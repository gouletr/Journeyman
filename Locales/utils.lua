local addonName, addon = ...
local tinsert = table.insert

addon.LoadCSVData = function(input, key)
    --local now = GetTimePreciseSec()

    -- Substitute delimiters inside quotes
    input = input:gsub('%b""', function(x) return x:gsub(',', '|') end)

    -- Remove quotes on strings
    input = input:gsub('%b""', function(x) return x:gsub('"', '') end)

    -- Split into lines
    local lines = {}
    for line in input:gmatch("[^\r\n]+") do
        tinsert(lines, line)
    end

    -- Get field names from first line
    local keyExist = false
    local fields = {}
    for fieldName in lines[1]:gmatch("([^,]+)") do
        local name, index = fieldName:match("(%a+)%[(%d+)%]")
        if name and index then
            tinsert(fields, { name = name, index = index + 1 })
        else
            tinsert(fields, { name = fieldName })
        end
        if fieldName == key then
            keyExist = true
        end
    end

    -- If key doesn't exist, use first field as key
    if not keyExist then
        key = fields[1].name
    end

    -- Parse records starting at second line
    local db = {}
    for i = 2, #lines do
        local record = {}
        local fieldIndex = 1
        local line = lines[i]

        -- Split line into fields
        for fieldData in line:gmatch("([^,]+)") do
            fieldData = fieldData:gsub('|', ',') -- Put back delimiter

            -- Check if field data is number
            local asNumber = tonumber(fieldData)
            if asNumber then
                fieldData = asNumber
            end

            -- Set field value
            local field = fields[fieldIndex]
            if field.index then
                if record[field.name] == nil then
                    record[field.name] = {}
                end
                record[field.name][field.index] = fieldData
            else
                record[field.name] = fieldData
            end

            fieldIndex = fieldIndex + 1
        end

        -- Add record to db using key value
        db[record[key]] = record
    end

    --print(string.format("Load CSV took %.2fms", (GetTimePreciseSec() - now) * 1000))

    return db
end
