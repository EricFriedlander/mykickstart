local gh = require('user.util').gh

vim.pack.add { gh 'folke/snacks.nvim' }

require('snacks').setup {}
