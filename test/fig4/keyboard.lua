return {
    name = 'keyboard',

    entry = function(fsm, state) print(state.name .. " entry") end,

    exit = function(fsm, state) print(state.name .. " exit") end,

    sub_fsms = {'main-keypad-subfsm.lua', 'numeric-keypad-subfsm.lua'},
}
