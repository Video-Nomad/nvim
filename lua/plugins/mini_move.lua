local M = { "echasnovski/mini.move" }

M.version = false

M.keys = {
  -- Visual mode mappings
  { "K",     mode = "v", desc = "Move up" },
  { "J",     mode = "v", desc = "Move down" },
  { "H",     mode = "v", desc = "Move left" },
  { "L",     mode = "v", desc = "Move right" },
  -- Normal mode mappings
  { "<A-k>", mode = "n", desc = "Move up" },
  { "<A-j>", mode = "n", desc = "Move down" },
  { "<A-h>", mode = "n", desc = "Move left" },
  { "<A-l>", mode = "n", desc = "Move right" },
}

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
