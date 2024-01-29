local M = { 'navarasu/onedark.nvim' }

M.lazy = false
M.priority = 1000

M.opts = {
  style = 'dark',
  transparent = true,
  term_colors = true,
  ending_tildes = false,
  cmp_itemkind_reverse = false,
  toggle_style_key = nil,
  toggle_style_list = { 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light' },
  code_style = {
    comments = 'italic',
    keywords = 'none',
    functions = 'none',
    strings = 'none',
    variables = 'none'
  },
  lualine = {
    transparent = false,
  },
  colors = {},
  highlights = {
    ["@function.builtin"] = { fg = '#61afef' },
  },
  diagnostics = {
    darker = true,
    undercurl = true,
    background = true,
  },
}

return M
