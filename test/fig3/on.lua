
return {
    name = 'on',

    entry = function(fsm, state)
        print(state.name .. ' entry')
        local db = fsm:get_db()
        db.param1 = ""
        db.param2 = ""
        db.operation = ""
        db.result = ""
        print("reset param1, param2, operation, and result")
    end,

    exit = function(fsm, state)
        print(state.name .. ' exit')
    end,

    sub_fsms = { 'on-subfsm.lua' },

    transitions = {
        {
            triggers  = 'C',
            dst = 'on',
        },

        {
            triggers = 'OFF',
            dst = 'terminate',
        },
    },
}
