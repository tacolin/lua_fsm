
return {
    name = 'operand2',

    entry = function(fsm, state)
        print(state.name .. ' entry')
    end,

    exit = function(fsm, state)
        print(state.name .. ' exit')
    end,

    transitions = {
        {
            triggers  = '0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | .',
            dst = 'operand2',
            action = function(fsm, src_state, evtype, evdata)
                local db = fsm:get_db()
                if db.param2 == "" and evtype == "." then
                    db.param2 = "0."
                else
                    db.param2 = db.param2 .. evtype
                end
            end,
        },

        {
            triggers  = '=',
            dst = 'result',
        },
    },
}
