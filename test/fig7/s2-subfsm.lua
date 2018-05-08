return {
    name = 's2-root',

    init_state = 's21',

    init_action = function(fsm)
        print('d();')
    end,

    states = {'s21.lua'}
}
