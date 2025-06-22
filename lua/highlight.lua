-- ALL THE HIGHLIGHT GROUPS

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

-- Blinking Cursor
-- vim.cmd([[
--   set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
--   \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
--   \,sm:block-blinkwait175-blinkoff150-blinkon175
-- ]])

-- Floating window colors
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#202020" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })

-- Signature help
vim.api.nvim_set_hl(0, "LspSignatureActiveParameter", { fg = "#98C379" })

-- Yank color
vim.api.nvim_set_hl(0, "YankColor", { bg = "#186C3F" })

-- Matching parenthesis highlight
vim.api.nvim_set_hl(0, "MatchParen", { bg = "#515a6b" })

-- Cursor Line
vim.api.nvim_set_hl(0, "CursorLine", { bg = "#262626" })

-- Vim Illuminate Highlight groups
vim.api.nvim_set_hl(0, "IlluminatedWordText", { bold = true })
vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bold = true })
vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bold = true })

-- Indent Blankline Highlight Color
vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = "#303030", nocombine = true })

-- Barbar Colors
vim.api.nvim_set_hl(0, "BufferCurrentERROR", { fg = "#E86671", nocombine = true })
vim.api.nvim_set_hl(0, "BufferCurrentWARN", { fg = "#E5C07B", nocombine = true })

-- Blink
vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelp", { bg = "#202020", nocombine = true })
vim.api.nvim_set_hl(0, "BlinkCmpDoc", { bg = "#202020", nocombine = true })
vim.api.nvim_set_hl(0, "BlinkCmpMenu", { bg = "#202020", nocombine = true })

-- Set spelling check highlight group to purple
vim.api.nvim_set_hl(0, "SpellBad", { sp = "orange", nocombine = true, undercurl = true })

-- Snacks Colors
vim.api.nvim_set_hl(0, "SnacksPickerSearch", { fg = "#ffffff", bg = "#E86671", nocombine = true })
vim.api.nvim_set_hl(0, "SnacksPickerPreviewCursorLine", { bg = "none", nocombine = true })

vim.api.nvim_set_hl(0, "SupermavenSuggestion", { bg = "red", fg = "white", nocombine = true })

-- Indent Blankline Highlight Color
vim.api.nvim_set_hl(0, "IblIndent", { fg = "#363636" })
vim.api.nvim_set_hl(0, "IblWhitespace", { fg = "#363636" })
vim.api.nvim_set_hl(0, "IblScope", { fg = "#444444" })

vim.api.nvim_set_hl(0, "MiniSurround", { fg = "white", bg = "#E86671" })
