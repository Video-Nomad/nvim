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

--[[

Example custom colors and Highlights config

require('onedark').setup {
  colors = {
    bright_orange = "#ff8800",    -- define a new color
    green = '#00ffaa',            -- redefine an existing color
  },
  highlights = {
    ["@keyword"] = {fg = '$green'},
    ["@string"] = {fg = '$bright_orange', bg = '#00ff00', fmt = 'bold'},
    ["@function"] = {fg = '#0000ff', sp = '$cyan', fmt = 'underline,italic'},
    ["@function.builtin"] = {fg = '#0059ff'}
  }
}
Note that TreeSitter keywords have been changed after neovim version 0.8 and onwards. TS prefix is trimmed and lowercase words should be used separated with '.'

The old way before neovim 0.8 looks like this. For all keywords see this file from line 133 to 257

require('onedark').setup {
  colors = {
    bright_orange = "#ff8800",    -- define a new color
    green = '#00ffaa',            -- redefine an existing color
  },
  highlights = {
    TSKeyword = {fg = '$green'},
    TSString = {fg = '$bright_orange', bg = '#00ff00', fmt = 'bold'},
    TSFunction = {fg = '#0000ff', sp = '$cyan', fmt = 'underline,italic'},
    TSFuncBuiltin = {fg = '#0059ff'}
  }
}
]]

return M
