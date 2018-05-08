#!/usr/bin/lua

local nfsm = require('nfsm')
require('utils')

local db = {}
local sm = nfsm.new(db)

sm:initialize('fsm.lua')

print('')
print('')
print('')

sm:update('3')
sm:update('0')
sm:update('0')
sm:update('/')
sm:update('0')
sm:update('=')

print("")
print("")
print("")

sm:update('3')
sm:update('.')
sm:update('3')
sm:update('2')
sm:update('-')
sm:update('2')
sm:update('=')

print("")
print("")
print("")

sm:update('+')
sm:update("2")
sm:update("=")

print("")
print("")
print("")

sm:update('*')
sm:update('3')
sm:update('0')
sm:update('0')
sm:update('=')

print("")
print("")
print("")
sm:update('OFF')
sm:update('1')
sm:update('+')
sm:update('1')
sm:update('=')

