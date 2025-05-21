local M = { 'echasnovski/mini.nvim' }

M.version = false

M.event = "VeryLazy"

M.config = function()
  require('mini.align').setup({
    silent = true,
  })
end

return M
