local M = { "lukas-reineke/indent-blankline.nvim" }

M.main = "ibl"

M.keys = {
  { "<leader>in", "<cmd>IBLToggle<CR>", desc = "Toggle indent blankline" },
}

M.config = function()
  ---@module "ibl"
  ---@type ibl.config
  require("ibl").setup({
    enabled = false,
    indent = {
      char = "│",
    },
    scope = {
      enabled = true,
      show_end = false,
      show_start = false,
    }
  })
end

return M
