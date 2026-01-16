local M = { "folke/lazydev.nvim" }

M.ft = "lua" -- only load on lua files

-- Neovim nvim-data folder
-- local data = vim.fn.stdpath("data")

M.opts = {
  library = {
    { path = "luvit-meta/library", words = { "vim%.uv" } },
    "lazy.nvim",
    { path = "snacks.nvim", words = { "Snacks" } },
  },
}

return M
