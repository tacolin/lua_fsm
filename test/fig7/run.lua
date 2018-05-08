#!/usr/bin/lua

local nfsm = require('nfsm')
local sm = nfsm.new()
sm:initialize('fsm.lua')
sm:show_state()

print('')

sm:update('T1')
sm:show_state()

print('')
