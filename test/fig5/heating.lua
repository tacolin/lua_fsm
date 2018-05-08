return {
    name = 'heating',

    entry = function(fsm, state)
        print(fsm.name .. ' ' .. state.name .. " entry")
        print('heater_on();')
    end,

    exit = function(fsm, state)
        print(fsm.name .. ' ' .. state.name .. " exit")
        print('heater_off();')
    end,

    sub_fsms = {'heating-subfsm.lua'},

    transitions = {
        {
            triggers = 'DOOR_OPEN',
            dst = 'door-open'
        },
    },
}
