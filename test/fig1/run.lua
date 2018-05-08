#!/usr/bin/lua

local nfsm = require('nfsm')
require('utils')

local sm = nfsm.new()
sm:initialize('fsm.lua')

sm:update('ANY_KEY')
sm:update('ANY_KEY')

print("")

sm:update('CAPS_LOCK')
sm:update('ANY_KEY')
sm:update('ANY_KEY')

print("")

sm:update('CAPS_LOCK')
sm:update('ANY_KEY')
sm:update('ANY_KEY')
