
return {
    name = 'operand1',

    entry = function(fsm, state)
        print(state.name .. ' entry')
    end,

    exit = function(fsm, state)
        print(state.name .. ' exit')
    end,

    internal_transitions = {
        {
            triggers  = '0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | .',
            action = function(fsm, src_state, evtype, evdata)
                local db = fsm:get_db()
                if db.param1 == "" and evtype == "." then
                    db.param1 = "0."
                else
                    db.param1 = db.param1 .. evtype
                end
            end,
        },
    },

    transitions = {
        {
            triggers  = 'C',
            dst = 'operand1',
            action = function(fsm, state, evtype, evdata)
                local db = fsm:get_db()
                db.param1 = ""
                db.param2 = ""
                db.operation = ""
                db.result = ""
                print("reset param1, param2, operation")
            end,
        },

        {
            triggers  = '+ | - | * | /',
            dst = 'opEntered',
            action = function(fsm, src_state, evtype, evdata)
                local db = fsm:get_db()
                db.operation = evtype
                print("save opertaion = " .. evtype)
            end,
        },

        {
            triggers  = 'OFF',
            dst = 'terminate',
        },
    },
}
