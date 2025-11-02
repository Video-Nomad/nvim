local M = { "nvim-pack/nvim-spectre" }

M.dependencies = { "nvim-lua/plenary.nvim" }

M.keys = {
  { "<leader>ss" },
  { "<leader>sw", mode = { "v", "n" } },
  { "<leader>sp" },
}

M.config = function()
  local spectre = require("spectre")
  spectre.setup({
    highlight = {
      ui = "String",
      search = "SpectreSearch",
      replace = "SpectreReplace"
    },
  })
  vim.keymap.set("n", "<leader>ss", spectre.toggle)
  vim.keymap.set("n", "<leader>sw", function() spectre.open_visual({ select_word = true }) end)
  vim.keymap.set("v", "<leader>sw", spectre.open_visual)
  vim.keymap.set("n", "<leader>sp", function() spectre.open_file_search({ select_word = true }) end)
end

return M
