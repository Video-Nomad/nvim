local M = { "folke/noice.nvim" }

M.event = "VeryLazy"

M.dependencies = {

  "MunifTanjim/nui.nvim",
}

M.opts = {
  lsp = {
    progress = {
      enabled = false
    },
    hover = {
      enabled = false
    },
    signature = {
      enabled = false
    },
  },
  presets = {
    bottom_search = true,
  },
  cmdline = {
    view = 'cmdline'
  },
  messages = {
    view_search = false,
  },
  views = {
    mini = {
      timeout = 1000,
      win_options = {
        winblend = 0
      }
    }
  }
}

return M
