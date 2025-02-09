local M = { 'echasnovski/mini.indentscope' }

M.version = false

M.event = "VeryLazy"

M.config = function()
  vim.g.miniindentscope_disable = true
  require('mini.indentscope').setup({
    draw = {
      animation = require('mini.indentscope').gen_animation.none()
    },
    symbol = "│"
  })
  vim.keymap.set("n", "<leader>in", function()
    vim.g.miniindentscope_disable = not vim.g.miniindentscope_disable
  end, { desc = "Toggle Indent Scope" })
end

return M
