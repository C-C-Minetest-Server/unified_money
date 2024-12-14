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

local S
if core.get_translator then
    S = core.get_translator("um_translate_common")
else
    -- Extract of the simple skins mod, MIT License text at root/LICENSE.simple_skins
    S = function(str, ...)
        local args = {...}
        return str:gsub("@%d", function(match)
            return args[tonumber(match:sub(2))]
        end)
    end
end
local NS = function(s) return s end
local function gt(str)
    return function(...)
        return S(str,...)
    end
end

um_translate_common = {}
local _utc = um_translate_common

-- START TRANSLATIONS
_utc.um_brand=gt(NS("Unified Money"))
_utc.balance=gt(NS("Balance"))
_utc.balance_show=gt(NS("Balance: $@1"))
_utc.balance_of=gt(NS("Balance of @1"))
_utc.balance_of_show=gt(NS("Balance of @1: $@2"))
_utc.get_balance=gt(NS("Get balance"))
_utc.get_balance_of=gt(NS("Get balance of @1"))
_utc.set_balance=gt(NS("Set balance"))
_utc.set_balance_of=gt(NS("Set balance of @1"))
_utc.set_balance_to=gt(NS("Set balance to $@1"))
_utc.set_balance_of_to=gt(NS("Set balance of @1 to $@2"))
_utc.add_balance=gt(NS("Add balance"))
_utc.add_balance_of=gt(NS("Add balance of @1"))
_utc.add_balance_by=gt(NS("Add balance by $@1"))
_utc.add_balance_of_by=gt(NS("Add balance of @1 by $@2"))
_utc.add_balance_past=gt(NS("Added balance"))
_utc.add_balance_of_past=gt(NS("Added balance of @1"))
_utc.add_balance_by_past=gt(NS("Added balance by $@1"))
_utc.add_balance_of_by_past=gt(NS("Added balance of @1 by $@2"))
_utc.create_account=gt(NS("Create account"))
_utc.create_account_name=gt(NS("Create account @1"))
_utc.create_account_past=gt(NS("Created account"))
_utc.create_account_name_past=gt(NS("Created account @1"))
_utc.delete_account=gt(NS("Delete account"))
_utc.delete_account_name=gt(NS("Delete account @1"))
_utc.delete_account_past=gt(NS("Deleted account"))
_utc.delete_account_name_past=gt(NS("Deleted account @1"))
-- END OF TRANSLATIONS