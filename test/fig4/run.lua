#!/usr/bin/lua

local nfsm = require('nfsm')
local sm = nfsm.new()

sm:initialize('fsm.lua')
sm:show_state()

print('')

sm:update('ANY_KEY')
sm:update('NUM_KEY')
sm:show_state()

print('')

sm:update('CAPS_LOCK')
sm:update('NUM_KEY')
sm:show_state()

print('')

sm:update('ANY_KEY')
sm:update('NUM_LOCK')
sm:show_state()

print('')

sm:update('ANY_KEY')
sm:update('NUM_LOCK')
sm:show_state()

print('')

sm:update('CAPS_LOCK')
sm:update('NUM_KEY')
sm:show_state()

print('')

sm:update('CAPS_LOCK')
sm:update('NUM_LOCK')
sm:show_state()

print('')

sm:update('CAPS_LOCK')
sm:update('NUM_LOCK')
sm:show_state()

print('')
