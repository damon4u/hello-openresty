---
--- Created by damon4u.
--- DateTime: 2018/12/12 下午5:29
---

-- 设置一个默认的输入或输出文件，然后在这个文件上进行所有的输入或输出操作。所有的操作函数由 io 表提供。
local function testIORead(fileName)
    local file = io.input(fileName)
    repeat
        local line = io.read()
        if nil == line then
            break
        end
        print(line)
    until false
    io.close(file)
end

local function testIOWrite(fileName, content)
    file = io.open(fileName, "a+")
    io.output(file)
    io.write(content)
    io.close()
end
local function testIO()
    local fileName = "test1.txt"
    testIORead(fileName)
    testIOWrite(fileName, "\nhello from io")
    testIORead(fileName)
end
testIO()

print("===========")

-- 使用 file:XXX() 函数方式进行操作, 其中 file 为 io.open() 返回的文件句柄。
local function testFileRead(fileName)
    local file = io.open(fileName, "r")
    for line in file:lines() do
        print(line)
    end
    file:close()
end

local function testFileWrite(fileName, content)
    local file = io.open(fileName, "a")
    file:write(content)
    file:close()
end

local function testFile()
    local fileName = "test1.txt"
    testFileRead(fileName)
    testFileWrite(fileName, "\nhello from file")
    testFileRead(fileName)
end
testFile()