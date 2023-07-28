local M = { "Zeioth/compiler.nvim" }

M.cmd = { "CompilerOpen", "CompilerToggleResults" }

M.dependencies = { "stevearc/overseer.nvim" }

M.config = function()
  require("compiler").setup({})

  -- Open compiler
  vim.api.nvim_buf_set_keymap(0, 'n', '<F6>', "<cmd>CompilerOpen<cr>", { noremap = true, silent = true })
  -- Toggle output resume
  vim.api.nvim_buf_set_keymap(0, 'n', '<S-F6>', "<cmd>CompilerToggleResults<cr>", { noremap = true, silent = true })
end

return M
