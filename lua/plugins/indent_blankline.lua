local M = { "lukas-reineke/indent-blankline.nvim" }

M.event = "VeryLazy"

M.opts = {
  show_trailing_blankline_indent = false,
  char_highlight_list = {
    'IndentBlanklineIndent1',
  }
}

return M
