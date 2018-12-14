---
--- Created by damon4u.
--- DateTime: 2018/12/14 下午3:58
---
local redis = require "resty.redis"
local redis_client = redis:new()

redis_client:set_timeout(1000)

local ok, err = redis_client:connect("127.0.0.1", 6379)

if not ok then
    ngx.say("failed to connect: ", err)
    return
end 

-- 注意auth调用
-- 对于 Redis 授权，实际上只需要建立连接后，首次认证一下，后面只需直接使用即可。换句话说，从连接池中获取的连接都是经过授权认证的，只有新创建的连接才需要进行授权认证。
local count
count, err = redis_client:get_reused_times()
if 0 == count then
    ok, err = redis_client:auth("rkQOlXz0")
    if not ok then
        ngx.say("failed to auth: ", err)
        return
    end
elseif err then
    ngx.say("failed to get reused times: ", err)
    return
end 

ok, err = redis_client:set("dog", "an animal")
if not ok then
    ngx.say("failed to set dog: ", err)
    return
end 

ngx.say("set result: ", ok)

ok, err = redis_client:set_keepalive(10000, 100)
if not ok then
    ngx.say("failed to set keepalive: ", err)
    return
end 