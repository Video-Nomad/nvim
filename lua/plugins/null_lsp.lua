local M = { 'jose-elias-alvarez/null-ls.nvim' }

M.event = "VeryLazy"

M.dependencies = {
  'nvim-lua/plenary.nvim'
}

M.config = function()
  local null_ls = require('null-ls')
  null_ls.setup({
    sources = {
      null_ls.builtins.formatting.prettierd,
      null_ls.builtins.formatting.djlint,
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
      null_ls.builtins.formatting.isort,
    }
  })
end

return M
