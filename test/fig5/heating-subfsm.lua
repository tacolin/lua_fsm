return {
    name = 'heating-root',

    init_state = 'toasting',

    states = {'toasting.lua', 'baking.lua'},

    local_transitions = {
        {
            triggers = 'DO_TOASTING',
            dst = 'toasting',
        },

        {
            triggers = 'DO_BAKING',
            dst = 'baking',
        },
    },
}
