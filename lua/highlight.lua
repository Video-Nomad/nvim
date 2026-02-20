-- ALL THE HIGHLIGHT GROUPS
local M = {}

---@param color_table ColorTable
function M:load_highlights(color_table)
  -- Highlight on Yank
  local yank_autogroup = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
  local illuminate = require("illuminate.engine") -- Check if we have illuminate
  vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
      if illuminate then
        illuminate.pause()
      end
      vim.highlight.on_yank({
        higroup = "YankColor",
      })
      if illuminate then
        illuminate.resume()
      end
    end,
    group = yank_autogroup,
    pattern = "*",
  })

  -- Floating window colors
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = color_table.normal_float })
  vim.api.nvim_set_hl(0, "FloatBorder", { bg = color_table.float_border })

  -- Signature help
  vim.api.nvim_set_hl(0, "LspSignatureActiveParameter", { fg = color_table.lsp_signature_active_parameter })

  -- Yank color
  vim.api.nvim_set_hl(0, "YankColor", { bg = color_table.yank_color })

  -- Matching parenthesis highlight
  vim.api.nvim_set_hl(0, "MatchParen", { bg = color_table.match_paren })

  -- Cursor Line
  vim.api.nvim_set_hl(0, "CursorLine", { bg = color_table.cursor_line })

  -- Vim Illuminate Highlight groups
  vim.api.nvim_set_hl(0, "IlluminatedWordText", { bold = true })
  vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bold = true })
  vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bold = true })

  -- Indent Blankline Highlight Color
  vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = color_table.mini_indent_scope_symbol, nocombine = true })

  -- Barbar Colors
  vim.api.nvim_set_hl(0, "BufferCurrentERROR", { fg = color_table.buffer_current_error, nocombine = true })
  vim.api.nvim_set_hl(0, "BufferCurrentWARN", { fg = color_table.buffer_current_warning, nocombine = true })

  -- Blink
  vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelp",
    { bg = color_table.blink_colors.blink_cmp_signature_help, nocombine = true })
  vim.api.nvim_set_hl(0, "BlinkCmpDoc", { bg = color_table.blink_colors.blink_cmp_doc, nocombine = true })
  vim.api.nvim_set_hl(0, "BlinkCmpMenu", { bg = color_table.blink_colors.blink_cmp_menu, nocombine = true })

  -- Set spelling check highlight group to purple
  vim.api.nvim_set_hl(0, "SpellBad", { sp = color_table.spellcheck_highlight, nocombine = true, undercurl = true })

  -- Snacks Colors
  vim.api.nvim_set_hl(0, "SnacksPickerSearch",
    { fg = color_table.snacks.search_fg, bg = color_table.snacks.search_bg, nocombine = true })
  vim.api.nvim_set_hl(0, "SnacksPickerPreviewCursorLine",
    { bg = color_table.snacks.preview_cursor_line_bg, nocombine = true })

  vim.api.nvim_set_hl(0, "SupermavenSuggestion", {
    bg = color_table.supermaven.suggestion_bg, fg = color_table.supermaven.suggestion_fg, nocombine = true
  })

  -- Indent Blankline Highlight Color
  vim.api.nvim_set_hl(0, "IblIndent", { fg = color_table.indent_blankline.indent })
  vim.api.nvim_set_hl(0, "IblWhitespace", { fg = color_table.indent_blankline.whitespace })
  vim.api.nvim_set_hl(0, "IblScope", { fg = color_table.indent_blankline.scope })

  -- Indentmini
  vim.api.nvim_set_hl(0, "IndentLine", { fg = color_table.indent_blankline.indent })
  vim.api.nvim_set_hl(0, "IndentLineCurrent", { fg = color_table.indent_blankline.scope })

  -- Gray out hidden files and folders when they are shown
  vim.api.nvim_set_hl(0, "NvimTreeHiddenFile", { link = "Comment" })
  vim.api.nvim_set_hl(0, "NvimTreeHiddenFolder", { link = "Comment" })

  vim.api.nvim_set_hl(0, "NvimSurroundHighlight",
    { fg = color_table.nvim_surround.highlight_fg, bg = color_table.nvim_surround.highlight_bg })

  -- Spectre
  vim.api.nvim_set_hl(0, "SpectreSearch",
    { fg = color_table.spectre.search_fg, bg = color_table.spectre.search_bg })
  vim.api.nvim_set_hl(0, "SpectreReplace",
    { fg = color_table.spectre.replace_fg, bg = color_table.spectre.replace_bg })
end

return M
