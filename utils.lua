-- 因為是 utils 比較單純的 functions
-- 所以使用舊式 module 的寫法
-- 詳細的說明在此 https://goo.gl/gA5Vyf

module('utils', package.seeall)

function foreach(tbl, func)
    if not tbl then return end
    for k, v in pairs(tbl) do func(v) end
end

function map(tbl, func)
    local new_tbl = {}
    if not tbl then return new_tbl end
    for key, value in pairs(tbl) do
        local res = func(value)
        new_tbl[key] = res
    end
    return new_tbl
end

function imap(array, func)
    local new_array = {}
    if not array then return new_array end
    for idx, value in ipairs(array) do
        local res = func(value)
        new_array[idx] = res
    end
    return new_array
end

function file_exist(path)
    local f = io.open(path)
    if f then io.close(f); return true end
    return false
end

function deep_copy(obj)
    local function _copy(obj)
        if type(obj) ~= 'table' then return obj end
        local new_table = {}
        for key, value in pairs(obj) do
            new_table[_copy(key)] = _copy(value)
        end
        return setmetatable(new_table, getmetatable(obj))
    end
    return _copy(obj)
end

function free(obj)
    local function _free(obj)
        if type(obj) ~= 'table' then return end
        for key, value in pairs(obj) do
            if type(value) == 'table' then
                _free(value)
                if next(value) == nil then
                    obj[key] = nil
                end
            else
                obj[key] = nil
            end
        end
    end
    return _free(obj)
end

function split(str, delimiters)
    local elements = {}
    local pattern = '([^'..delimiters..']+)'
    str:gsub(pattern, function(value) elements[#elements + 1] = value;  end);
    return elements
end

function starts(str, start)
   return string.sub(str, 1, string.len(start)) == start
end
