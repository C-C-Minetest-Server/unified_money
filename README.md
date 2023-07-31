# Unified API for in-game currency

This mod provides a unified API for managing in-game currency. With this mod, mod creators can concentrate on their mod instead of messing up with different currency mods.

## Shipped submods

* `um_core`: The core. Defines the unified API, and handle registration of backend.
* `um_translate_common`: Common translatable strings.
* `um_backend_plain`: A Unified Money backend that works out-of-the-box. It is standalone, which means it doesn't interact with data of other currency mods.
* `um_frontend_cmd`: A chatcommand-based interface for interacting with Unified Money. Depends on `lib_chatcmdbuilder`.
* `um_plugin_playername`: Create or delete accounts on player account creation/deletion. In another word, this mod enforces a relationship between player accounts and Unified Money accounts. External mods, backends and frontends assuming this relationship should depend on this mod.

## Structure

The `um_core` mod handles the conversation between the easy-to-use frontend APIs and the basic backend APIs, and ensure one (and only one) backend is installed. Mods willing to use Unified Money should depend on this mod. The syntax of the frontend API is documented in `um_core/README.md`.

Backends should depend on `um_core` and use `unified_money.register_backend` to register the backend. Only one mod can register a backend, or in other words, only one backend mod can be loaded. The syntax of the backend API is documented in `um_backend_plain/init.lua`.

Mod developers should avoid the direct use of backend APIs, as frontend APIs implements safety checks and logging functions.

## TODOs

* [ ] Flow-based Formspec GUI for management
* [ ] More backend implements
  * Other backends will be published as their own mod in CDB, not included in this modpack.

## License

Copyright (C) 2023  1F616EMO

This library is free software; you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation; either version 2.1 of the License, or (at your option) any later version.

This library is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with this library; if not, write to the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301 USA

Side notes: `LICENSE.simple_skins` is not the license file applying to the main scripts. It only applies to a small proportion of `um_translate_common/{generate.py,init.lua}`. See their comments for more details.
