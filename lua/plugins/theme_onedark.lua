local M = { "navarasu/onedark.nvim" }

M.lazy = false
M.priority = 1000
-- M.version = "v0.1.0"

M.config = function()
  require("onedark").setup({
    style = "darker",
    transparent = true,
    -- term_colors = true,
    ending_tildes = false,
    cmp_itemkind_reverse = false,
    toggle_style_key = nil,
    toggle_style_list = {
      "dark",
      "darker",
      "cool",
      "deep",
      "warm",
      "warmer",
      "light",
    },
    code_style = {
      comments = "italic",
      keywords = "none",
      functions = "none",
      strings = "none",
      variables = "none",
    },
    lualine = {
      transparent = false,
    },

    colors = {},
    highlights = {
      Winbar = { bg = 'none' },
      WinbarNC = { bg = 'none' },
      StatusLine = { bg = 'none' },
      StatusLineNC = { bg = 'none' },
      TabLine = { bg = 'none' },
      TabLineFill = { bg = 'none' },
      NormalFloat = { bg = 'none' },
      FloatBorder = { bg = 'none' },
      WinSeparator = { fg = '#282828', bg = 'none' },

      ["@function.builtin"] = { fg = "#61afef" },
      ["@lsp.typemod.variable.readonly.python"] = { fg = "#d19a66" },
      ["@nospell"] = { fg = "none" },
      ["@spell"] = { fg = "none" },
      ["@conceal"] = { fg = "none" },
    },
    diagnostics = {
      darker = true,
      undercurl = true,
      background = true,
    },
  })
end

return M
