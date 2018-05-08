return {
    name = 's1',

    entry = function(fsm, state)
        print(fsm.name .. ' ' .. state.name .. ' entry')
    end,

    exit = function(fsm, state)
        print(fsm.name .. ' ' .. state.name .. ' exit')
        print('b();')
    end,

    sub_fsms = {'s1-subfsm.lua'},

    transitions = {
        {
            triggers = 'T1',

            guard = function(fsm, state, evtype, evdata)
                print('g(); return true')
                return true
            end,

            dst = 's2',
            action = function(fsm, state, evtype, evdata)
                print('t();')
            end,
        },
    },
}
