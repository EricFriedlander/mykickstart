-- [[ Quarto editing support ]]
-- quarto-nvim + otter.nvim for LSP/completion inside code cells,
-- vim-slime for sending cells to a terminal REPL,
-- img-clip for pasting clipboard images,
-- nabla for inline math preview,
-- jupytext for opening .ipynb notebooks directly as .qmd (needs `pip install jupytext`).

local gh = require('user.util').gh

-- [[ vim-slime globals must be set before the plugin loads ]]
vim.g.slime_target = 'neovim'
vim.g.slime_no_mappings = true
vim.g.slime_python_ipython = 1 -- enables %cpaste for multi-line ipython paste

vim.pack.add {
  gh 'quarto-dev/quarto-nvim',
  gh 'jmbuhr/otter.nvim',
  gh 'jpalardy/vim-slime',
  gh 'HakonHarnes/img-clip.nvim',
  gh 'jbyuki/nabla.nvim',
  gh 'GCBallesteros/jupytext.nvim',
}

-- [[ Otter: LSP features inside embedded code cells ]]
require('otter').setup {}

-- [[ Quarto: core setup ]]
require('quarto').setup {
  lspFeatures = {
    enabled = true,
    chunks = 'curly', -- treat ```{python} / ```{r} curly-brace chunks as cells
  },
  codeRunner = {
    enabled = true,
    default_method = 'molten',
  },
}

-- [[ Activation + buffer-local runner keymaps for quarto/markdown ]]
--  quarto.activate() wires otter LSP into the buffer so completion and
--  hover/goto-definition work inside code cells.
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('user-quarto', { clear = true }),
  pattern = { 'quarto', 'markdown' },
  callback = function(args)
    require('quarto').activate()

    local runner = require 'quarto.runner'
    local map = function(lhs, rhs, desc, mode) vim.keymap.set(mode or 'n', lhs, rhs, { buffer = args.buf, desc = desc, silent = true }) end

    map('<localleader>rc', runner.run_cell, 'run [c]ell')
    map('<localleader>ra', runner.run_above, 'run cell and [a]bove')
    map('<localleader>rA', runner.run_all, 'run [A]ll cells')
    map('<localleader>rl', runner.run_line, 'run [l]ine')
    map('<localleader>r', runner.run_range, 'run visual [r]ange', 'v')
    map('<localleader>RA', function() runner.run_all(true) end, 'run [A]ll cells (all languages)')
    map('<localleader>qp', '<cmd>QuartoPreview<cr>', '[q]uarto [p]review')
    map('<localleader>qf', function()
      local file = vim.fn.expand '%:p'
      vim.cmd('tabnew | term quarto preview ' .. vim.fn.shellescape(file))
    end, '[q]uarto preview [f]ile only')
  end,
})

-- [[ vim-slime: mark/set the target terminal ]]
--  <leader>cm in a :terminal buffer prints that buffer's job_id.
--  <leader>cs opens slime's prompt to configure which terminal to send to.
vim.keymap.set('n', '<leader>cm', function() vim.print('terminal job_id: ' .. tostring(vim.b.terminal_job_id)) end, { desc = '[c]ode [m]ark terminal' })
vim.keymap.set('n', '<leader>cs', function() vim.fn.call('slime#config', {}) end, { desc = '[c]ode [s]et terminal' })

-- [[ img-clip: paste clipboard images into quarto/markdown ]]
require('img-clip').setup {
  default = {
    dir_path = 'img',
    drag_and_drop = { enabled = false },
  },
  filetypes = {
    markdown = { url_encode_path = true, template = '![$CURSOR]($FILE_PATH)' },
    quarto = { url_encode_path = true, template = '![$CURSOR]($FILE_PATH)' },
  },
}
vim.keymap.set('n', '<leader>ii', '<cmd>PasteImage<cr>', { desc = '[i]nsert [i]mage from clipboard' })

-- [[ nabla: toggle inline rendered LaTeX math ]]
vim.keymap.set('n', '<leader>qm', function() require('nabla').toggle_virt() end, { desc = '[q]uarto toggle [m]ath' })

-- [[ jupytext: open .ipynb notebooks as .qmd quarto documents ]]
--  Converts on open and back on save. Requires `pip install jupytext`.
require('jupytext').setup {
  custom_language_formatting = {
    python = { extension = 'qmd', style = 'quarto', force_ft = 'quarto' },
    r = { extension = 'qmd', style = 'quarto', force_ft = 'quarto' },
  },
}

-- paste an image from the clipboard or drag-and-drop
vim.pack.add{ gh 'HakonHarnes/img-clip.nvim' }
require('img-clip').setup{ 
  default = {
    dir_path = 'images',
    drag_and_drop = {
      enabled = true,
      insert_mode = false,
    },
  filetypes = {
    markdown = {
      url_encode_path = true,
      template = '![$CURSOR]($FILE_PATH)',
      drag_and_drop = {
        download_images = false,
      },
    },
    quarto = {
      url_encode_path = true,
      template = '![$CURSOR]($FILE_PATH)',
      drag_and_drop = {
        download_images = false,
        },
     },
   },
  },
}

vim.keymap.set('n', '<leader>p', ':PasteImage<cr>', { desc = 'insert [i]mage from clipboard'})
