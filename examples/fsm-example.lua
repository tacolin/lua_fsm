return {
    name = 'root'

    init_state = 'state-a',

    init_action = function(fsm)
    end,

    states = {
        'state-a.lua',
        'state-b.lua',
        'state-terminate.lua',
    },

    local_transitions = {
        {
            triggers = 'ev_terminate',
            dst = 'state-terminate',
            action = function(fsm, state, evtype, evdata)
            end,
        },
    },

    external_transitions = {

    },
}
