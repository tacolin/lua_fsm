return {
    name = 's11',

    entry = function(fsm, state)
        print(fsm.name .. ' ' .. state.name .. ' entry')
    end,

    exit = function(fsm, state)
        print(fsm.name .. ' ' .. state.name .. ' exit')
        print('a();')
    end,
}
