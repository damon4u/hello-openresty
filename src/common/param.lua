---
--- Created by damon4u.
--- DateTime: 2018/12/14 下午2:52
---
local _M = {}
function _M.is_number(...)
    local args = { ...}
    local num
    for _, v in ipairs(args) do
        num = tonumber(v)
        if not num then
            return false
        end
    end
    return true
end

return _M