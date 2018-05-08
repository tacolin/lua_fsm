return {
    name = 's2',

    entry = function(fsm, state)
        print(fsm.name .. ' ' .. state.name .. ' entry')
        print('c();')
    end,

    exit = function(fsm, state)
        print(fsm.name .. ' ' .. state.name .. ' exit')
    end,

    sub_fsms = {'s2-subfsm.lua'},

}
