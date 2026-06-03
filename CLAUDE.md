# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal Neovim configuration forked from [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim). It uses Neovim's built-in `vim.pack` (introduced in Neovim 0.11) for plugin management instead of lazy.nvim.

## Lua Formatting

All Lua files must be formatted with StyLua before committing. The config is in `.stylua.toml`:

```
column_width = 160, indent: 2 spaces, single quotes preferred, no call parentheses, always collapse simple statements
```

Check formatting:
```sh
stylua --check .
```

Apply formatting:
```sh
stylua .
```

## Architecture

### Load order (`init.lua`)

`init.lua` sets globals (`mapleader`, `maplocalleader`, `have_nerd_font`) then loads four modules in order:

1. `user.options` — `vim.o` settings and `vim.diagnostic.config`
2. `user.keymaps` — non-plugin keymaps
3. `user.autocmds` — yank highlight and `PackChanged` build hooks for plugins that require a build step (telescope-fzf-native, LuaSnip, nvim-treesitter)
4. `user.plugins` — all plugin installation and configuration

### Plugin system (`vim.pack`)

Plugins are installed via `vim.pack.add { url }`. The helper `require('user.util').gh(repo)` expands `"author/repo"` to a full GitHub URL. Build hooks for plugins that need a compile step (e.g. `telescope-fzf-native.nvim`, `LuaSnip`, `nvim-treesitter`) live in `lua/user/autocmds.lua` under the `PackChanged` autocmd.

### Plugin modules (`lua/user/plugins/`)

All plugin files live flat in this directory. `init.lua` `require`s active ones;
opt-in plugins are listed as commented `require`s and can be enabled by
uncommenting. A health check is exposed via `lua/user/health.lua`
(`:checkhealth user`).

| File | Purpose |
|---|---|
| `ui.lua` | guess-indent, gitsigns, which-key, tokyonight colorscheme, todo-comments, mini.nvim (ai, surround, statusline) |
| `telescope.lua` | Telescope setup, all `<leader>s*` search keymaps, LSP picker keymaps wired on `LspAttach` |
| `lsp.lua` | Mason, nvim-lspconfig, mason-lspconfig, mason-tool-installer; `LspAttach` keymaps (`grn`, `gra`, `grD`, `<leader>th`) |
| `formatting.lua` | conform.nvim; `<leader>f` to format; format-on-save disabled by default (enable per filetype in `enabled_filetypes`) |
| `completion.lua` | blink.cmp (autocomplete) + LuaSnip (snippets) |
| `treesitter.lua` | nvim-treesitter; auto-installs parsers on `FileType`; base parsers pre-installed |
| `quarto.lua` | quarto-nvim + otter.nvim (LSP in code cells), vim-slime (REPL execution), img-clip (`<leader>ii`), nabla (`<leader>qm`), jupytext (.ipynb → .qmd, needs `pip install jupytext`); cell-runner keymaps (`<localleader>r*`) wired via `FileType` autocmd |
| `indent_line.lua` | indent guides — **on by default** |
| `neo-tree.lua` | file explorer (`\` to open) — **on by default** |
| `debug.lua` | DAP debugging — opt-in |
| `lint.lua` | nvim-lint — opt-in |
| `autopairs.lua` | auto bracket pairs — opt-in |
| `gitsigns.lua` | extended gitsigns keymaps — opt-in (base gitsigns is in `ui.lua`) |

### Key LSP servers

Configured in `lua/user/plugins/lsp.lua` under `servers`:
- `lua_ls` — Lua, with formatting disabled (StyLua handles it)
- `stylua` — installed via Mason for formatting

To add a new LSP, add it to the `servers` table in `lsp.lua`.
