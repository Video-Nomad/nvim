local M = { "stevearc/conform.nvim" }

M.event = "VeryLazy"

M.config = function()
  require("conform").setup({
    formatters_by_ft = {
      sh = { "shfmt" },
      lua = { "stylua" },
    },
    formatters = {
      shfmt = {
        args = { "-i", "4" },
      },
    },
  })
end

return M
