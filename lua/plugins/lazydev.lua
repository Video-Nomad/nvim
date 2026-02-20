local M = { "folke/lazydev.nvim" }

M.lazy = false

M.ft = "lua"

M.opts = {
  library = {
    { path = "luvit-meta/library", words = { "vim%.uv" } },
    { path = "snacks.nvim", words = { "Snacks" } },
    { path = "lazy.nvim", words = { "lazy" } },
  },
}

return M
