-- [[ Plugin configuration ]]
-- Load plugin modules in the same order as the original init.lua sections.

require 'user.plugins.ui'
require 'user.plugins.telescope'
require 'user.plugins.lsp'
require 'user.plugins.formatting'
require 'user.plugins.completion'
require 'user.plugins.treesitter'

-- [[ Optional / extra plugins ]]
-- NOTE: Uncomment any of the lines below to enable them (you will need to restart nvim).
local gh = require('user.util').gh

vim.pack.add { gh 'ThePrimeagen/vim-be-good' }
require 'vim-be-good'
-- require 'user.plugins.debug'
require 'user.plugins.indent_line'
-- require 'user.plugins.lint'
-- require 'user.plugins.autopairs'
require 'user.plugins.neo-tree'
-- require 'user.plugins.gitsigns' -- adds gitsigns recommended keymaps

-- Personal plugins
require 'user.plugins.image'
require 'user.plugins.molten'
require 'user.plugins.vimtex'
require 'user.plugins.quarto'
require 'user.plugins.ai'
require 'user.plugins.snacks'
require 'user.plugins.vimtex'
