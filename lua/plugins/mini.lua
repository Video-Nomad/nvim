local M = { 'echasnovski/mini.nvim' }

M.version = false

M.config = function()
  require("mini.move").setup({
    -- Module mappings. Use `''` (empty string) to disable one.
    mappings = {
      -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
      left = 'H',
      right = 'L',
      down = 'J',
      up = 'K',

      -- Move current line in Normal mode
      line_left = '<A-h>',
      line_right = '<A-l>',
      line_down = '<A-j>',
      line_up = '<A-k>',
    },

    -- Options which control moving behavior
    options = {
      -- Automatically reindent selection during linewise vertical move
      reindent_linewise = true,
    },
  })
end

return M
