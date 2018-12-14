---
--- Created by damon4u.
--- DateTime: 2018/12/14 下午5:06
---
local redis = require "redis_iresty"

local redis_client = redis:new()

local ok, err = redis_client:set("d","test d")
if not ok then
    ngx.say("failed to set d: ", err)
    return
end 
ngx.say("set result: ", ok)