return {
    name = 'root',

    init_state = 'default',

    init_action = function(fsm)
        print('this is initial transition')
    end,

    states = { 'default.lua', 'caps_locked.lua' },

}
