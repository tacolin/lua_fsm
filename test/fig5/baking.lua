return {
    name = 'baking',

    entry = function(fsm, state)
        print(fsm.name .. ' ' .. state.name .. " entry")
        print('set_temperature(me->temperature);')
    end,

    exit = function(fsm, state)
        print(fsm.name .. ' ' .. state.name .. " exit")
        print('set_temperature(0);')
    end,
}
