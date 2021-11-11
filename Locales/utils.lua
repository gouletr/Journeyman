local addonName, addon = ...
local tinsert = table.insert

addon.LoadCSVData = function(input)
    -- Split into lines
    local lines = {}
    for line in input:gmatch("[^\r\n]+") do
        tinsert(lines, line)
    end

    -- Get field names from first line
    local fieldNames = {}
    for fieldName in lines[1]:gmatch("([^,]+)") do
        tinsert(fieldNames, fieldName)
    end

    -- Parse records starting at second line
    local db = {}
    for i = 2, #lines do
        local record = {}
        local fieldIndex = 1
        local line = lines[i]

        -- Split line into fields
        for fieldData in line:gmatch("([^,]+)") do
            local asNumber = tonumber(fieldData)
            if asNumber then
                record[fieldNames[fieldIndex]] = asNumber
            else
                record[fieldNames[fieldIndex]] = fieldData
            end
            fieldIndex = fieldIndex + 1
        end

        -- Add record to db using field 1 as the key
        db[record[fieldNames[1]]] = record
    end

    return db
end
