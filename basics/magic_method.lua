local ts = {}
local mt = {}


function mt.__call(...)
    local arg = {...}
    for i, v in ipairs(arg) do
        print(i, v)
    end
end

setmetatable(ts, mt)


ts()
ts(5, 66)
ts"String construct-call"
