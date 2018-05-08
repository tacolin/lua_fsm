return {
    name = 'arrows',

    entry = function(fsm, state) print(state.name .. " entry") end,

    exit = function(fsm, state) print(state.name .. " exit") end,

    transitions = {
        {
            triggers = 'NUM_KEY',
            dst = 'arrows',
        },

        {
            triggers = 'NUM_LOCK',
            dst = 'numbers'
        },
    },
}
