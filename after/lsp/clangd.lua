-- Keymaps
vim.keymap.set("n", "<leader>gh", ":LspClangdSwitchSourceHeader<CR>", { desc = "[G]o to [H]eader" })

---@type vim.lsp.Config
return {}
