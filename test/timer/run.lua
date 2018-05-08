#!/usr/bin/lua

require('uloop')

local gc_timer = nil

function gc()
    collectgarbage()
    gc_timer:set(5000)
end

uloop.init()

gc_timer = uloop.timer(gc, 5000)

local nfsm = require('nfsm')
local nfsm_timer = require('nfsm_timer')

local sm = nfsm.new()
local timer = nfsm_timer.new(sm)

sm:initialize('fsm.lua')
sm:show_state()

print('')

uloop.run()

