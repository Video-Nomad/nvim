local M = { 'johmsalas/text-case.nvim' }

M.keys = {
  { '<leader>tc' },
}

M.config = function()
  vim.keymap.set('n', '<leader>tc', function()
    require('textcase').open_telescope()
  end, { desc = "Toggle Text Case" })
end

return M
