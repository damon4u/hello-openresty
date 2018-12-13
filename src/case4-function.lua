---
--- Created by damon4u.
--- DateTime: 2018/12/12 下午3:52
---

local function swap(a, b)
    local temp = a
    a = b
    b = temp
    print(a, b)
end

local x = "hello"
local y = 20
print(x, y)
swap(x, y)
print(x, y)

local function change(arg)
    arg.width = arg.width * 2
    arg.height = arg.height * 2
end

local rectangle = {width = 20, height = 15}
print("before change:", "width = ", rectangle.width,
        " height = ", rectangle.height)
change(rectangle)
print("after change:", "width = ", rectangle.width,
        " height = ", rectangle.height)

local s, e = string.find("hello world", "llo")
print(s, e)

local function swap1(a, b)
    return b, a
end
local n1 = 1
local n2 = 2
n1, n2 = swap1(n1, n2)
print(n1, n2)


-- 全动态函数调用
local function run(x, y)
    print('run', x, y)
end

local function attack(targetId)
    print('targetId', targetId)
end

local function do_action(method, ...)
    local args = {...} or {}
    method(table.unpack(args))
end

do_action(run, 1, 2)         -- output: run 1 2
do_action(attack, 1111)      -- output: targetId    1111