-- [[ VimTeX: LaTeX authoring ]]
-- Compilation (latexmk), zathura PDF preview with forward/inverse SyncTeX search,
-- rich motions/text-objects, and :VimtexTocOpen. Vimscript plugin: all config is
-- via vim.g.* globals that MUST be set before the plugin loads.

local gh = require('user.util').gh

-- Treat .tex files as LaTeX (not plaintex)
vim.g.tex_flavor = 'latex'

-- PDF viewer with SyncTeX forward/inverse search (requires zathura + zathura-pdf-mupdf)
vim.g.vimtex_view_method = 'zathura'

-- Compiler: latexmk is the default; set explicitly for clarity
vim.g.vimtex_compiler_method = 'latexmk'

-- Conceal disabled: always show raw LaTeX source
vim.g.vimtex_syntax_conceal_disable = 1

-- Don't jump to quickfix on warning-only compiler runs
vim.g.vimtex_quickfix_open_on_warning = 0

vim.pack.add { gh 'lervag/vimtex' }
