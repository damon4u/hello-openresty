---
--- Created by damon4u.
--- DateTime: 2018/12/12 下午5:59
---
local set1 = {10, 20, 30}   -- 集合
local set2 = {20, 40, 50}   -- 集合

-- 将用于重载__add的函数，注意第一个参数是self
local union = function (self, another)
    local set = {}
    local result = {}

    -- 利用数组来确保集合的互异性
    for _, j in pairs(self) do
        set[j] = true 
    end
    for _, j in pairs(another) do
        set[j] = true 
    end

    -- 加入结果集合
    for i, _ in pairs(set) do table.insert(result, i) end
    return result
end
setmetatable(set1, {__add = union}) -- 重载 set1 表的 __add 元方法

local set3 = set1 + set2
for _, j in pairs(set3) do
    print(j.." ")  
end

-- 重写toString方法
local arr = {1, 2, 3, 4}
arr = setmetatable(arr, {__tostring = function (self)
    local result = '{'
    local sep = ''
    for _, i in pairs(self) do
        result = result ..sep .. i
        sep = ', '
    end
    result = result .. '}'
    return result
end})
print(arr)  --> {1, 2, 3, 4}


-- 假如我们想保护我们的对象使其使用者既看不到也不能修改 metatable。
-- 我们可以对 metatable 设置了 __metatable 的值，getmetatable 将返回这个域的值，而调用 setmetatable 将会出错
local obj = setmetatable({}, { __metatable = "You cannot access here"})

print(getmetatable(obj)) --> You cannot access here
--setmetatable(obj, {})    --> 引发编译器报错