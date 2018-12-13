---
--- Created by damon4u.
--- DateTime: 2018/12/12 下午7:15
---
local _M = {}

function _M.deposit(self, v)
    self.balance = self.balance + v
end

function _M.withdraw(self, v)
    if self.balance > v then
        self.balance = self.balance - v
    else
        error("insufficient funds")
    end
end

function _M.new(self, balance)
    balance = balance or 0
    return setmetatable({balance = balance}, {__index = _M})
end

return _M