local M = { "stevearc/conform.nvim" }

M.event = "VeryLazy"

M.config = function()
  -- local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
  require("conform").setup({
    formatters_by_ft = {
      sh = { "shfmt" },
      lua = { "stylua" },
      gdscript = { "gdscript-formatter" },
    },
    formatters = {
      shfmt = {
        args = { "-i", "4" },
      },
    },
  })
end

return M
