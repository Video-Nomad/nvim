local M = { "ray-x/lsp_signature.nvim" }

M.event = "VeryLazy"

M.config = function()
  require("lsp_signature").setup({})
end

return M
