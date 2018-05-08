
return {
    name = 'result',

    entry = function(fsm, state)
        print(state.name .. ' entry')
        local db = fsm:get_db()
        local num1 = tonumber(db.param1)
        if not num1 then num1 = 0 end

        local num2 = tonumber(db.param2)
        if not num2 then num2 = 0 end

        local res = 0
        if db.operation == '+' then
            res = num1 + num2
        elseif db.operation == '-' then
            res = num1 - num2
        elseif db.operation == '*' then
            res = num1 * num2
        elseif db.operation == '/' then
            if num2 ~= 0 then
                res = num1 / num2
            else
                res = 'N/A'
            end
        end

        print("" .. num1 .. " " .. db.operation .. " " .. num2 .. " = " .. res)

        db.result = "" .. res
        db.param1 = "" .. res
        db.param2 = ""
        db.operation = ""
    end,

    exit = function(fsm, state)
        print(state.name .. ' exit')
    end,

    transitions = {
        {
            triggers  = '0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | .',
            dst = 'operand1',
            action = function(fsm, src_state, evtype, evdata)
                local db = fsm:get_db()
                db.param1 = ""
                if evtype == "." then
                    db.param1 = "0."
                else
                    db.param1 = evtype
                end
            end,
        },

        {
            triggers  = '+ | - | * | /',
            dst = 'opEntered',
            action = function(fsm, src_state, evtype, evdata)
                local db = fsm:get_db()
                db.operation = evtype
            end,
        },
    },
}
