---
--- Created by damon4u.
--- DateTime: 2018/12/12 下午4:19
---
local foo = {}

local function getName()
    return "Lucy"
end

function foo.greeting()
    print("hello " .. getName())
end

return foo