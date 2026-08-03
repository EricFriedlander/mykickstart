--install molten

local gh = require('user.util').gh


vim.g.molten_image_provider = "image.nvim"
vim.g.molten_output_win_max_height = 20

vim.pack.add({ gh "benlubas/molten-nvim" })
