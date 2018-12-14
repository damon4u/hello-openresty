---
--- Created by damon4u.
--- DateTime: 2018/12/14 下午9:06
---
local json = require "cjson"
local str = [[{"a":1,"b":2,"c":3}]]
local t = json.decode(str)
for i, v in pairs(t) do
    ngx.say("key="..i..",value="..v)
end
local result = {
    code = 200,
    msg = "success"
}
ngx.say(json.encode(result))