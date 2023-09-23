local M = { 'mg979/vim-visual-multi' }

M.keys = {
  { "<C-n>",    mode = { "n", "v" } },
  { "<C-Down>", mode = "n" },
  { "<C-Up>",   mode = "n" },
}

M.branch = 'master'

M.config = function()
  vim.g.VM_default_mappings = 0
  vim.g.VM_silent_exit = 1
  vim.g.VM_theme = "neon"
  vim.g.VM_show_warnings = 0
  vim.g.VM_quit_after_leaving_insert_mode = 1
end

return M
