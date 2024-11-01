local M = { "nvimtools/none-ls.nvim" }

M.event = "VeryLazy"

M.dependancies = {
  "nvim-lua/plenary.nvim",
  "nvimtools/none-ls-extras.nvim",
}

M.config = function()
  local null_ls = require("null-ls")

  null_ls.setup({
    sources = {},
  })
end

return M
