local M = { 'jose-elias-alvarez/null-ls.nvim' }

M.event = "VeryLazy"

M.dependencies = {
  'nvim-lua/plenary.nvim'
}

M.config = function()
  local null_ls = require('null-ls')
  null_ls.setup({
    sources = {
      -- Linting
      null_ls.builtins.diagnostics.pylint,
      -- Formatting
      null_ls.builtins.formatting.isort,
      null_ls.builtins.formatting.black
    }
  })
end

return M
