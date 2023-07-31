# Unified API for in-game currency

This mod provides a unified API for managing in-game currency. With this mod, mod creators can concentrate on their mod instead of messing up with different currency mods.

## Shipped submods

* `um_core`: The core. Defines the unified API, and handle registration of backend.
* `um_translate_common`: Common translatable strings.
* `um_backend_plain`: A Unified Money backend that works out-of-the-box. It is standalone, which means it doesn't interact with data of other currency mods.
* `um_frontend_cmd`: A chatcommand-based interface for interacting with Unified Money. Depends on `lib_chatcmdbuilder`.
* `um_plugin_playername`: Create or delete accounts on player account creation/deletion

## Structure

The `um_core` mod handles the conversation between the easy-to-use frontend APIs and the basic backend APIs, and ensure one (and only one) backend is installed. Mods willing to use Unified Money should depend on this mod. The syntax of the frontend API is documented in `um_core/README.md`.

Backends should depend on `um_core` and use `unified_money.register_backend` to register the backend. Only one mod can register a backend, or in other words, only one backend mod can be loaded. The syntax of the backend API is documented in `um_backend_plain/init.lua`.

Mod developers should avoid the direct use of backend APIs, as frontend APIs implements safety checks and logging functions.

## TODOs

* [ ] Flow-based Formspec GUI for management
* [ ] More backend implements
