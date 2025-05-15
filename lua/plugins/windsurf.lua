local M = { "Video-Nomad/windsurf.nvim" }

M.event = "VeryLazy"

M.dependencies = {
  "nvim-lua/plenary.nvim",
}

M.config = function()
  require("codeium").setup({
    enable_cmp_source = false,
    virtual_text = {
      enabled = true,
      manual = false,
      filetypes = {},
      default_filetype_enabled = true,
      idle_delay = 75,
      virtual_text_priority = 65535,
      map_keys = true,
      accept_fallback = nil,
      key_bindings = {
        accept = "<A-a>",
        accept_word = false,
        accept_line = false,
        clear = "<A-x>",
        next = "<A-]>",
        prev = "<A-[>",
      }
    }
  })
end

return M
