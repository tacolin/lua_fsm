return {
    name = 'default',

    entry = function(fsm, state) print(state.name .. " entry") end,

    exit = function(fsm, state) print(state.name .. " exit") end,

    transitions = {
        {
            triggers = 'ANY_KEY',
            dst = 'default',
        },

        {
            triggers = 'CAPS_LOCK',
            dst = 'caps_locked'
        },
    },
}
