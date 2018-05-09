
local _M = {}
_M._VERSION = '1.0'

local mt = { __index = _M }

function _M.new(database)
    return setmetatable({db = database, busy = false, evqueue = {}}, mt)
end

function _M.destroy(self)
    local utils = require('utils')
    self.db = nil
    utils.free(self)
    utils = nil
end

function _M.add_timer(self, period, key)
    if self.timer then
        self.timer:add(period, key)
    end
end

function _M.del_timer(self, key)
    if self.timer then
        self.timer:del(key)
    end
end

local function _parse_data_trans(fsm, state_name, data_trans)
    local utils = require('utils')
    local trans = utils.deep_copy(data_trans)
    local splits = utils.split(data_trans.triggers, ' |')

    trans.triggers = nil
    trans.triggers = {}

    for i=1, #splits do
        if utils.starts(splits[i], 'tm_') and fsm.timer then
            trans.triggers[splits[i] .. '_' .. fsm.name .. '_' .. state_name] = tonumber(splits[i]:sub(4, -1))
        else
            trans.triggers[splits[i]] = true
        end
    end

    utils.free(splits)
    splits = nil

    return trans
end

local function _start_state_timers(fsm, state)
    local utils = require('utils')

    if state.internal_transitions then
        for idx, trans in ipairs(state.internal_transitions) do
            for key, value in pairs(trans.triggers) do
                if utils.starts(key, 'tm_') then
                    fsm:add_timer(value, key)
                end
            end
        end
    end

    if state.transitions then
        for idx, trans in ipairs(state.transitions) do
            for key, value in pairs(trans.triggers) do
                if utils.starts(key, 'tm_') then
                    fsm:add_timer(value, key)
                end
            end
        end
    end
end

local function _stop_state_timers(fsm, state)
    local utils = require('utils')
    if state.internal_transitions then
        for idx, trans in ipairs(state.internal_transitions) do
            for key, value in pairs(trans.triggers) do
                if utils.starts(key, 'tm_') then
                    fsm:del_timer(key)
                end
            end
        end
    end

    if state.transitions then
        for idx, trans in ipairs(state.transitions) do
            for key, value in pairs(trans.triggers) do
                if utils.starts(key, 'tm_') then
                    fsm:del_timer(key)
                end
            end
        end
    end
end

function _M.add_state(self, state_file)
    local utils = require('utils')
    if not utils.file_exist(state_file) then
        print('[FSM][ERROR] state file (' .. state_file .. ') does not exist')
        os.exit(-1)
    end

    local state_data = dofile(state_file)
    if not state_data then
        print('[FSM][ERROR] state file (' .. state_file ..') parsing failed')
        os.exit(-1)
    end

    if not self.states then
        self.states = {}
    end

    if self.states[state_data.name] then
        print('[FSM][ERROR] state (' .. state_data.name ..') already exists, double add_state')
        os.exit(-1)
    end

    local state = {}
    state.name  = utils.deep_copy(state_data.name)
    state.entry = utils.deep_copy(state_data.entry)
    state.exit  = utils.deep_copy(state_data.exit)

    if state_data.internal_transitions then
        state.internal_transitions = {}
        for i=1, #state_data.internal_transitions do
            table.insert(state.internal_transitions, _parse_data_trans(self, state.name, state_data.internal_transitions[i]))
        end
    end

    if state_data.transitions then
        state.transitions = {}
        for i=1, #state_data.transitions do
            table.insert(state.transitions, _parse_data_trans(self, state.name, state_data.transitions[i]))
        end
    end

    if state_data.sub_fsms then
        state.sub_fsms = {}
        for i=1, #state_data.sub_fsms do
            print(state_data.name .. ' add sub_fsm')
            local sub = _M.new(self.db)
            sub.parent = self
            sub.parent_state_name = state_data.name
            sub:initialize(state_data.sub_fsms[i])
            table.insert(state.sub_fsms, sub)
        end
    end

    self.states[state_data.name] = state

    utils.free(state_data)
    state_data = nil
end

function _M.enter_state(self, state_name, external)
    if not state_name then
        self.curr_state_name = nil
        return
    end

    local state = self.states[state_name]
    if not state then
        print('[FSM][ERROR] no such state (' .. state_name .. ') in fsm')
        os.exit(-1)
    end

    if state.entry then
        state.entry(self, state)
    end

    if external ~= 'external' then -- 這是另一個 external 的 workaround
        if state.sub_fsms then
            for i=1, #state.sub_fsms do
                state.sub_fsms[i]:enter_init_state()
            end
        end
    end

    self.curr_state_name = state_name

    if self.timer then
        _start_state_timers(self, state)
    end
end

function _M.exit_state(self, state_name)
    if not state_name then
        return
    end

    local state = self.states[state_name]
    if not state then
        print('[FSM][ERROR] no such state (' .. state_name .. ') in fsm')
        return
    end

    if state.sub_fsms then
        for i=1, #state.sub_fsms do
            if state.sub_fsms[i].curr_state_name then
                state.sub_fsms[i]:exit_state(state.sub_fsms[i].curr_state_name)
                state.sub_fsms[i].curr_state_name = nil
            end
        end
    end

    if state.exit then
        state.exit(self, state)
    end

    if self.timer then
        _stop_state_timers(self, state)
    end
end

function _M.enter_init_state(self)
    if self.init_state then
        if self.init_action then
            self.init_action(self)
        end
        self:enter_state(self.init_state)
    end
end

function _M.initialize(self, root_file)
    local utils = require('utils')
    if not utils.file_exist(root_file) then
        print('[FSM][ERROR] root file (' .. root_file .. ') does not exist')
        os.exit(-1)
    end

    local root_data = dofile(root_file)
    if not root_data then
        print('[FSM][ERROR] root file (' .. root_file ..') parsing failed')
        os.exit(-1)
    end

    self.name = root_data.name

    for i=1, #root_data.states do
        self:add_state(root_data.states[i])
    end

    self.local_transitions = {}
    if root_data.local_transitions and self.parent_state_name then
        for i=1, #root_data.local_transitions do
            table.insert(self.local_transitions, _parse_data_trans(self.parent, self.parent_state_name, root_data.local_transitions[i]))
        end
    end

    self.external_transitions = {}
    if root_data.external_transitions and self.parent_state_name then
        for i=1, #root_data.external_transitions do
            table.insert(self.external_transitions, _parse_data_trans(self.parent, self.parent_state_name, root_data.external_transitions[i]))
        end
    end

    self.init_state  = utils.deep_copy(root_data.init_state)
    self.init_action = utils.deep_copy(root_data.init_action)

    if not self.parent then
        self:enter_init_state()
    end

    utils.free(root_data)
    root_data = nil
end

function _M.process_local_transitions(self, evtype, evdata)
    for idx, trans in ipairs(self.local_transitions) do
        if trans.triggers[evtype] then
            self:exit_state(self.curr_state_name)

            local dst = nil
            if trans.action then
                dst = trans.action(self, self.states[self.curr_state_name], evtype, evdata)
            end

            if trans.dst then
                dst = trans.dst
            end

            self:enter_state(dst)
            return true
        end
    end
    return false
end

-- function _M.process_external_transitions(self, evtype, evdata)
--     for idx, trans in ipairs(self.external_transitions) do
--         if trans.triggers[evtype] then
--             self:exit_state(self.curr_state_name)
--             self.curr_state_name = nil -- 這是 external transition 的 workaround

--             if self.parent and self.parent_state_name then
--                 self.parent:exit_state(self.parent_state_name)
--                 self.parent:enter_state(self.parent_state_name, 'external')
--             end

--             local dst = nil
--             if trans.action then
--                 dst = trans.action(self, self.states[self.curr_state_name], evtype, evdata)
--             end

--             if trans.dst then
--                 dst = trans.dst
--             end

--             self:enter_state(dst)
--             return true
--         end
--     end
--     return false
-- end

function _M.process_internal_transitions(self, evtype, evdata)
    if not self.curr_state_name then
        print('[FSM][ERROR][INTERNAL_TRANS] no current state in fsm')
        os.exit(-1)
    end

    local state = self.states[self.curr_state_name]
    if not state then
        print('[FSM][ERROR][INTERNAL_TRANS] no current state in fsm')
        os.exit(-1)
    end

    if state.internal_transitions then
        for idx, trans in ipairs(state.internal_transitions) do
            if trans.triggers[evtype] then
                if trans.action then
                    trans.action(self, state, evtype, evdata)
                end
                return true
            end
        end
    end
    return false
end

function _M.process_transitions(self, evtype, evdata)
    if not self.curr_state_name then
        print('[FSM][ERROR][INTERNAL_TRANS] no current state in fsm')
        os.exit(-1)
    end

    local state = self.states[self.curr_state_name]
    if not state then
        print('[FSM][ERROR][TRANS] no current state in fsm')
        os.exit(-1)
    end

    if state.transitions then
        for idx, trans in ipairs(state.transitions) do
            if trans.triggers[evtype] then
                local fit = true

                if trans.guard then
                    fit = trans.guard(self, state, evtype, evdata)
                end

                if fit then
                    self:exit_state(self.curr_state_name)

                    local dst = nil
                    if trans.action then
                        dst = trans.action(self, state, evtype, evdata)
                    end

                    if trans.dst then
                        dst = trans.dst
                    end

                    self:enter_state(dst)
                    return true
                end
            end
        end
    end
    return false
end

local function _update_fsm(fsm, evtype, evdata)
    print(os.date("[%Y/%m/%d %H:%M:%S] ") .. fsm.name .. ' ' .. evtype .. ' received')

    if fsm:process_local_transitions(evtype, evdata) then
        return
    end

    -- if fsm:process_external_transitions(evtype, evdata) then
    --     return
    -- end

    if not fsm.curr_state_name then
        return
    end

    if fsm:process_internal_transitions(evtype, evdata) then
        return
    end

    if fsm:process_transitions(evtype, evdata) then
        return
    end

    local state = fsm.states[fsm.curr_state_name]
    if state and state.sub_fsms then
        for idx, sub in ipairs(state.sub_fsms) do
            _update_fsm(sub, evtype, evdata)
        end
    end
    return
end

function _M.update(self, evtype, evdata)
    local utils = require('utils')
    if self.busy then
        local ev    = {}
        ev.evtype   = utils.deep_copy(evtype)
        ev.evdata     = utils.deep_copy(evdata)
        table.insert(self.evqueue, ev)
        return
    end

    self.busy = true
    _update_fsm(self, evtype, evdata)

    while #self.evqueue >= 1 do
        local ev = table.remove(self.evqueue, 1)
        _update_fsm(self, ev.evtype, ev.evdata)
        utils.free(ev)
        ev = nil
    end
    self.busy = false
    return
end

function _M.get_db(self)
    return self.db
end

function _M.show_state(self)
    if self.curr_state_name then
        print(self.name .. ' state = ' .. self.curr_state_name)
        local state = self.states[self.curr_state_name]
        if state and state.sub_fsms then
            for idx, sub in ipairs(state.sub_fsms) do
                sub:show_state()
            end
        end
    end
end

return _M
