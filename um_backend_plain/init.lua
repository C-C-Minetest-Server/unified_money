local MP = minetest.get_worldpath()
local SAVEFILE = MP .. "/um_backend_plain.lua"

local savefile_fd = io.open(SAVEFILE, "r")
local database
if not savefile_fd then
    database = {}
else
    local savefile_txt = savefile_fd:read("*a")
    savefile_fd:close()
    savefile_fd = nil
    database = minetest.deserialize(savefile_txt) or {}
end

local function save()
    minetest.log("action","[um_backend_plain] Saving file")
    minetest.safe_file_write(SAVEFILE,minetest.serialize(database))
end

minetest.after(30,function()
    save()
    minetest.after(60,save)
end)

minetest.register_on_shutdown(save)

-- All functions return boolean indicating success unless otherwise specified
unified_money.register_backend({
    -- Get the balance of a account
    -- name: The name of the player
    get_balance = function(name)
        return database[name]
    end,
    -- Set the balance of a account
    -- name: The name of the player
    set_balance = function(name,val)
        if not database[name] then return false end
        database[name] = val
        return true
    end,
    -- Create an account, return true if already exists or created
    -- default_val: int, the value to be set upon creation
    create_account = function(name,default_val)
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
        for k,_ in pairs(database) do
            table.insert(RLST,k)
        end
        return RLST
    end,
})