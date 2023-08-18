local M = { 'mbbill/undotree' }

M.config = function()
  vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, {
    desc = "[u]ndotree",
    silent = true,
    noremap = true,
  })
end

return M
