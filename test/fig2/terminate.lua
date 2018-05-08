
return {
    name = 'terminate',

    entry = function(fsm, state)
        print(state.name .. ' entry')
    end,
}
