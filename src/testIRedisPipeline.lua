---
--- Created by damon4u.
--- DateTime: 2018/12/14 下午5:06
---
local redis = require "redis_iresty"

local redis_client = redis:new()

redis_client:init_pipeline() -- 开启管道

redis_client:set("a","test a")
redis_client:set("b","test b")
redis_client:set("c","test c")

local result, err = redis_client:commit_pipeline() -- 管道提交
if not result then
    ngx.say("failed to set d: ", err)
    return
end
for _,value in ipairs(result) do
    if value then
        ngx.say("set result: ", value)
    end
end
