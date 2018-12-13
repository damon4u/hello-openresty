---
--- Created by damon4u.
--- DateTime: 2018/12/12 下午5:08
---

-- Returns the elements from the given list.
local function testUnpack()
    local t = {1, 2, 3}
    print(table.unpack(t, 1, 2))
    
end
testUnpack()

local function testSort()
    local t = {1, 7, 4, 3, 25}
    table.sort(t)
    print(table.concat(t, ","))

    -- 自定义比较函数
    local function compare(x, y)
        return x > y
    end
    table.sort(t, compare)
    print(table.concat(t, ","))
end
testSort()

local function testInsert()
    local t = {1, 8}
    table.insert(t, 9)
    table.insert(t, 2, 2)
    print(table.concat(t, ","))
end
testInsert()

local function testRemove()
    local t = {1, 8, 2, 9}
    table.remove(t)
    print(table.concat(t, ","))
    table.remove(t, 1)
    print(table.concat(t, ","))
end
testRemove()