return {
    name = "state-a",

    entry = function(fsm, state)
    end,

    exit = function(fsm, state)
    end,

    sub_fsms = {
        'sub1-root.lua',
        'sub2-root.lua',
    },

    internal_transitions = {
        {
            triggers = 'ev_internal',
            action = function(fsm, state, evtype, evdata)
            end,
        },
    },

    transitions = {
        {
            triggers = 'ev_b | ev_b+',
            dst = "state-b",
            action = function(fsm, src_state_name, evtype, evdata)
            end,
        },

        {
            triggers = 'tm_500',
            action = function(fsm, src_state_name, evtype, evdata)
                local db = fsm:get_db()
                if db.value < 100 then
                    db.value = db.value + 1
                    return 'state-a'
                else
                    db.value = 0
                    return 'state-b'
                end
            end,
        },
    },
}
