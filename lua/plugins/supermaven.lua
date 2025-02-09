local M = { "supermaven-inc/supermaven-nvim" }

M.event = "VeryLazy"

M.config = function()
  require("supermaven-nvim").setup({
    keymaps = {
      accept_suggestion = "<A-a>",
      clear_suggestion = "<A-x>",
      accept_word = "<A-j>",
    },
  })
end

return M
