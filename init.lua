-- Entry point for the Neovim config.
-- Globals (leader keys, nerd font flag) are set here because they must exist
-- before any plugin or module loads.  Everything else lives in lua/user/.

-- Enable faster startup by caching compiled Lua modules.
vim.loader.enable()

-- Set <space> as the leader key.
-- See `:help mapleader`
-- NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used).
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal.
vim.g.have_nerd_font = true

require 'user.local'   -- point to local stuff
require 'user.options' -- vim.o settings + vim.diagnostic.config
require 'user.keymaps' -- non-plugin keymaps
require 'user.autocmds' -- yank-highlight + vim.pack build hooks (must come before plugins)
require 'user.plugins' -- all plugin installation and configuration

-- vim: ts=2 sts=2 sw=2 et
