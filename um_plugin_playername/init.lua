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