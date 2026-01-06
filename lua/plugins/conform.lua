local M = { "stevearc/conform.nvim" }

M.event = "VeryLazy"

M.config = function()
  local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
  require("conform").setup({
    formatters_by_ft = {
      sh = { "shfmt" },
      lua = { "stylua" },
      gdscript = { "gdformat" },
    },
    formatters = {
      shfmt = {
        args = { "-i", "4" },
      },
      gdformat = {
        command = mason_bin .. "/gdformat.cmd",
      },
      gdlint = {
        command = mason_bin .. "/gdlint.cmd",
      }
    },
  })
end

return M
