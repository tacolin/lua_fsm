#!/usr/bin/lua

local nfsm = require('nfsm')
require('utils')

local db = {}
local sm = nfsm.new(db)
sm:initialize('fsm.lua')

print("")
print("")
print("")

sm:update('ANY_KEY')
sm:update('ANY_KEY')
print("")
print("")
print("")

sm:update('CAPS_LOCK')
sm:update('ANY_KEY')
sm:update('ANY_KEY')
print("")
print("")
print("")

sm:update('CAPS_LOCK')
sm:update('ANY_KEY')
sm:update('ANY_KEY')
print("")
print("")
print("")

sm:update('ANY_KEY')
sm:update('ANY_KEY')
sm:update('ANY_KEY')
sm:update('ANY_KEY')
sm:update('CAPS_LOCK')
sm:update('CAPS_LOCK')
sm:update('CAPS_LOCK')
sm:update('ANY_KEY')
print("")
