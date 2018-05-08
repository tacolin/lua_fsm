return {
    name = 'caps_locked',

    entry = function(fsm, state) print(state.name .. " entry") end,

    exit = function(fsm, state) print(state.name .. " exit") end,

    transitions = {
        {
            triggers = 'ANY_KEY',
            dst = 'caps_locked',
        },

        {
            triggers = 'CAPS_LOCK',
            dst = 'default'
        },
    },
}
