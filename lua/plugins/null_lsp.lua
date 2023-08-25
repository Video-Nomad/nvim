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
      null_ls.builtins.diagnostics.djlint.with({
        extra_args = {
          '--ignore "T003"',
          '--indent 2',
        },
      }),
      null_ls.builtins.diagnostics.pylint,
      -- Formatting
      null_ls.builtins.formatting.isort,
      null_ls.builtins.formatting.autopep8.with({
        extra_args = {
          "--max-line-length=140",
          "--aggressive",
          "--aggressive",
          "--aggressive",
          "--aggressive",
          "--ignore",
          "E402"
        }
      }),
    }
  })
end

return M
