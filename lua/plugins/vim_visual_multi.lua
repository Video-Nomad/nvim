local M = { 'mg979/vim-visual-multi' }

M.event = "VeryLazy"

M.branch = 'master'

M.config = function()
  vim.g.VM_default_mappings = 0
end

return M
