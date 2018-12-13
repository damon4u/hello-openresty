---
--- Created by damon4u.
--- DateTime: 2018/12/12 下午2:44
---

local function testOperator()
    print(1 + 2)
    print(5 / 10)
    print(5.0 / 10)
    print(10 / 0) -- inf 报错
    print(2 ^ 10)
    print(1357 % 2)
    
    print(1 < 2)
    print(1 == 2)
    print(1 ~= 2)
    local a, b = true, false
    print(a == b)
    
    -- 引用比较
    local f1 = { x = 1, y = 0}
    local f2 = { x = 1, y = 0}
    print(f1 == f2)
    
    -- 由于 Lua 字符串总是会被“内化”，即相同内容的字符串只会被保存一份，因此 Lua 字符串之间的相等性比较可以简化为其内部存储地址的比较。
    -- 这意味着 Lua 字符串的相等性比较总是为 O(1). 而在其他编程语言中，字符串的相等性比较则通常为 O(n)，即需要逐个字节（或按若干个连续字节）进行比较。
    local str1 = "hello world"
    local str2 = "hello world"
    print(str1 == str2)
    
    -- 所有逻辑操作符将 false 和 nil 视作假，其他任何值视作真，对于 and 和 or，“短路求值”，对于 not，永远只返回 true 或者 false。
    
    local c
    local d = 0
    local e = 100
    print(c and d)
    print(d and c)
    print(c and e)
    print(d and e)
    print(e and d)
    
    print(c or d)
    print(c or e)
    
    print(d or c)
    print(e or c)
    
    print(d or e)
    print(e or d)
    
    print(not c)
    print(not d)
    

end
testOperator()

local function testStringContract()
    print("hello " .. "world")
    print(0 .. 1)
    local str1 = string.format("%s-%s", "hello", "world")
    print(str1)
    local str2 = string.format("%d-%s-%.1f",123,"world",1.21)
    print(str2)
    
--    由于 Lua 字符串本质上是只读的，因此字符串连接运算符几乎总会创建一个新的（更大的）字符串。
--    这意味着如果有很多这样的连接操作（比如在循环中使用 .. 来拼接最终结果），则性能损耗会非常大。
--    在这种情况下，推荐使用 table 和 table.concat() 来进行很多字符串的拼接
end
testStringContract()