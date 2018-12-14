---
--- Created by damon4u.
--- DateTime: 2018/12/14 下午4:45
---
local redis_c = require "resty.redis"

-- table.new是luajit2.1新方法，用来分配table空间
-- 这里使用pcall的安全模式调用，如果版本较低，出现异常，那么手动构造一个函数
local ok, new_table = pcall(require, "table.new")
if not ok or type(new_table) ~= "function" then
    new_table = function(narr, nrec) return {} end
end 

local _M = new_table(0, 155)
_M._VERSION = '0.01'

local commands = {
    "append",            "auth",              "bgrewriteaof",
    "bgsave",            "bitcount",          "bitop",
    "blpop",             "brpop",
    "brpoplpush",        "client",            "config",
    "dbsize",
    "debug",             "decr",              "decrby",
    "del",               "discard",           "dump",
    "echo",
    "eval",              "exec",              "exists",
    "expire",            "expireat",          "flushall",
    "flushdb",           "get",               "getbit",
    "getrange",          "getset",            "hdel",
    "hexists",           "hget",              "hgetall",
    "hincrby",           "hincrbyfloat",      "hkeys",
    "hlen",
    "hmget",              "hmset",      "hscan",
    "hset",
    "hsetnx",            "hvals",             "incr",
    "incrby",            "incrbyfloat",       "info",
    "keys",
    "lastsave",          "lindex",            "linsert",
    "llen",              "lpop",              "lpush",
    "lpushx",            "lrange",            "lrem",
    "lset",              "ltrim",             "mget",
    "migrate",
    "monitor",           "move",              "mset",
    "msetnx",            "multi",             "object",
    "persist",           "pexpire",           "pexpireat",
    "ping",              "psetex",            "psubscribe",
    "pttl",
    "publish",      --[[ "punsubscribe", ]]   "pubsub",
    "quit",
    "randomkey",         "rename",            "renamenx",
    "restore",
    "rpop",              "rpoplpush",         "rpush",
    "rpushx",            "sadd",              "save",
    "scan",              "scard",             "script",
    "sdiff",             "sdiffstore",
    "select",            "set",               "setbit",
    "setex",             "setnx",             "setrange",
    "shutdown",          "sinter",            "sinterstore",
    "sismember",         "slaveof",           "slowlog",
    "smembers",          "smove",             "sort",
    "spop",              "srandmember",       "srem",
    "sscan",
    "strlen",       --[[ "subscribe",  ]]     "sunion",
    "sunionstore",       "sync",              "time",
    "ttl",
    "type",         --[[ "unsubscribe", ]]    "unwatch",
    "watch",             "zadd",              "zcard",
    "zcount",            "zincrby",           "zinterstore",
    "zrange",            "zrangebyscore",     "zrank",
    "zrem",              "zremrangebyrank",   "zremrangebyscore",
    "zrevrange",         "zrevrangebyscore",  "zrevrank",
    "zscan",
    "zscore",            "zunionstore",       "evalsha"
}

local mt = { __index = _M}

local function is_table_null( res )
    if type(res) == "table" then
        for k,v in pairs(res) do
            if v ~= ngx.null then
                return false
            end
        end
        return true
    elseif res == ngx.null then
        return true
    elseif res == nil then
        return true
    end

    return false
end

function _M.connect_mod(self, redis)
    redis:set_timeout(self.timeout)
    return redis:connect("127.0.0.1", 6379)
end

function _M.auth_mod(redis)
    local count, err = redis:get_reused_times()
    if 0 == count then
        ok, err = redis:auth("rkQOlXz0")
        if not ok then
            ngx.say("failed to auth: ", err)
            return
        end
    elseif err then
        ngx.say("failed to get reused times: ", err)
        return
    end
end

function _M.set_keepalive_mod(redis)
    return redis:set_keepalive(60000, 1000)
end

function _M.init_pipeline( self )
    self.pipeline_commands = {}
end


function _M.commit_pipeline( self )
    local pipeline_commands = self.pipeline_commands

    if nil == pipeline_commands or 0 == #pipeline_commands then
        return {}, "no pipeline"
    else
        self.pipeline_commands = nil -- 把原来的命令清除
    end

    local redis, err = redis_c:new()
    if not redis then
        return nil, err
    end

    ok, err = self:connect_mod(redis)
    if not ok then
        return {}, err
    end
    
    self.auth_mod(redis)

    redis:init_pipeline()
    for _, command_with_args in ipairs(pipeline_commands) do
        local fun = redis[command_with_args[1]]
        table.remove(command_with_args, 1) -- 把命令字段移除，下面用unpack把参数合并返回
        fun(redis, unpack(command_with_args))
    end

    local results
    results, err = redis:commit_pipeline()
    if not results or err then
        return {}, err
    end

    if is_table_null(results) then
        results = {}
        ngx.log(ngx.WARN, "is null")
    end

    self.set_keepalive_mod(redis)

    for i,value in ipairs(results) do
        if is_table_null(value) then
            results[i] = nil
        end
    end

    return results, err
end

local function do_command(self, cmd, ...)
    -- 如果开启了调用了init_pipeline方法开启了pipeline，那么这里只是将命令放到table里，等待调用commit_pipeline时管道提交
    if self.pipeline_commands then
        table.insert(self.pipeline_commands, {cmd, ...})
        return
    end
    
    local redis, err = redis_c:new()
    if not redis then
        return nil, err
    end
    
    ok, err = self:connect_mod(redis)
    if not ok or err then
        return nil, err
    end

    self.auth_mod(redis)

    local fun = redis[cmd]
    local result 
    result, err = fun(redis, ...)
    if not result or err then
        return nil, err
    end

    if is_table_null(result) then
        result = nil
    end
    
    self.set_keepalive_mod(redis)
    
    return result, err
end

for _, cmd in ipairs(commands) do
    _M[cmd] = function(self, ...)
        return do_command(self, cmd, ...)
    end
end

function _M.new(self, opts)
    opts = opts or {}
    local timeout = (opts.timeout and opts.timeout * 1000) or 1000
    local db_index = opts.db_index or 0
    return setmetatable({
        timeout = timeout,
        db_index = db_index,
        pipeline_commands = nil
    }, mt)
end

return _M