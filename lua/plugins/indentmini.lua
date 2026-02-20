local M = { "Video-Nomad/indentmini.nvim" } -- Fork for toggle functionality

M.event = "VeryLazy"

M.config = function()
  local indentline = require("indentmini")
  indentline.setup({
    exclude = { "git" },
    config = {
      virt_text_pos = "overlay",
      hl_mode = "combine",
      ephemeral = true,
    },
  })
  indentline.disable()
  vim.keymap.set("n", "<leader>in", indentline.toggle, { desc = "Toggle IndentLine" })
end

return M
