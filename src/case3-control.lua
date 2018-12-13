---
--- Created by damon4u.
--- DateTime: 2018/12/12 下午3:16
---
local function testIf()
    local x = 10
    if x > 0 then
        print("x is a positive number")
    end

    if x > 0 then
        print("x is a positive number")
    else
        print("x is a non-positive number")
    end
    
    local score = 0
    if score == 100 then
        print("Very good!Your score is 100")
    elseif score >= 60 then
        print("Congratulations, you have passed it,your score greater or equal to 60")
    else
        print("Sorry, you do not pass the exam! ")
        if score > 0 then
            print("Your score is better than 0")
        else
            print("My God, your score turned out to be 0")
        end
    end
end
testIf()

local function testWhile()
    local x = 1
    local sum = 0
    while x <= 5 do
        sum = sum + x
        x = x + 1
    end
    print(sum)
end
testWhile()

local function testRepeat()
    local x = 1
    local sum = 0
    repeat
        sum = sum + x
        x = x + 1
    until x > 5
    print(sum)
end
testRepeat()

local function testFor()
    for i = 1, 5 do
        print(i)
    end

    for i = 1, 5, 2 do
        print(i)
    end
    
    -- Lua 的基础库提供了 ipairs，这是一个用于遍历数组的迭代器函数。
    -- 在每次循环中，i 会被赋予一个索引值，同时 v 被赋予一个对应于该索引的数组元素值。
    -- 标准库提供了几种迭代器，包括迭代 table 元素的（pairs）、迭代数组元素的（ipairs）、用于迭代文件中每行的（io.lines）、 迭代字符串中单词的（string.gmatch）等。
    local a = { 1, 2, 3, 4, 5}
    for i, v in ipairs(a) do
        print("key:"..i.." value:"..v)
    end
    
    local t = {a = 1, ["b"] = 2}
    for i, v in pairs(t) do
        print("key:"..i.." value:"..v)
    end
end
testFor()

local function testBreak()
    local t = {1, 3, 5, 7, 8, 11, 18}
    for i, v in ipairs(t) do
        if v == 11 then
            print("index[" .. i .. "] have right value[11]")
            break
        end
    end
end
testBreak()

