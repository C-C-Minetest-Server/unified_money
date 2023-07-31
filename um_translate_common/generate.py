r"""
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
"""

import i18n
from os import path

prepend = r"""--[[
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
"""

strings = {
    "um_brand": "Unified Money",

    "balance": "Balance",
    "balance_show": "Balance: $@1",
    "balance_of": "Balance of @1",
    "balance_of_show": "Balance of @1: $@2",

    "get_balance": "Get balance",
    "get_balance_of": "Get balance of @1",

    "set_balance": "Set balance",
    "set_balance_of": "Set balance of @1",
    "set_balance_to": "Set balance to $@1",
    "set_balance_of_to": "Set balance of @1 to $@2",

    # Technical limitation: same text different key
    # "set_balance_past": "Set balance",
    # "set_balance_of_past": "Set balance of @1",
    # "set_balance_to_past": "Set balance to $@1",
    # "set_balance_of_to_past": "Set balance of @1 to $@2",

    "add_balance": "Add balance",
    "add_balance_of": "Add balance of @1",
    "add_balance_by": "Add balance by $@1",
    "add_balance_of_by": "Add balance of @1 by $@2",
    "add_balance_past": "Added balance",
    "add_balance_of_past": "Added balance of @1",
    "add_balance_by_past": "Added balance by $@1",
    "add_balance_of_by_past": "Add balanceed of @1 by $@2",
    
    "create_account": "Create account",
    "create_account_name": "Create account @1",
    "create_account_past": "Created account",
    "create_account_name_past": "Created account @1",

    "delete_account": "Delete account",
    "delete_account_name": "Delete account @1",
    "delete_account_past": "Deleted account",
    "delete_account_name_past": "Deleted account @1",
}

luafile_content = prepend + "\n".join([("_utc." + k + "=gt(\"" + v + "\")") for k, v in strings.items()]) + "\n-- END OF TRANSLATIONS"

print("Updating init.lua")
with open("init.lua", "wt", encoding='utf-8') as translation_file:
    translation_file.write(luafile_content)

dkeyStrings = {v: "init.lua" for k,v in strings.items()}

print("Updating template.txt")
i18n.write_template("locale/template.txt", dkeyStrings, "um_translate_common",)
for tr_file in i18n.get_existing_tr_files("."):
    print("Updating " + tr_file)
    i18n.update_tr_file(dkeyStrings, "um_translate_common", path.join("locale/", tr_file))