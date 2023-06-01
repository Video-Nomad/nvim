local M = { 'windwp/nvim-autopairs' }

M.dependencies = {
  'hrsh7th/nvim-cmp'
}

M.event = "VeryLazy"

M.config = function()
  require("nvim-autopairs").setup({
    fast_wrap = {},
    disable_filetype = { "TelescopePrompt", "vim" }
  })
  local cmp = require('cmp')
  local cmp_autopairs = require('nvim-autopairs.completion.cmp')

  cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
end

return M
