local M = { 'mg979/vim-visual-multi' }

M.keys = {
  { "<C-n>",    mode = { "n", "v" } },
  { "<C-Down>", mode = "n" },
  { "<C-Up>",   mode = "n" },
}

M.branch = 'master'

M.config = function()
  vim.g.VM_default_mappings = 0
end

return M
