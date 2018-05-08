return {
    name = 'root',

    init_state = 'default',

    init_action = function(fsm)
        local db = fsm:get_db()
        db.key_count = 10
        print('set key_count = 10')
    end,

    states = {'default.lua', 'caps_locked.lua', 'terminate.lua'}
}
