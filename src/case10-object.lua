---
--- Created by damon4u.
--- DateTime: 2018/12/12 下午7:15
---

local account = require("src.case10-account")

local a = account:new()
a:deposit(100)

local b = account:new()
b:deposit(50)

print(a.balance)
print(b.balance)
