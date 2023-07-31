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

-- This file is dynamically generated.
-- DO ALL THE MODIFICATIONS IN generate.py.
local S
if minetest.get_translator then
    S = minetest.get_translator("um_translate_common")
else
    -- Extract of the simple skins mod, MIT License text at root/LICENSE.simple_skins
    S = function(str, ...)
        local args = {...}
        return str:gsub("@%d", function(match)
            return args[tonumber(match:sub(2))]
        end)
    end
end
local function gt(str)
    return function(...)
        return S(str,...)
    end
end
um_translate_common = {}
local _utc = um_translate_common

-- START TRANSLATIONS
_utc.um_brand=gt("Unified Money")
_utc.balance=gt("Balance")
_utc.balance_show=gt("Balance: $@1")
_utc.balance_of=gt("Balance of @1")
_utc.balance_of_show=gt("Balance of @1: $@2")
_utc.get_balance=gt("Get balance")
_utc.get_balance_of=gt("Get balance of @1")
_utc.set_balance=gt("Set balance")
_utc.set_balance_of=gt("Set balance of @1")
_utc.set_balance_to=gt("Set balance to $@1")
_utc.set_balance_of_to=gt("Set balance of @1 to $@2")
_utc.add_balance=gt("Add balance")
_utc.add_balance_of=gt("Add balance of @1")
_utc.add_balance_by=gt("Add balance by $@1")
_utc.add_balance_of_by=gt("Add balance of @1 by $@2")
_utc.add_balance_past=gt("Added balance")
_utc.add_balance_of_past=gt("Added balance of @1")
_utc.add_balance_by_past=gt("Added balance by $@1")
_utc.add_balance_of_by_past=gt("Add balanceed of @1 by $@2")
_utc.create_account=gt("Create account")
_utc.create_account_name=gt("Create account @1")
_utc.create_account_past=gt("Created account")
_utc.create_account_name_past=gt("Created account @1")
_utc.delete_account=gt("Delete account")
_utc.delete_account_name=gt("Delete account @1")
_utc.delete_account_past=gt("Deleted account")
_utc.delete_account_name_past=gt("Deleted account @1")
-- END OF TRANSLATIONS