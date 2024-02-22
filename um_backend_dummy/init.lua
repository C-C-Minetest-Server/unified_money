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

local database = {}

-- All functions return boolean indicating success unless otherwise specified
unified_money.register_backend({
    -- Get the balance of a account
    -- name: The name of the player
    get_balance = function(name)
        return database[name]
    end,
    -- Set the balance of a account
    -- name: The name of the player
    set_balance = function(name, val, forced)
        if not forced then
            if not database[name] then return false end
        end
        database[name] = val
        return true
    end,
    -- Create an account, return true if already exists or created
    -- default_val: int, the value to be set upon creation
    create_account = function(name, default_val)
        database[name] = (default_val or 0)
        return true
    end,
    -- Delete an account, return true if deleted or not existing
    delete_account = function(name)
        database[name] = nil
        return true
    end,
    -- Check whether an account exists
    account_exists = function(name)
        if database[name] ~= nil then return true end
        return false
    end,
    -- Return a list (number-indexed table) of account names
    list_accounts = function()
        local RLST = {}
        for k, _ in pairs(database) do
            table.insert(RLST, k)
        end
        return RLST
    end,
    -- Return the canonical name of a given account name or nickname
    -- All `name` values passed into the above functions will be modified by this function.
    canonical_name = um_utils.backend_case_insensitive,
})

-- Warning functions
minetest.register_on_mods_loaded(function()
    minetest.log("warning",
        "[um_backend_dummy] You are using the dummy backend of Unified Money. NO CHANGES WILL BE SAVED ON DISK!")
    minetest.log("warning",
        "[um_backend_dummy] If you want to save currency data over restarts, use another backend such as um_backend_plain.")
end)

local orange = minetest.get_color_escape_sequence("orange")
minetest.register_on_joinplayer(function(ObjectRef, last_login)
    local name = ObjectRef:get_player_name()
    minetest.chat_send_player(name,
        orange .. "The dummy backend of Unified Money is used. NO CHANGES WILL BE SAVED ON DISK!")
    minetest.chat_send_player(name,
        orange .. "If you want to save currency data over restarts, use another backend such as um_backend_plain.")
end)
