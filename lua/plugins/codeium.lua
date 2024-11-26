local M = { "Exafunction/codeium.nvim" }

M.event = "VeryLazy"

M.cmd = "Codeium Chat"

M.dependencies = {
  "nvim-lua/plenary.nvim",
  "hrsh7th/nvim-cmp",
}

M.keys = {
  {
    "<A-c>",
    function()
      require("codeium.virtual_text").cycle_or_complete()
    end,
    mode = "i",
    desc = "Generate AI Completion",
  },
}

M.config = function()
  require("codeium").setup({
    enable_chat = false,
    enable_cmp_source = false,
    idle_delay = 100,
    virtual_text = {
      enabled = true,
      manual = true,
      map_keys = true,
      key_bindings = {
        accept = "<A-a>",
        next = "<A-]>",
        prev = "<A-[>",
        clear = "<A-x>",
      },
    },
  })
end

return M
