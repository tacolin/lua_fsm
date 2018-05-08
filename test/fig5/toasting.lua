return {
    name = 'toasting',

    entry = function(fsm, state)
        print(fsm.name .. ' ' .. state.name .. " entry")
        print('arm_time_event(me->toast_color);')
    end,

    exit = function(fsm, state)
        print(fsm.name .. ' ' .. state.name .. " exit")
        print('disarm_time_event();')
    end,
}
