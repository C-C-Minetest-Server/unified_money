read_globals = {
    "DIR_DELIM",
    "INIT",

    "minetest",
    "core",
    "dump",
    "dump2",

    "Raycast",
    "Settings",
    "PseudoRandom",
    "PerlinNoise",
    "VoxelManip",
    "SecureRandom",
    "VoxelArea",
    "PerlinNoiseMap",
    "PcgRandom",
    "ItemStack",
    "AreaStore",

    "vector",

    table = {
        fields = {
            "copy",
            "indexof",
            "insert_all",
            "key_value_swap",
            "shuffle",
        }
    },

    string = {
        fields = {
            "split",
            "trim",
        }
    },

    math = {
        fields = {
            "hypot",
            "sign",
            "factorial"
        }
    },
}

files["um_backend_dummy"] = {
    read_globals = {
        "unified_money", -- um_core
        "um_utils",      -- um_utils
    },
}

files["um_backend_plain"] = {
    read_globals = {
        "unified_money", -- um_core
    },
}

files["um_core"] = {
    globals = {
        "unified_money",
    },
}

files["um_dump_data"] = {
    read_globals = {
        "unified_money", -- um_core
    },
}

files["um_frontend_cmd"] = {
    read_globals = {
        "unified_money",       -- um_core
        "chatcmdbuilder",      -- lib_chatcmdbuilder
        "um_translate_common", -- um_translate_common
    },
}

files["um_migrate_plain"] = {
    read_globals = {
        "unified_money",       -- um_core
    },
}

files["um_plugin_playername"] = {
    read_globals = {
        "unified_money", -- um_core
    },
}

files["um_translate_common"] = {
    globals = {
        "um_translate_common",
    },
}

files["um_utils"] = {
    globals = {
        "um_utils",
    },
}
