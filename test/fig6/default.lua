
return {
    name = 'default',

    entry = function(fsm, state)
        print(state.name .. ' entry')
    end,

    exit = function(fsm, state)
        print(state.name .. ' exit')
    end,

    internal_transitions = {
        {
            triggers = 'ANY_KEY',
            action = function(fsm, state, evtype, evdata)
                print(state.name .. ' send_lower_case_scan_code();')
            end,
        },
    },

    transitions = {
        {
            triggers  = 'CAPS_LOCK',
            dst = 'caps_locked',
        },
    },
}
