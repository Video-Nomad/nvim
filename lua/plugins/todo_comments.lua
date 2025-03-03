local M = { "folke/todo-comments.nvim" }

M.dependencies = { "folke/snacks.nvim" }

local function todo()
  Snacks.picker.todo_comments({
    keywords = { "FIX", "FIXME", "BUG", "CRITICAL", "FIXIT", "ISSUE", "WIP", "UNFINISHED", "FINISH", "TODO", "HACK",
      "WARN",
      "WARNING", "XXX", "PERF", "OPTIM", "PERFORMANCE", "OPTIMIZE", "TEST", "TESTING", "PASSED", "FAILED" },
  })
end

local function todo_notes()
  Snacks.picker.todo_comments({
    keywords = { "NOTE", "INFO" },
  })
end

M.keys = {
  { "<leader>wt", todo,       desc = "Todo" },
  { "<leader>wn", todo_notes, desc = "Todo/Fix/Fixme" },
}

M.opts = {
  signs = true,
  sign_priority = 8,
  keywords = {
    FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE", "CRITICAL" } },
    WIP = { icon = " ", color = "warning", alt = { "UNFINISHED", "FINISH" } },
    TODO = { icon = " ", color = "info" },
    HACK = { icon = " ", color = "warning" },
    WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
    PERF = { icon = "󰓅 ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
    TEST = { icon = "󰙨 ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
    NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
  },
  gui_style = {
    fg = "NONE",
    bg = "BOLD",
  },
  merge_keywords = true,
  highlight = {
    multiline = true,
    multiline_pattern = "^.",
    multiline_context = 10,
    before = "",
    keyword = "bg",
    after = "fg",
    pattern = [[.*<(KEYWORDS)\s*:]],
    comments_only = true,
    max_line_len = 400,
    exclude = {},
  },
  colors = {
    error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
    warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
    info = { "DiagnosticInfo", "#2563EB" },
    hint = { "DiagnosticHint", "#10B981" },
    default = { "Identifier", "#7C3AED" },
    test = { "Identifier", "#FF00FF" },
  },
  search = {
    command = "rg",
    args = {
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
    },
    pattern = [[\b(KEYWORDS):]],
  },
}

return M
