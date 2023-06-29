local M = { 'windwp/nvim-ts-autotag' }

M.event = 'VeryLazy'

M.dependencies = { 'nvim-treesitter/nvim-treesitter' }

M.config = function()
  require('nvim-ts-autotag').setup({
    enable = true,
  })
end

return M
