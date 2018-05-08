return {
    name = 'a',

    entry = function(fsm, state)
        print(fsm.name .. ' ' .. state.name .. ' entry')
    end,

    exit = function(fsm, state)
        print(fsm.name .. ' ' .. state.name .. ' exit')
    end,

    transitions = {
        {
            triggers = 'TO_B | tm_1000',
            dst = 'b',
        },
    },
}
