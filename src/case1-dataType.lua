---
--- Created by damon4u.
--- DateTime: 2018/12/11 下午4:37
---
local function main()
    print(type("hello world"))
    print(type(print))
    print(type(true))
    print(type(12.2))
    print(type(nil))
end
main()

local function testBool()
    local a = true
    local b = 0
    local c
    if a then
        print("a")
    else
        print("not a")
    end

    if b then
        print("b")
    else
        print("not b")
    end

    if c then
        print("c")
    else
        print("not c")
    end
end
testBool()

local function testNumber()
    local order = 3.99
    local score = 98.01
    print(math.floor(order))
    print(math.ceil(score))
    --print(9223372036854775807LL - 1)
end
testNumber()

local function testString()
    local str1 = 'hello world'    
    local str2 = "hello lua"
    local str3 = [["add\name", 'hello']]
    local str4 = [=[string have a [[]].]=]
    print(str1)
    print(str2)
    print(str3)
    print(str4)
end
testString()

local function testTable()
    local corp = {
        web = "www.google.com",
        telephone = "12345678",
        staff = {"Jack", "Scott", "Gary"},
        100867,
        100191,
        [10] = 360,
        ["city"] = "Beijing"
    }
    print(corp.web)
    print(corp["telephone"])
    print(corp[2])
    print(corp["city"])
    print(corp.city)
    print(corp.staff[1])
    print(corp[10])
end
testTable()

local function foo()
    print("in the function")
    -- do something
    local x = 10
    local y = 20
    return x + y
end

local a = foo  -- 把函数赋值给变量

print(a())
