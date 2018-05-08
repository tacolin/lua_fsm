#!/usr/bin/lua

local nfsm = require('nfsm')
local sm = nfsm:new()

sm:initialize('fsm.lua')
sm:show_state()

print('')

sm:update('INNER_LOCAL_OUT')
sm:show_state()

print('')

sm:update('OUTER_LOCAL_IN')
sm:show_state()

print('')

sm:update('INNER_EXTERNAL_OUT')
sm:show_state()

print('')

sm:update('OUTER_EXTERNAL_IN')
sm:show_state()

print('')
