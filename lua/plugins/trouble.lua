local M = { "folke/trouble.nvim" }

M.event = "VeryLazy"

M.dependencies = { "nvim-tree/nvim-web-devicons" }

M.config = function()
  require("trouble").setup({})

  -- vim.keymap.set("n", "<leader>xx", function() require("trouble").toggle() end)
  vim.keymap.set("n", "<leader>sd", "<cmd>Trouble diagnostics toggle<cr>")
  -- vim.keymap.set("n", "<leader>xd", function() require("trouble").toggle("document_diagnostics") end)
  -- vim.keymap.set("n", "<leader>xq", function() require("trouble").toggle("quickfix") end)
  -- vim.keymap.set("n", "<leader>xl", function() require("trouble").toggle("loclist") end)
  -- vim.keymap.set("n", "gR", function() require("trouble").toggle("lsp_references") end)
end

return M
