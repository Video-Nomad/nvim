local M = { "folke/zen-mode.nvim" }

M.lazy = true

M.keys = {
  { "<leader>z" },
}

M.opts = {
}

toggleZenMode = function()
  require("zen-mode").toggle()
end

M.config = function()
  vim.keymap.set('n', '<leader>z', toggleZenMode, { noremap = true, silent = true })
end

return M
