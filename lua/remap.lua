local utils = require("utils")
-- BASIC KEYMAPS
local map = vim.keymap.set

-- LSP keymaps
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[R]e[n]ame" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction" })
map("n", "<leader>ih", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "[I]nlay [H]int Toggle" })

-- Signature help and hover
map("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })
map({ "n", "i", "s" }, "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature Documentation", silent = true })

-- Lesser used LSP functionality
map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { desc = "[W]orkspace [A]dd Folder" })
map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { desc = "[W]orkspace [R]emove Folder" })
map("n", "<leader>wl", function()
  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, { desc = "[W]orkspace [L]ist Folders" })

-- WM stuff
map({ "n", "v", "i" }, "<F23>", "<Nop>", { silent = true })

-- Keymaps for better default experience
map({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
map({ "n", "v" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map({ "n", "v" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Format file or region
map({ "v", "n" }, "<leader>ff", function()
  require("conform").format({ lsp_format = "fallback" })
end, { desc = "[F]ormat [F]ile or selection" })

-- Diagnostic keymaps
map("n", "[d", function()
  vim.diagnostic.jump({ count = -1, float = true })
end)
map("n", "]d", function()
  vim.diagnostic.jump({ count = 1, float = true })
end)
map("n", "<leader>q", vim.diagnostic.setloclist)
map("n", "<leader>e", vim.diagnostic.open_float)

-- Resize splits ------------------------------------------
-- Increase width of current split when it's on the right
vim.keymap.set("n", "<A-Left>", function()
  if vim.fn.winnr() == vim.fn.winnr("l") then
    return "5<C-W>>"
  else
    return "5<C-W><"
  end
end, { expr = true, silent = true })

-- Decrease width of current split when it's on the right
vim.keymap.set("n", "<A-Right>", function()
  if vim.fn.winnr() == vim.fn.winnr("l") then
    return "5<C-W><"
  else
    return "5<C-W>>"
  end
end, { expr = true, silent = true })

-- Increase height of current split when it's on the bottom
vim.keymap.set("n", "<A-Up>", function()
  if vim.fn.winnr() == vim.fn.winnr("j") then
    return "<C-W>+"
  else
    return "<C-W>-"
  end
end, { expr = true, silent = true })

-- Decrease height of current split when it's on the bottom
vim.keymap.set("n", "<A-Down>", function()
  if vim.fn.winnr() == vim.fn.winnr("j") then
    return "<C-W>-"
  else
    return "<C-W>+"
  end
end, { expr = true, silent = true })

-- Move between splits
map("n", "<A-l>", "<C-w>l", { noremap = true, silent = true })
map("n", "<A-h>", "<C-w>h", { noremap = true, silent = true })
map("n", "<A-j>", "<C-w>j", { noremap = true, silent = true })
map("n", "<A-k>", "<C-w>k", { noremap = true, silent = true })

-- Move splits
map("n", "<S-A-h>", function()
  utils:swap_windows("h")
end, { noremap = true, silent = true })

map("n", "<S-A-l>", function()
  utils:swap_windows("l")
end, { noremap = true, silent = true })

map("n", "<S-A-j>", function()
  utils:swap_windows("j")
end, { noremap = true, silent = true })

map("n", "<S-A-k>", function()
  utils:swap_windows("k")
end, { noremap = true, silent = true })

-- Allows to quickly move cursor if in insert mode
map("i", "<A-h>", "<Esc>", { silent = true })
map("i", "<A-j>", "<Esc>jl", { silent = true })
map("i", "<A-k>", "<Esc>kl", { silent = true })
map("i", "<A-l>", "<Esc>ll", { silent = true })

-- Split controls
map("n", "<leader>`", "<C-w>=", { silent = true })

-- Shift+Tab to unindent in insert mode'
map("i", "<S-Tab>", "<C-d>", { silent = true })

-- QuickFix navigation
map("n", "<A-n>", "<cmd>cn<CR>", { silent = true })
map("n", "<A-p>", "<cmd>cp<CR>", { silent = true })

-- Keep the cursor in place when appending bottom line
map("n", "J", "mzJ`z", { silent = true })

-- Toggle wrapping
map("n", "<A-w>", ":set wrap!<CR>", { silent = true, noremap = true })

-- Keep cursor in the middle when jumping half a screen
map("n", "<C-d>", "<C-d>zz", { silent = true })
map("n", "<C-u>", "<C-u>zz", { silent = true })

-- Keep the cursor in the middle during jumplist navigation
map("n", "<C-i>", "<C-i>zz", { noremap = true })
map("n", "<C-o>", "<C-o>zz", { noremap = true })

-- Keep search terms in the middle
map("n", "n", "nzzzv", { silent = true })
map("n", "N", "Nzzzv", { silent = true })

-- Special paste that keeps the original value in the register
map("x", "p", [["_dP]])

-- Delete into void register. If we want to copy - just use "c" instead
map({ "n", "v" }, "d", [["_d]], { silent = true })

-- Change the macro key
-- map({ "n" }, "<leader>r", "q", { silent = true, noremap = true })

-- Repalce macro key for visual block
map({ "n", "v" }, "q", "<C-v>", { silent = true, noremap = true })

-- There's a reason this is mapped to "nop(e)"
map("n", "Q", "<nop>", { silent = true })

-- Remove F1 mapping
map({ "n", "i", "v" }, "<F1>", "<nop>", { silent = true })
