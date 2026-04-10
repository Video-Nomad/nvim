local M = {}

local colors_dark = {
  status_line_nc = "#282c34",
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

local colors_light = {
  status_line_nc = "#ccd0da",
  normal_float = "#e6e9ef",
  float_border = "none",
  lsp_signature_active_parameter = "#40a02b",
  yank_color = "#acb0be",
  cursor_line = "#dce0e8",
  match_paren = "#acb0be",
  mini_indent_scope_symbol = "#dce0e8",
  buffer_current_error = "#d20f39",
  buffer_current_warning = "#df8e1d",
  blink_colors = {
    blink_cmp_signature_help = "#e6e9ef",
    blink_cmp_doc = "#e6e9ef",
    blink_cmp_menu = "#e6e9ef",
  },
  spellcheck_highlight = "#d20f39",
  snacks = {
    search_fg = "#eff1f5",
    search_bg = "#d20f39",
    preview_cursor_line_bg = "none",
  },
  supermaven = {
    suggestion_fg = "#4c4f69",
    suggestion_bg = "red",
  },
  indent_blankline = {
    indent = "#dce0e8",
    whitespace = "#dce0e8",
    scope = "#acb0be",
  },
  nvim_surround = {
    highlight_fg = "#eff1f5",
    highlight_bg = "#d20f39",
  },
  spectre = {
    search_fg = "#eff1f5",
    search_bg = "#d20f39",
    replace_fg = "#eff1f5",
    replace_bg = "#40a02b",
  },
}

local current_mode = "dark"

local function persist_file()
  return vim.fn.stdpath("data") .. "/theme_mode"
end

local function save_mode(mode)
  local f = io.open(persist_file(), "w")
  if f then
    f:write(mode)
    f:close()
  end
end

local function load_mode()
  local f = io.open(persist_file(), "r")
  if f then
    local m = f:read("*l")
    f:close()
    if m == "dark" or m == "light" then
      return m
    end
  end
  return "dark"
end

local function apply_theme(mode)
  vim.cmd("highlight clear")
  if vim.g.syntax_on ~= nil then
    vim.cmd("syntax reset")
  end

  if mode == "light" then
    vim.o.background = "light"
    vim.cmd([[colorscheme catppuccin-latte]])
  else
    vim.o.background = "dark"
    vim.cmd([[colorscheme onedark]])
  end

  vim.cmd([[redraw!]])
end

function M.toggle_theme()
  if current_mode == "dark" then
    current_mode = "light"
  else
    current_mode = "dark"
  end
  apply_theme(current_mode)
  save_mode(current_mode)
end

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.schedule(function()
      local table = vim.o.background == "light" and colors_light or colors_dark
      require("highlight").load_highlights(table)
    end)
  end,
})

-- Init: restore last mode
current_mode = load_mode()
apply_theme(current_mode)

-- Command
vim.api.nvim_create_user_command("ToggleLightMode", M.toggle_theme, {})
vim.keymap.set("n", "<F12>", M.toggle_theme, { desc = "Toggle Light Mode" })

return M
