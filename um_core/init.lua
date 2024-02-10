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

unified_money = {}
local getmod = minetest.get_current_modname
local str = tostring

local function log(lvl, msg)
    return minetest.log(lvl, "[um_core] " .. msg)
end

function unified_money.register_backend(backend)
    assert(type(backend) == "table")
    for _, k in ipairs({ "get_balance", "set_balance", "create_account", "delete_account", "account_exists", "list_accounts" }) do
        assert(type(backend[k]) == "function", "Backend function " .. k .. " not found")
    end
    unified_money.backend = backend
    unified_money.register_backend = function()
        error("Please only load ONE Unified Money backend at a time.")
    end
    log("action", "Registered Unified Money backend from mod " .. getmod())
end

minetest.register_on_mods_loaded(function()
    if not unified_money.backend then
        error("Please load ONE Unified Money backend.")
    end
end)

-- APIs

function unified_money.canonical_name(name)
    if not unified_money.backend.canonical_name then
        return name
    end
    return unified_money.backend.canonical_name(name)
end

function unified_money.account_exists(name)
    return unified_money.backend.account_exists(unified_money.canonical_name(name))
end

function unified_money.ensure_exists(name)
    name = unified_money.canonical_name(name)
    if not unified_money.backend.account_exists(name) then
        log("action", "Creating account " .. name .. " for it did not exist")
        if not unified_money.backend.create_account(name) then
            return false
        end
    end
    return true
end

function unified_money.create_account(name, default_value)
    default_value = default_value or 0
    name = unified_money.canonical_name(name)
    log("action", "Creating account " .. name .. " with default value " .. str(default_value))
    return unified_money.backend.create_account(name, default_value)
end

function unified_money.delete_account(name)
    name = unified_money.canonical_name(name)
    log("action", "Delete account " .. name)
    return unified_money.backend.delete_account(name)
end

function unified_money.list_accounts()
    return unified_money.backend.list_accounts()
end

function unified_money.get_balance(name)
    return unified_money.backend.get_balance(unified_money.canonical_name(name))
end

function unified_money.get_balance_safe(name)
    if not unified_money.account_exists(name) then
        return 0
    end
    return unified_money.get_balance(name)
end

function unified_money.set_balance(name, val)
    name = unified_money.canonical_name(name)
    log("action", "Set balance of account " .. name .. " to " .. str(val))
    return unified_money.backend.set_balance(name, val)
end

function unified_money.set_balance_safe(name, val)
    if unified_money.ensure_exists(name) == false then
        return false
    end
    return unified_money.set_balance(name, val)
end

function unified_money.add_balance(name, val)
    local balence = unified_money.get_balance(name)
    if balence == false then return false end
    balence = balence + val
    return unified_money.set_balance(name, balence)
end

function unified_money.add_balance_safe(name, val)
    unified_money.ensure_exists(name)
    return unified_money.add_balance(name, val)
end

function unified_money.del_balance(name, val)
    return unified_money.add_balance(name, val * -1)
end

function unified_money.del_balance_safe(name, val)
    return unified_money.add_balance_safe(name, val * -1)
end

function unified_money.transaction(from, to, amount)
    from = unified_money.canonical_name(from)
    to   = unified_money.canonical_name(to)
    if from == to then
        return false, "FROM_TO_EQ"
    end

    if amount <= 0 then return false, "AMOUNT_NEG" end

    local from_balance = unified_money.get_balance(from)
    local to_exists = unified_money.account_exists(to)

    if from_balance == false or to_exists == false then
        return false, "ACCOUNT_NF"
    end

    if from_balance < amount then
        return false, "FROM_NO_MONEY"
    end

    unified_money.del_balance(from, amount)
    unified_money.add_balance(to, amount)
    return true
end
