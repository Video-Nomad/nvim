local M = { "folke/lazydev.nvim" }

M.lazy = false

M.ft = "lua"

M.config = function()
  ---@class lazydev.Config
  require("lazydev").setup({
    library = {
      { path = "luvit-meta/library", words = { "vim%.uv" } },
      { path = "snacks.nvim", words = { "Snacks" } },
      { path = "lazy.nvim", words = { "lazy" } },
    },
  })
end

return M
