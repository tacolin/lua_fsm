return {
    name = 'door-open',

    entry = function(fsm, state)
        print(fsm.name .. ' ' .. state.name .. " entry")
        print('internal_lamp_on();')
    end,

    exit = function(fsm, state)
        print(fsm.name .. ' ' .. state.name .. " exit")
        print('internal_lamp_off();')
    end,

    transitions = {
        {
            triggers = 'DOOR_CLOSE',
            dst = 'heating',
        },
    },
}
