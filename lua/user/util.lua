-- Shared utilities for user config modules.

local M = {}

---Build a GitHub URL for a plugin repo.
---@param repo string e.g. "nvim-lua/plenary.nvim"
---@return string
function M.gh(repo) return 'https://github.com/' .. repo end

return M
