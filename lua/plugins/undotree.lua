local M = { "mbbill/undotree" }

M.keys = {
  "<leader>u",
}

M.config = function()
  vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, {
    desc = "[u]ndotree",
    silent = true,
    noremap = true,
  })
end

return M
