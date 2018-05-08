return {
    name = 's21',

    entry = function(fsm, state)
        print(fsm.name .. ' ' .. state.name .. ' entry')
        print('e();')
    end,

    exit = function(fsm, state)
        print(fsm.name .. ' ' .. state.name .. ' exit')
    end,

}
