#!/usr/bin/lua

local nfsm = require('nfsm')
local sm = nfsm:new()

sm:initialize('fsm.lua')
sm:show_state()
print('')

sm:update('DOOR_OPEN')
sm:show_state()
print('')

sm:update('DOOR_CLOSE')
sm:show_state()
print('')

sm:update('DO_TOASTING')
sm:show_state()
print('')

sm:update('DO_BAKING')
sm:show_state()
print('')

sm:update('DO_BAKING')
sm:show_state()
print('')

sm:update('DO_TOASTING')
sm:show_state()
print('')
