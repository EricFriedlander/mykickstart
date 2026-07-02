-- [[ Formatting ]]

local gh = require('user.util').gh

vim.pack.add { gh 'stevearc/conform.nvim' }
require('conform').setup {
  notify_on_error = false,
  format_on_save = function(bufnr)
    -- You can specify filetypes to autoformat on save here:
    local enabled_filetypes = {
      -- lua = true,
      -- python = true,
    }
    if enabled_filetypes[vim.bo[bufnr].filetype] then
      return { timeout_ms = 500 }
    else
      return nil
    end
  end,
  default_format_opts = {
    lsp_format = 'fallback', -- Use external formatters if configured below, otherwise use LSP formatting. Set to `false` to disable LSP formatting entirely.
  },
  -- You can also specify external formatters in here.
  formatters_by_ft = {
    lua = { 'stylua' },
    -- rust = { 'rustfmt' },
    -- Conform can also run multiple formatters sequentially
    python = { 'isort', 'black' },
    quarto = { 'injected' },
    markdown = { 'injected' },
    r = { 'styler' },
    --
    -- You can use 'stop_after_first' to run the first available formatter from the list
    -- javascript = { "prettierd", "prettier", stop_after_first = true },
  },
}

-- Customize the "injected" formatter
require('conform').formatters.injected = {
  -- Set the options field
  options = {
    -- Set to true to ignore errors
    ignore_errors = false,
    -- Map of treesitter language to file extension
    -- A temporary file name with this extension will be generated during formatting
    -- because some formatters care about the filename.
    lang_to_ext = {
      bash = 'sh',
      c_sharp = 'cs',
      elixir = 'exs',
      javascript = 'js',
      julia = 'jl',
      latex = 'tex',
      markdown = 'md',
      python = 'py',
      ruby = 'rb',
      rust = 'rs',
      teal = 'tl',
      r = 'r',
      typescript = 'ts',
    },
    -- Map of treesitter language to formatters to use
    -- (defaults to the value from formatters_by_ft)
    lang_to_formatters = {},
  },
}

vim.keymap.set({ 'n', 'v' }, '<leader>f', function() require('conform').format { async = true } end, { desc = '[F]ormat buffer' })
