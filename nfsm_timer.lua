local _M = {}
_M._VERSION = '1.0'

local mt = { __index = _M }

function _M.new(fsm)
    local obj  = {}
    obj.timers = {}
    obj.fsm    = fsm
    fsm.timer  = obj
    return setmetatable(obj, mt)
end

function _M.destroy(self)
    local utils = require('utils')
    for key, timer in pairs(self.timers) do
        timer:cancel() -- timer 要先停
    end
    self.fsm = nil -- 不能連 fsm 一起幹掉

    utils.free(self)
    utils = nil
end

function _M.del(self, key)
    if self.timers[key] then
        self.timers[key]:cancel()
        self.timers[key] = nil
    end
end

function _M.add(self, period, key)
    local uloop = require('uloop')
    if self.timers[key] then
        self:del(key)
    end

    self.timers[key] = uloop.timer(function()
            self.fsm:update(key)
            self:del(key)
    end, period)
end

return _M
