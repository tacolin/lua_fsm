
return {
    name = 'terminate',

    entry = function(fsm, state)
        print("Entry " .. state.name)
    end,
}
