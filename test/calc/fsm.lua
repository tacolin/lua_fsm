return {
    name = 'root',

    init_state = 'operand1',

    init_action = function(fsm)
        local db = fsm:get_db()
        db.param1 = ""
        db.param2 = ""
        db.operation = ""
        db.result = ""
        print("reset param1, param2, operation")
    end,

    states = {
        'operand1.lua',
        'opEntered.lua',
        'result.lua',
        'operand2.lua',
        'terminate.lua'
    },
}
