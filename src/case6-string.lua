---
--- Created by damon4u.
--- DateTime: 2018/12/12 下午4:28
---
-- 由于 string.byte 只返回整数，而并不像 string.sub 等函数那样（尝试）创建新的 Lua 字符串， 因此使用 string.byte 来进行字符串相关的扫描和分析是最为高效的
local function testByte()
    print(string.byte("abc", 1, 3))
    print(string.byte("哈哈哈", 1, 3))
end
testByte()

-- 接收 0 个或更多的整数（整数范围：0~255），返回这些整数所对应的 ASCII 码字符组成的字符串。
-- 当参数为空时，默认是一个 0。
-- 此函数特别适合从具体的字节构造出二进制字符串。这经常比使用 table.concat 函数和 .. 连接运算符更加高效。
local function testChar()
    print(string.char(string.byte("哈")))
    print(string.char(97))
end
testChar()

local function testLen()
    print(string.len("hello"))
    -- 应当总是使用 # 运算符来获取 Lua 字符串的长度。
    print(#"hello")
end
testLen()

local function testFind()
    local find = string.find
    print(find("abc cba", "ab"))
    print(find("abc cba", "ab", 2))
    print(find("abc cba", "ba", -1))  -- 当 init 为负数时，表示从 s 字符串的 string.len(s) + init 索引处开始向后匹配字符串 p 
    print(find("abc cba", "ba", -2))  -- 当 init 为负数时，表示从 s 字符串的 string.len(s) + init 索引处开始向后匹配字符串 p 
    print(find("abc cba", "(%a+)", 1))  -- 从索引为1处匹配最长连续且只含字母的字符串
    print(find("abc cba", "(%a+)", 1, true)) --从索引为1的位置开始匹配字符串：(%a+)
end
testFind()

local function testMatch()
    print(string.match("hello lua", "lua"))
    print(string.match("lua lua", "lua", 2))
    print(string.match("lua lua", "hello"))
    print(string.match("today is 27/7/2015", "%d+/%d+/%d+"))
end
testMatch()

-- 返回一个迭代器函数，通过这个迭代器函数可以遍历到在字符串 s 中出现模式串 p 的所有地方。
local function testGmatch()
    local str = "hello world from lua"
    for w in string.gmatch(str, "%a+") do
        print(w)
    end
end
testGmatch()

-- 将目标字符串 s 中所有的子串 p 替换成字符串 r。可选参数 n，表示限制替换次数。返回值有两个，第一个是被替换后的字符串，第二个是替换了多少次。
local function testGsub()
    print(string.gsub("lua lua lua", "lua", "hello"))
    print(string.gsub("lua lua lua", "lua", "hello", 2))
end
testGsub()