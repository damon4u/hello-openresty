---
--- Created by damon4u.
--- DateTime: 2018/12/14 下午2:47
---
local args = ngx.req.get_uri_args()
ngx.say(args.a + args.b)