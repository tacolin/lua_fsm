return {
    name = 'outer-root',

    init_state = 'inner',

    states = {'inner.lua'},

    local_transitions = {
        {
            triggers = 'INNER_LOCAL_OUT',
        },

        {
            triggers = 'OUTER_LOCAL_IN',
            dst = 'inner',
        },
    },

    external_transitions = {
        {
            triggers = 'INNER_EXTERNAL_OUT',
        },

        {
            triggers = 'OUTER_EXTERNAL_IN',
            dst = 'inner',
        },
    },
}
