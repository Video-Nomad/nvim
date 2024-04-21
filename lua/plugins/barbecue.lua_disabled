local M = { "utilyre/barbecue.nvim" }

M.name = "barbecue"

M.version = "*"

M.event = "VeryLazy"

M.dependencies = {
  "SmiteshP/nvim-navic",
  "nvim-tree/nvim-web-devicons", -- optional dependency
}

M.setup = function()
  require("barbecue").setup({
    create_autocmd = false, -- prevent barbecue from updating itself automatically
  })

  vim.api.nvim_create_autocmd({
      "WinResized", -- or WinResized on NVIM-v0.9 and higher
      "BufWinEnter",
      "CursorHold",
      "InsertLeave",

      -- include these if you have set `show_modified` to `true`
      -- "BufWritePost",
      -- "TextChanged",
      -- "TextChangedI",
    },
    {
      group = vim.api.nvim_create_augroup("barbecue.updater", {}),
      callback = function()
        require("barbecue.ui").update()
      end,
    })
end

M.opts = {
  -- configurations go here
}

return M
