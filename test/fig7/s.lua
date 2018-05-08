return {
    name = 's',

    entry = function(fsm, state)
        print(fsm.name .. ' ' .. state.name .. ' entry')
    end,

    exit = function(fsm, state)
        print(fsm.name .. ' ' .. state.name .. ' exit')
    end,

    sub_fsms = {
        's-subfsm.lua',
    },
}
