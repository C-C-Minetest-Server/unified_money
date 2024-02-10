--[[
    Copyright (C) 2023  1F616EMO

    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
    version 2.1 of the License, or (at your option) any later version.

    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public
    License along with this library; if not, write to the Free Software
    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301
    USA
]]

local S = minetest.get_translator("um_frontend_cmd")
local _utc = um_translate_common

local cmd = chatcmdbuilder.register("um", {
    description = S("Interact with @1", _utc.um_brand()),
})

cmd:sub("create :username", {
    description = _utc.create_account(),
    privs = {
        server = true
    },
    func = function(name, username)
        local status = unified_money.create_account(username, 0)
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
            return true, _utc.balance_of_show(username, status)
        else
            return false, S("Failed.")
        end
    end,
})

cmd:sub("set :username :val:int", {
    description = _utc.set_balance(),
    func = function(name, username, val)
        local status = unified_money.set_balance(username, val)
        if status then
            return true, _utc.set_balance_of_to(username, val)
        else
            return false, S("Failed.")
        end
    end,
})
