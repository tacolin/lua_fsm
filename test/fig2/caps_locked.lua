
return {
    name = 'caps_locked',

    entry = function(fsm, state)
        print(state.name .. ' entry')
    end,

    exit = function(fsm, state)
        print(state.name .. ' exit')
    end,

    transitions = {
        {
            triggers  = 'ANY_KEY',
            action = function(fsm, state, evtype, evdata)
                local db = fsm:get_db()
                db.key_count = db.key_count - 1
                print('key_count = ' .. db.key_count)
                if db.key_count == 0 then
                    return 'terminate'
                else
                    return 'caps_locked'
                end
            end,
        },
        {
            triggers  = 'CAPS_LOCK',
            dst = 'default',
        },
    },
}
