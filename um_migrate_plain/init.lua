--[[
    Copyright (C) 2024  1F616EMO

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

if minetest.get_modpath("um_backend_plain") then
    error("[um_migrate_plain] This mod conflicts with um_backend_plain. Please install another backend.")
end

local S = minetest.get_translator("um_migrate_plain")

minetest.register_chatcommand("um_migrate_plain", {
    description = S("Reads data of um_backend_plain and write it into the currently active backend."),
    privs = { server = true },
    func = function(name, param)
        local f = io.open(minetest.get_worldpath() .. "/um_backend_plain.lua", "r")
        if not f then
            return false, S("um_backend_plain savefile not found.")
        end

        local f_txt = f:read("*a")
        f:close()
        f = nil

        local i = 0
        local db = minetest.deserialize(f_txt)
        for name, balance in pairs(db) do
            i = i + 1
            unified_money.set_balance(name, balance)
        end

        return true, S("Migration finished, @1 records loaded", i)
    end,
})