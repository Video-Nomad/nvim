local M = { "kylechui/nvim-surround" }

M.version = "*"

M.event = "VeryLazy"

M.config = function()
  require("nvim-surround").setup({
    -- Configuration here, or leave empty to use defaults
  })
end

return M
