-- LibCollections is a utility API to handle all kinds of collections
local MAJOR, MINOR = "LibCollections-1.0", 0
assert(LibStub, MAJOR.." requires LibStub")

local LibCollections, oldminor = LibStub:NewLibrary(MAJOR, MINOR)
if not LibCollections then return end -- No upgrade needed

local List = {}
LibCollections.List = List

local Dictionary = {}
LibCollections.Dictionary = Dictionary

-- Lua APIs
local tinsert, tremove, tsort = table.insert, table.remove, table.sort

-- Adds the item to the end of the list.
function List:Add(list, item)
    tinsert(list, item)
end

-- Adds the items to the end of the list.
function List:AddRange(list, items)
    local n = #items
    for i = 1, n do
        tinsert(list, items[i])
    end
end

-- Determines whether all items of a list satisfies a predicate, or true if the list is empty.
function List:All(list, predicate)
    local n = #list
    for i = 1, n do
        if predicate(list[i]) == false then
            return false
        end
    end
    return true
end

-- Determines whether any item of a list satisfies a predicate, or false if the list is empty.
function List:Any(list, predicate)
    local n = #list
    for i = 1, n do
        if predicate == nil or predicate(list[i]) == true then
            return true
        end
    end
    return false
end

-- Removes all items from the list.
function List:Clear(list)
    local n = #list
    for i = 1, n do
        list[i] = nil
    end
end

-- Returns whether an item is in the list.
function List:Contains(list, item)
    local n = #list
    for i = 1, n do
        if list[i] == item then
            return true
        end
    end
    return false
end

-- Returns the number of items that satisfies a specified predicate or the number of items in the list.
function List:Count(list, predicate)
    local n = #list
    if predicate == nil then
        return n
    end
    local c = 0
    for i = 1, n do
        if predicate(list[i]) == true then
            c = c + 1
        end
    end
    return c
end

-- Returns the first item that satisfies a specified predicate.
function List:First(list, predicate)
    local n = #list
    for i = 1, n do
        local item = list[i]
        if predicate == nil or predicate(item) == true then
            return item
        end
    end
end

-- Performs the specified action on each item of the list.
function List:ForEach(list, action)
    local n = #list
    for i = 1, n do
        action(list[i])
    end
end

-- Retrieve the index of the first occurrence of an item in the list, if found; otherwise, nil.
function List:IndexOf(list, item)
    local n = #list
    for i = 1, n do
        if list[i] == item then
            return i
        end
    end
end

-- Inserts the item into the list at the specified index.
function List:Insert(list, index, item)
    if index >= 1 and index <= #list + 1 then
        tinsert(list, index, item)
    end
end

-- Inserts the items into the list at the specified index.
function List:InsertRange(list, index, items)
    if index >= 1 and index <= #list + 1 then
        local n = #items
        for i = 1, n do
            tinsert(list, index + i - 1, items[i])
        end
    end
end

-- Returns the last item that satisfies a specified predicate.
function List:Last(list, predicate)
    local n = #list
    for i = n, 1, -1 do
        local item = list[i]
        if predicate == nil or predicate(item) == true then
            return item
        end
    end
end

-- Returns the index of the last occurrence of an item in the list, if found; otherwise, nil.
function List:LastIndexOf(list, item)
    local n = #list
    for i = n, 1, -1 do
        if list[i] == item then
            return i
        end
    end
end

-- Removes the first occurrence of a specific item from the list. Returns true if the item was removed, false otherwise.
function List:Remove(list, item)
    local n = #list
    for i = 1, n do
        if list[i] == item then
            tremove(list, i)
            return true
        end
    end
    return false
end

-- Removes all the items that match the specified predicate. Returns the number of items removed from the list.
function List:RemoveAll(list, predicate)
    local c = 0
    local n = #list
    for i = n, 1, -1 do
        if predicate(list[i]) == true then
            tremove(list, i)
            c = c + 1
        end
    end
    return c
end

-- Removes the item at the specified index of the list.
function List:RemoveAt(list, index)
    if index >= 1 and index <= #list then
        tremove(list, index)
    end
end

-- Removes a range of items from the list.
function List:RemoveRange(list, index, count)
    local n = #list
    for i = index + count - 1, index, -1 do
        tremove(list, i)
    end
end

-- Reverses the order of the items in the list.
function List:Reverse(list)
    local tmp = {}
    local n = #list
    for i = 1, n do
        tmp[i] = list[i]
    end
    for i = 1, n do
        list[i] = tmp[n + 1 - i]
    end
end

-- Projects each item of the list into a new form.
function List:Select(list, selector)
    local result = {}
    local n = #list
    for i = 1, n do
        local value = selector(list[i])
        if value ~= nil then
            tinsert(result, value)
        end
    end
    return result
end

-- Determines whether two lists are equal according to an equality comparer.
function List:SequenceEqual(list1, list2, comparer)
    local n1, n2 = #list1, #list2
    if n1 ~= n2 then
        return false
    end
    for i = 1, n1 do
        local value1 = list1[i]
        local value2 = list2[i]
        if (comparer and not comparer(value1, value2)) or value1 ~= value2 then
            return false
        end
    end
    return true
end

-- Sorts the items in the list using either the specified or default comparison implementation.
function List:Sort(list, comparison)
    tsort(list, comparison)
end

-- Filters the list based on a predicate.
function List:Where(list, predicate)
    local result = {}
    local n = #list
    for i = 1, n do
        local item = list[i]
        if predicate(item) == true then
            tinsert(result, item)
        end
    end
    return result
end

-- Adds the specified key and value to the dictionary, only if it doesn't exists already. Returns if the key value pair was added.
function Dictionary:Add(dict, key, value)
    if dict[key] == nil then
        dict[key] = value
        return true
    end
    return false
end

-- Determines whether all items of the dictionary satisfies a predicate, or true if the dictionary is empty.
function Dictionary:All(dict, predicate)
    for k, v in pairs(dict) do
        if predicate(k, v) == false then
            return false
        end
    end
    return true
end

-- Determines whether any item of the dictionary satisfies a predicate, or false if the dictionary is empty.
function Dictionary:Any(dict, predicate)
    for k, v in pairs(dict) do
        if predicate == nil or predicate(k, v) == true then
            return true
        end
    end
    return false
end

-- Removes all keys and values from the dictionary.
function Dictionary:Clear(dict)
    for k in pairs(dict) do
        dict[k] = nil
    end
end

-- Determines whether the dictionary contains the specified key.
function Dictionary:ContainsKey(dict, key)
    return dict[key] ~= nil
end

-- Determines whether the dictionary contains a specific value.
function Dictionary:ContainsValue(dict, value)
    for _, v in pairs(dict) do
        if v == value then
            return true
        end
    end
    return false
end

-- Returns the number of items that satisfies a specified predicate or the number of items in the dictionary.
function Dictionary:Count(dict, predicate)
    local c = 0
    for k, v in pairs(dict) do
        if predicate == nil or predicate(k, v) == true then
            c = c + 1
        end
    end
    return c
end

-- Performs the specified action on each item of the dictionary.
function Dictionary:ForEach(dict, action)
    for k, v in pairs(dict) do
        action(k, v)
    end
end

-- Removes the value with the specified key from the dictionary. Returns true if the element is successfully removed, false otherwise.
function Dictionary:Remove(dict, key)
    if dict[key] == nil then
        return false
    end
    dict[key] = nil
    return true
end

-- Removes all the items that match the specified predicate. Returns the number of items removed from the dictionary.
function Dictionary:RemoveAll(dict, predicate)
    local keys = {}
    for k in pairs(dict) do
        if predicate(k, v) == true then
            tinsert(keys, k)
        end
    end
    local n = #keys
    for i = 1, n do
        dict[keys[i]] = nil
    end
    return n
end

-- Projects each item of the dictionary into a new form.
function Dictionary:Select(dict, selector)
    local result = {}
    for k, v in pairs(dict) do
        local value = selector(k, v)
        if value ~= nil then
            tinsert(result, value)
        end
    end
    return result
end

-- Filters the dictionary based on a predicate.
function Dictionary:Where(dict, predicate)
    local result = {}
    for k, v in pairs(dict) do
        if predicate(k, v) == true then
            result[k] = v
        end
    end
    return result
end

LibCollections.RunTests = function()
    local function TestListAdd()
        local list = {}
        List:Add(list, 1)
        assert(List:SequenceEqual(list, {1}) == true)
        List:Add(list, 2)
        assert(List:SequenceEqual(list, {1, 2}) == true)
        List:Add(list, 2)
        assert(List:SequenceEqual(list, {1, 2, 2}) == true)
    end

    local function TestListAddRange()
        local list = {}
        List:AddRange(list, {1})
        assert(List:SequenceEqual(list, {1}) == true)
        List:AddRange(list, {2, 3})
        assert(List:SequenceEqual(list, {1, 2, 3}) == true)
        List:AddRange(list, {4, 5, 6})
        assert(List:SequenceEqual(list, {1, 2, 3, 4, 5, 6}) == true)
    end

    local function TestListAll()
        local list = {1, 2, 3, 4, 5}
        assert(List:All(list, function(v) return v > 0 and v < 6 end) == true)
        assert(List:All(list, function(v) return v == 3 end) == false)
        assert(List:All({}, function(v) return v == 0 end) == true)
    end

    local function TestListAny()
        local list = {1, 2, 3, 4, 5}
        assert(List:Any(list) == true)
        assert(List:Any(list, function(v) return v == 3 end) == true)
        assert(List:Any(list, function(v) return v == 10 end) == false)
        assert(List:Any({}) == false)
        assert(List:Any({}, function(v) return v == 0 end) == false)
    end

    local function TestListClear()
        local list = {1, 2, 3, 4, 5}
        List:Clear(list)
        assert(List:SequenceEqual(list, {}) == true)
        assert(List:SequenceEqual(list, {1, 2, 3, 4, 5}) == false)
    end

    local function TestListContains()
        local list = {1, 2, 3, 4, 5}
        assert(List:Contains(list, 3) == true)
        assert(List:Contains(list, 10) == false)
    end

    local function TestListCount()
        local list = {1, 2, 3, 2, 3, 4}
        assert(List:Count(list) == 6)
        assert(List:Count(list, function(v) return v == 1 end) == 1)
        assert(List:Count(list, function(v) return v == 2 end) == 2)
        assert(List:Count(list, function(v) return v == 3 end) == 2)
        assert(List:Count(list, function(v) return v == 4 end) == 1)
        assert(List:Count({}) == 0)
        assert(List:Count({}, function(v) return v == 1 end) == 0)
    end

    local function TestListFirst()
        local list = {1, 2, 3, 4, 5}
        assert(List:First(list) == 1)
        assert(List:First(list, function(v) return v == 3 end) == 3)
        assert(List:First(list, function(v) return v == 10 end) == nil)
        assert(List:First({}) == nil)
        assert(List:First({}, function(v) return v == 0 end) == nil)
    end

    local function TestListForEach()
        local list = {1, 2, 3, 4, 5}
        local result = {}
        List:ForEach(list, function(v) tinsert(result, v + 10) end)
        assert(List:SequenceEqual(result, {11, 12, 13, 14, 15}) == true)
    end

    local function TestListIndexOf()
        local list = {11, 11, 12, 13, 13}
        assert(List:IndexOf(list, 11) == 1)
        assert(List:IndexOf(list, 12) == 3)
        assert(List:IndexOf(list, 13) == 4)
        assert(List:IndexOf(list, 1) == nil)
        assert(List:IndexOf({}, 1) == nil)
    end

    local function TestListInsert()
        local list = {2, 4}
        List:Insert(list, 1, 1)
        assert(List:SequenceEqual(list, {1, 2, 4}) == true)
        List:Insert(list, 4, 5)
        assert(List:SequenceEqual(list, {1, 2, 4, 5}) == true)
        List:Insert(list, 3, 3)
        assert(List:SequenceEqual(list, {1, 2, 3, 4, 5}) == true)
        List:Insert(list, 0, 0)
        assert(List:SequenceEqual(list, {1, 2, 3, 4, 5}) == true)
        List:Insert(list, -1, -1)
        assert(List:SequenceEqual(list, {1, 2, 3, 4, 5}) == true)
        List:Insert(list, 10, 10)
        assert(List:SequenceEqual(list, {1, 2, 3, 4, 5}) == true)

        do
            local empty = {}
            List:Insert(empty, -1, -1)
            assert(List:SequenceEqual(empty, {}) == true)
        end

        do
            local empty = {}
            List:Insert(empty, 0, 0)
            assert(List:SequenceEqual(empty, {}) == true)
        end

        do
            local empty = {}
            List:Insert(empty, 1, 1)
            assert(List:SequenceEqual(empty, {1}) == true)
        end

        do
            local empty = {}
            List:Insert(empty, 2, 2)
            assert(List:SequenceEqual(empty, {}) == true)
        end
    end

    local function TestListInsertRange()
        local list = {}
        List:InsertRange(list, 1, {3})
        assert(List:SequenceEqual(list, {3}) == true)
        List:InsertRange(list, 1, {1, 2})
        assert(List:SequenceEqual(list, {1, 2, 3}) == true)
        List:InsertRange(list, 4, {4, 5})
        assert(List:SequenceEqual(list, {1, 2, 3, 4, 5}) == true)
        List:InsertRange(list, 3, {0, 0})
        assert(List:SequenceEqual(list, {1, 2, 0, 0, 3, 4, 5}) == true)
        List:InsertRange(list, 0, {0, 0})
        assert(List:SequenceEqual(list, {1, 2, 0, 0, 3, 4, 5}) == true)
        List:InsertRange(list, -1, {-1, -1})
        assert(List:SequenceEqual(list, {1, 2, 0, 0, 3, 4, 5}) == true)
        List:InsertRange(list, 10, {10, 11})
        assert(List:SequenceEqual(list, {1, 2, 0, 0, 3, 4, 5}) == true)

        do
            local empty = {}
            List:InsertRange(empty, -1, {1, 2, 3})
            assert(List:SequenceEqual(empty, {}) == true)
        end

        do
            local empty = {}
            List:InsertRange(empty, 0, {1, 2, 3})
            assert(List:SequenceEqual(empty, {}) == true)
        end

        do
            local empty = {}
            List:InsertRange(empty, 1, {1, 2, 3})
            assert(List:SequenceEqual(empty, {1, 2, 3}) == true)
        end

        do
            local empty = {}
            List:Insert(empty, 2, {1, 2, 3})
            assert(List:SequenceEqual(empty, {}) == true)
        end
    end

    local function TestListLast()
        local list = {1, 2, 3, 4, 5}
        assert(List:Last(list) == 5)
        assert(List:Last(list, function(v) return v == 3 end) == 3)
        assert(List:Last(list, function(v) return v == 10 end) == nil)
        assert(List:Last({}) == nil)
        assert(List:Last({}, function(v) return v == 0 end) == nil)
    end

    local function TestListLastIndexOf()
        local list = {11, 11, 12, 13, 13}
        assert(List:LastIndexOf(list, 11) == 2)
        assert(List:LastIndexOf(list, 12) == 3)
        assert(List:LastIndexOf(list, 13) == 5)
        assert(List:LastIndexOf(list, 1) == nil)
        assert(List:LastIndexOf({}, 1) == nil)
    end

    local function TestListRemove()
        local list = {1, 2, 3, 4, 5}
        assert(List:Remove(list, 3) == true)
        assert(List:SequenceEqual(list, {1, 2, 4, 5}) == true)
        assert(List:Remove(list, 3) == false)
        assert(List:SequenceEqual(list, {1, 2, 4, 5}) == true)
        assert(List:Remove({}, 1) == false)

        local duplicates = {1, 2, 1, 2, 1, 2}
        assert(List:Remove(duplicates, 1) == true)
        assert(List:SequenceEqual(duplicates, {2, 1, 2, 1, 2}) == true)
        assert(List:Remove(duplicates, 1) == true)
        assert(List:SequenceEqual(duplicates, {2, 2, 1, 2}) == true)
        assert(List:Remove(duplicates, 1) == true)
        assert(List:SequenceEqual(duplicates, {2, 2, 2}) == true)
        assert(List:Remove(duplicates, 1) == false)
        assert(List:SequenceEqual(duplicates, {2, 2, 2}) == true)
        assert(List:Remove(duplicates, 2) == true)
        assert(List:SequenceEqual(duplicates, {2, 2}) == true)
        assert(List:Remove(duplicates, 2) == true)
        assert(List:SequenceEqual(duplicates, {2}) == true)
        assert(List:Remove(duplicates, 2) == true)
        assert(List:SequenceEqual(duplicates, {}) == true)
        assert(List:Remove(duplicates, 2) == false)
        assert(List:SequenceEqual(duplicates, {}) == true)
    end

    local function TestListRemoveAll()
        local list = {1, 2, 3, 4, 5}
        assert(List:RemoveAll(list, function(v) return v == 3 end) == 1)
        assert(List:SequenceEqual(list, {1, 2, 4, 5}) == true)
        assert(List:RemoveAll(list, function(v) return v == 3 end) == 0)
        assert(List:SequenceEqual(list, {1, 2, 4, 5}) == true)
        assert(List:RemoveAll({}, function(v) return v == 1 end) == 0)

        local duplicates = {1, 2, 1, 2, 1, 2}
        assert(List:RemoveAll(duplicates, function(v) return v == 1 end) == 3)
        assert(List:SequenceEqual(duplicates, {2, 2, 2}) == true)
        assert(List:RemoveAll(duplicates, function(v) return v == 1 end) == 0)
        assert(List:SequenceEqual(duplicates, {2, 2, 2}) == true)
        assert(List:RemoveAll(duplicates, function(v) return v == 2 end) == 3)
        assert(List:SequenceEqual(duplicates, {}) == true)
        assert(List:RemoveAll(duplicates, function(v) return v == 2 end) == 0)
        assert(List:SequenceEqual(duplicates, {}) == true)
    end

    local function TestListRemoveAt()
        local list = {1, 2, 3, 4, 5}
        List:RemoveAt(list, 1)
        assert(List:SequenceEqual(list, {2, 3, 4, 5}) == true)
        List:RemoveAt(list, 4)
        assert(List:SequenceEqual(list, {2, 3, 4}) == true)
        List:RemoveAt(list, 2)
        assert(List:SequenceEqual(list, {2, 4}) == true)
        List:RemoveAt(list, 0)
        assert(List:SequenceEqual(list, {2, 4}) == true)
        List:RemoveAt(list, -1)
        assert(List:SequenceEqual(list, {2, 4}) == true)
        List:RemoveAt(list, 3)
        assert(List:SequenceEqual(list, {2, 4}) == true)

        local empty = {}
        List:RemoveAt(empty, 1)
        assert(List:SequenceEqual(empty, {}) == true)
        List:RemoveAt(empty, 0)
        assert(List:SequenceEqual(empty, {}) == true)
        List:RemoveAt(empty, -1)
        assert(List:SequenceEqual(empty, {}) == true)
    end

    local function TestListRemoveRange()
        local list = {1, 2, 3, 4, 5}
        List:RemoveRange(list, 2, 3)
        assert(List:SequenceEqual(list, {1, 5}) == true)
    end

    local function TestListReverse()
        local list = {1, 2, 3, 4, 5}
        List:Reverse(list)
        assert(List:SequenceEqual(list, {5, 4, 3, 2, 1}) == true)
    end

    local function TestListSelect()
        local list = {1, 2, 3, 4, 5}
        assert(List:SequenceEqual(List:Select(list, function(v) if v > 3 then return v end end), {4, 5}) == true)
        assert(List:SequenceEqual(List:Select(list, function(v) return v > 3 end), {false, false, false, true, true}) == true)
        assert(List:SequenceEqual(List:Select(list, function(v) return tostring(v) end), {"1", "2", "3", "4", "5"}) == true)
        assert(List:SequenceEqual(List:Select({}, function(v) return v end), {}) == true)
    end

    local function TestListSequenceEqual()
        local list = {1, 2, 3, 4, 5}
        assert(List:SequenceEqual(list, {1, 2, 3, 4, 5}) == true)
        assert(List:SequenceEqual(list, {5, 4, 3, 2, 1}) == false)
        assert(List:SequenceEqual(list, {1, 2, 3}) == false)
        assert(List:SequenceEqual(list, {3, 4, 5}) == false)
        assert(List:SequenceEqual(list, {}) == false)
        assert(List:SequenceEqual({}, {}) == true)
    end

    local function TestListSort()
        local list = {3, 2, 5, 4, 1}
        List:Sort(list)
        assert(List:SequenceEqual(list, {1, 2, 3, 4, 5}) == true)

        local complex = {{dist = 4}, {dist = 3}, {dist = 5}, {dist = 2}, {dist = 1}}
        List:Sort(complex, function(lhs, rhs) return lhs.dist < rhs.dist end)
        assert(complex[1].dist == 1)
        assert(complex[2].dist == 2)
        assert(complex[3].dist == 3)
        assert(complex[4].dist == 4)
        assert(complex[5].dist == 5)
    end

    local function TestListWhere()
        local list = {1, 2, 3, 4, 5}
        assert(List:SequenceEqual(List:Where(list, function(v) return v > 3 end), {4, 5}) == true)
        assert(List:SequenceEqual(List:Where(list, function(v) if v > 3 then return v end end), {}) == true)
        assert(List:SequenceEqual(List:Where(list, function(v) return tostring(v) end), {}) == true)
        assert(List:SequenceEqual(List:Where({}, function(v) return true end), {}) == true)
    end

    local function TestDictionaryAdd()
        local dict = {}
        assert(dict["hi"] == nil)
        assert(Dictionary:Count(dict) == 0)
        Dictionary:Add(dict, "hi", 42)
        assert(dict["hi"] == 42)
        assert(Dictionary:Count(dict) == 1)
        Dictionary:Add(dict, "hi", 53)
        assert(dict["hi"] == 42)
        assert(Dictionary:Count(dict) == 1)
    end

    local function TestDictionaryAll()
        local dict = {["Monday"] = 1, ["Tuesday"] = 2, ["Wednesday"] = 3, ["Thursday"] = 4, ["Friday"] = 5}
        assert(Dictionary:All(dict, function(k, v) return k:find("day") ~= nil end) == true)
        assert(Dictionary:All(dict, function(k, v) return v > 0 and v < 6 end) == true)
        assert(Dictionary:All(dict, function(k, v) return k:find("sday") ~= nil end) == false)
        assert(Dictionary:All(dict, function(k, v) return v == 1 end) == false)
        assert(Dictionary:All({}, function(k, v) return true end) == true)
    end

    local function TestDictionaryAny()
        local dict = {["Monday"] = 1, ["Tuesday"] = 2, ["Wednesday"] = 3, ["Thursday"] = 4, ["Friday"] = 5}
        assert(Dictionary:Any(dict) == true)
        assert(Dictionary:Any({}) == false)
        assert(Dictionary:Any(dict, function(k, v) return k:find("Mon") ~= nil end) == true)
        assert(Dictionary:Any(dict, function(k, v) return v == 1 end) == true)
        assert(Dictionary:Any(dict, function(k, v) return k:find("Sun") ~= nil end) == false)
        assert(Dictionary:Any(dict, function(k, v) return v < 1 or v > 5 end) == false)
        assert(Dictionary:Any({}, function(k, v) return true end) == false)
    end

    local function TestDictionaryClear()
        local dict = {["Monday"] = 1, ["Tuesday"] = 2, ["Wednesday"] = 3, ["Thursday"] = 4, ["Friday"] = 5}
        Dictionary:Clear(dict)
        assert(Dictionary:Count(dict) == 0)
        assert(dict["Monday"] == nil)
        assert(dict["Tuesday"] == nil)
        assert(dict["Wednesday"] == nil)
        assert(dict["Thursday"] == nil)
        assert(dict["Friday"] == nil)
    end

    local function TestDictionaryContainsKey()
        local dict = {["Monday"] = 1, ["Tuesday"] = 2, ["Wednesday"] = 3, ["Thursday"] = 4, ["Friday"] = 5}
        assert(Dictionary:ContainsKey(dict, "Monday") == true)
        assert(Dictionary:ContainsKey(dict, "Sunday") == false)
        assert(Dictionary:ContainsKey({}, "Monday") == false)
    end

    local function TestDictionaryContainsValue()
        local dict = {["Monday"] = 1, ["Tuesday"] = 2, ["Wednesday"] = 3, ["Thursday"] = 4, ["Friday"] = 5}
        assert(Dictionary:ContainsValue(dict, 1) == true)
        assert(Dictionary:ContainsValue(dict, 10) == false)
        assert(Dictionary:ContainsValue({}, nil) == false)
    end

    local function TestDictionaryCount()
        local dict = {["Monday"] = 1, ["Tuesday"] = 2, ["Wednesday"] = 3, ["Thursday"] = 4, ["Friday"] = 5}
        assert(Dictionary:Count(dict) == 5)
        assert(Dictionary:Count({}) == 0)
        assert(Dictionary:Count(dict, function(k, v) return v == 1 end) == 1)
        assert(Dictionary:Count({}, function(k, v) return true end) == 0)
    end

    local function TestDictionaryForEach()
        local result = {}
        do
            local dict = {["Monday"] = 1, ["Tuesday"] = 2, ["Wednesday"] = 3, ["Thursday"] = 4, ["Friday"] = 5}
            Dictionary:ForEach(dict, function(k, v) result[k] = v end)
        end
        assert(Dictionary:Count(result) == 5)
        assert(result["Monday"] == 1)
        assert(result["Tuesday"] == 2)
        assert(result["Wednesday"] == 3)
        assert(result["Thursday"] == 4)
        assert(result["Friday"] == 5)
    end

    local function TestDictionaryRemove()
        local dict = {["Monday"] = 1, ["Tuesday"] = 2, ["Wednesday"] = 3, ["Thursday"] = 4, ["Friday"] = 5}
        assert(Dictionary:Remove(dict, "Monday") == true)
        assert(Dictionary:Count(dict) == 4)
        assert(Dictionary:Remove(dict, "Monday") == false)
        assert(Dictionary:Count(dict) == 4)
        assert(Dictionary:Remove({}, "Monday") == false)
    end

    local function TestDictionaryRemoveAll()
        local dict = {["Monday"] = 1, ["Tuesday"] = 2, ["Wednesday"] = 3, ["Thursday"] = 4, ["Friday"] = 5}
        assert(Dictionary:RemoveAll(dict, function(k, v) return k:find("sday") ~= nil end) == 3)
        assert(Dictionary:Count(dict) == 2)
        assert(Dictionary:RemoveAll(dict, function(k, v) return k:find("sday") ~= nil end) == 0)
        assert(Dictionary:Count(dict) == 2)
        assert(Dictionary:RemoveAll({}, function(k, v) return true end) == 0)
    end

    local function TestDictionarySelect()
        local dict = {["Monday"] = 1, ["Tuesday"] = 2, ["Wednesday"] = 3, ["Thursday"] = 4, ["Friday"] = 5}
        do
            local result = Dictionary:Select(dict, function(k, v) if v > 3 then return v end end)
            assert(List:Contains(result, 1) == false)
            assert(List:Contains(result, 2) == false)
            assert(List:Contains(result, 3) == false)
            assert(List:Contains(result, 4) == true)
            assert(List:Contains(result, 5) == true)
        end
        do
            local result = Dictionary:Select(dict, function(k, v) return v > 3 end)
            assert(List:Count(result, function(v) return v == true end) == 2)
            assert(List:Count(result, function(v) return v == false end) == 3)
        end
        do
            local result = Dictionary:Select(dict, function(k, v) return tostring(v) end)
            assert(List:Contains(result, "Monday") == false)
            assert(List:Contains(result, "Tuesday") == false)
            assert(List:Contains(result, "Wednesday") == false)
            assert(List:Contains(result, "Thursday") == false)
            assert(List:Contains(result, "Friday") == false)
            assert(List:Contains(result, "1") == true)
            assert(List:Contains(result, "2") == true)
            assert(List:Contains(result, "3") == true)
            assert(List:Contains(result, "4") == true)
            assert(List:Contains(result, "5") == true)
        end
        do
            local result = Dictionary:Select({}, function(k, v) return v end)
            assert(List:SequenceEqual(result, {}) == true)
        end
    end

    local function TestDictionaryWhere()
        local dict = {["Monday"] = 1, ["Tuesday"] = 2, ["Wednesday"] = 3, ["Thursday"] = 4, ["Friday"] = 5}
        local result = Dictionary:Where(dict, function(k, v) return k:find("sday") ~= nil end)
        assert(Dictionary:Count(result) == 3)
        assert(Dictionary:ContainsKey(result, "Monday") == false)
        assert(Dictionary:ContainsKey(result, "Tuesday") == true)
        assert(Dictionary:ContainsKey(result, "Wednesday") == true)
        assert(Dictionary:ContainsKey(result, "Thursday") == true)
        assert(Dictionary:ContainsKey(result, "Friday") == false)
        assert(Dictionary:ContainsValue(result, 1) == false)
        assert(Dictionary:ContainsValue(result, 2) == true)
        assert(Dictionary:ContainsValue(result, 3) == true)
        assert(Dictionary:ContainsValue(result, 4) == true)
        assert(Dictionary:ContainsValue(result, 5) == false)
    end

    TestListAdd()
    TestListAddRange()
    TestListAll()
    TestListAny()
    TestListClear()
    TestListContains()
    TestListCount()
    TestListFirst()
    TestListForEach()
    TestListIndexOf()
    TestListInsert()
    TestListInsertRange()
    TestListLast()
    TestListLastIndexOf()
    TestListRemove()
    TestListRemoveAll()
    TestListRemoveAt()
    TestListRemoveRange()
    TestListReverse()
    TestListSelect()
    TestListSequenceEqual()
    TestListSort()
    TestListWhere()

    TestDictionaryAdd()
    TestDictionaryAll()
    TestDictionaryAny()
    TestDictionaryClear()
    TestDictionaryContainsKey()
    TestDictionaryContainsValue()
    TestDictionaryCount()
    TestDictionaryForEach()
    TestDictionaryRemove()
    TestDictionaryRemoveAll()
    TestDictionarySelect()
    TestDictionaryWhere()

    return true
end
