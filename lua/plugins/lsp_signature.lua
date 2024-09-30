local M = { "ray-x/lsp_signature.nvim" }

M.event = "VeryLazy"

M.config = function()
  require("lsp_signature").setup({
    hint_prefix = "😸 ",
  })
end

return M
