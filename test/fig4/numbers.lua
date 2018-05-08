return {
    name = 'numbers',

    entry = function(fsm, state) print(state.name .. " entry") end,

    exit = function(fsm, state) print(state.name .. " exit") end,

    transitions = {
        {
            triggers = 'NUM_KEY',
            dst = 'numbers',
        },

        {
            triggers = 'NUM_LOCK',
            dst = 'arrows'
        },
    },
}
