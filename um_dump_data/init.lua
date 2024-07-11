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

local S = minetest.get_translator("um_dump_data")

local function get_dump_table()
    local dump_table = {}
    for _, name in ipairs(unified_money.list_accounts()) do
        dump_table[name] = unified_money.get_balance(name)
    end
    return dump_table
end

local WP = minetest.get_worldpath()
minetest.register_chatcommand("um_dump_data", {
    description = S("Dump all data of the current backend to a um_backend_plain-compactibible file"),
    param = S("<path, relative to world directory>"),
    privs = { server = true },
    func = function(_, param)
        param = string.trim(param)
        if param == "" then
            return false, S("Path not given")
        end

        local dump_table = get_dump_table()
        local serialized = minetest.serialize(dump_table)
        local path = WP .. DIR_DELIM .. param
        minetest.safe_file_write(path, serialized)
        return true, S("Data dumped to @1", path)
    end,
})
