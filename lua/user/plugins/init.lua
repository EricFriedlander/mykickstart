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
-- require 'kickstart.plugins.debug'
require 'kickstart.plugins.indent_line'
-- require 'kickstart.plugins.lint'
-- require 'kickstart.plugins.autopairs'
require 'kickstart.plugins.neo-tree'
-- require 'kickstart.plugins.gitsigns' -- adds gitsigns recommended keymaps

-- NOTE: You can add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
--
--  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
require 'custom.plugins'
