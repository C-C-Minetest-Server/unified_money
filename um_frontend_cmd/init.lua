local S = minetest.get_translator("um_frontend_cmd")
local _utc = um_translate_common

local cmd = chatcmdbuilder.register("um", {
    description = S("Interact with @1",_utc.um_brand()),
})

cmd:sub("create :username", {
    description = _utc.create_account(),
    privs = {
        server = true
    },
    func = function(name, username)
        local status = unified_money.create_account(username,0)
        if status then
            return true, _utc.create_account_name_past(username)
        else
            return false, S("Failed.")
        end
    end,
})

cmd:sub("delete :username", {
    description = _utc.delete_account(),
    privs = {
        server = true
    },
    func = function(name, username)
        local status = unified_money.delete_account(username)
        if status then
            return true, _utc.delete_account_name_past(username)
        else
            return false, S("Failed.")
        end
    end,
})

cmd:sub("get :username", {
    description = _utc.get_balance(),
    func = function(name, username)
        local status = unified_money.get_balance(username)
        if status then
            return true, _utc.balance_of_show(username,status)
        else
            return false, S("Failed.")
        end
    end,
})

cmd:sub("set :username :val:int", {
    description = _utc.set_balance(),
    func = function(name, username, val)
        local status = unified_money.set_balance(username,val)
        if status then
            return true, _utc.set_balance_of_to(username,val)
        else
            return false, S("Failed.")
        end
    end,
})