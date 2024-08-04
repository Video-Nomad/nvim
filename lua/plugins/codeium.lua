local M = { "Exafunction/codeium.vim" }

vim.g.codeium_disable_bindings = 1
vim.g.codeium_manual = false
vim.g.codeium_idle_delay = 100

M.commit = "289eb724e5d6fab2263e94a1ad6e54afebefafb2"

M.cmd = {
  "Codeium",
  "CodeiumAuto",
  "CodeiumManual",
  "CodeiumToggle",
  "CodeiumEnable",
  "CodeiumDisable",
}

M.keys = {
  {
    "<A-c>",
    function()
      return vim.fn["codeium#Complete"]()
    end,
    mode = "i",
    desc = "Generate AI Completion",
    expr = true,
  },
  {
    "<A-a>",
    function()
      return vim.fn["codeium#Accept"]()
    end,
    mode = "i",
    desc = "Accept AI Completion",
    expr = true,
  },
  {
    "<A-]>",
    function()
      return vim.fn["codeium#CycleCompletions"](1)
    end,
    mode = "i",
    desc = "Cycle AI Completions +",
    expr = true,
  },
  {
    "<A-[>",
    function()
      return vim.fn["codeium#CycleCompletions"](-1)
    end,
    mode = "i",
    desc = "Cycle AI Completions -",
    expr = true,
  },
  {
    "<A-x>",
    function()
      return vim.fn["codeium#Clear"]()
    end,
    mode = "i",
    desc = "Clear AI Completions",
    expr = true,
  },
}

M.config = function()
  vim.fn["CodeiumEnable"]()
end

return M
