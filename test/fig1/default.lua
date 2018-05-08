
return {
    name = 'default',

    entry = function(fsm, state)
        print(state.name .. ' entry')
    end,

    exit = function(fsm, state)
        print(state.name .. ' exit')
    end,

    transitions = {
        {
            triggers = 'ANY_KEY',
            dst = 'default',
            action = function(fsm, state, evtype, evdata)
                print(state.name .. ' send_lower_case_scan_code();')
            end,
        },

        {
            triggers  = 'CAPS_LOCK',
            dst = 'caps_locked',
        },
    },
}
