local M = { "NvChad/nvim-colorizer.lua" }

M.keys = { { "<leader>hc", "<cmd>ColorizerToggle<CR>" } }

M.cmds = { "ColorizerToggle" }

M.config = function()
  vim.o.termguicolors = true
  require("colorizer").setup({
    filetypes = { "*" },
    user_default_options = {
      RGB = true,
      RRGGBB = true,
      names = true,
      RRGGBBAA = true,
      AARRGGBB = true,
      rgb_fn = true,
      hsl_fn = true,
      css = true,
      css_fn = true,
      mode = "virtualtext",
      tailwind = true,
      sass = { enable = false, parsers = { "css" } },
      virtualtext = "",
      virtualtext_inline = "before",
      always_update = false,
    },
    buftypes = {},
  })
end

return M
