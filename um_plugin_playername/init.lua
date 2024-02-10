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

-- We use on_joinplayer to regenerate (somehow accidentally) deleted accounts

minetest.register_on_joinplayer(function(ObjectRef, last_login)
    local name = ObjectRef:get_player_name()
    unified_money.ensure_exists(name)
end)

do
    local old_remove_player = minetest.remove_player
    function minetest.remove_player(name)
        local status = old_remove_player(name)
        if status == 0 then
            unified_money.delete_account(name)
        end
        return status
    end
end
