local M = { "kylechui/nvim-surround" }

M.version = "*"

M.keys = {
  { 'S', mode = 'v' },
  { 'ds',  mode = 'n' },
}

M.config = function()
    require("nvim-surround").setup()
  end

return M
