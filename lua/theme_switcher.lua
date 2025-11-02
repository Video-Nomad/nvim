local M = {}

vim.cmd([[colorscheme onedark]])

---@type ColorTable
local colors_dark = {
  normal_float = "#202020",
  float_border = "none",
  lsp_signature_active_parameter = "#98C379",
  yank_color = "#535a6c",
  cursor_line = "#262626",
  match_paren = "#515a6b",
  mini_indent_scope_symbol = "#303030",
  buffer_current_error = "#E86671",
  buffer_current_warning = "#E5C07B",
  blink_colors = {
    blink_cmp_signature_help = "#202020",
    blink_cmp_doc = "#202020",
    blink_cmp_menu = "#202020",
  },
  spellcheck_highlight = "#E86671",
  snacks = {
    search_fg = "#ffffff",
    search_bg = "#E86671",
    preview_cursor_line_bg = "none",
  },
  supermaven = {
    suggestion_fg = "white",
    suggestion_bg = "red",
  },
  indent_blankline = {
    indent = "#363636",
    whitespace = "#363636",
    scope = "#444444",
  },
  nvim_surround = {
    highlight_fg = "white",
    highlight_bg = "#E86671",
  },
  spectre = {
    search_fg = "black",
    search_bg = "#E86671",
    replace_fg = "black",
    replace_bg = "#98C379",
  },
}

local highlight = require("highlight")
highlight:load_highlights(colors_dark)

return M
