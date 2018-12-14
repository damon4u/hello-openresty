---
--- Created by damon4u.
--- DateTime: 2018/12/14 下午2:54
---
local param = require("common.param")
local args = ngx.req.get_uri_args()
if not args.a or not args.b or not param.is_number(args.a, args.b) then
    ngx.exit(ngx.HTTP_BAD_REQUEST)
    return
end