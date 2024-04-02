local M = { 'Exafunction/codeium.vim' }

M.cmd = {
  "Codeium",
}

M.keys = {
  {
    '<A-c>',
    function()
      return vim.fn['codeium#Complete']()
    end,
    mode = 'i',
    desc = 'Generate AI Completion',
    expr = true
  }
}


M.config = function()
  vim.g.codeium_disable_bindings = 1
  vim.g.codeium_manual = false
  vim.g.codeium_idle_delay = 100

  vim.keymap.set('i', '<A-a>', function()
      return vim.fn['codeium#Accept']()
    end,
    { expr = true, desc = 'Accept AI Completion' })

  vim.keymap.set('i', '<A-]>', function()
      return vim.fn['codeium#CycleCompletions'](1)
    end,
    { expr = true, desc = 'Cycle AI Completions +' })

  vim.keymap.set('i', '<A-[>', function(
    )
      return vim.fn['codeium#CycleCompletions'](-1)
    end,
    { expr = true, desc = 'Cycle AI Completions -' })

  vim.keymap.set('i', '<A-x>', function()
    return vim.fn['codeium#Clear']()
  end, { expr = true, desc = 'Clear AI Completions' })
end

return M
