---
--- Created by damon4u.
--- DateTime: 2018/12/14 下午3:29
---
ngx.req.read_body()
local args, _ = ngx.req.get_uri_args()

local http = require "resty.http"
local http_client = http.new()
local res, _ = http_client:request_uri(
        -- 这里不能写localhost
        "http://127.0.0.1:7776/spe_md5",
        {
            method = "POST",
            body = args.data
        }
)
if 200 ~= res.status then
    ngx.exit(res.status)
end

if args.key == res.body then
    ngx.say("valid request")
else
    ngx.say("invalid request")
end
