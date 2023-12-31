-- BASIC KEYMAPS
local map = vim.keymap.set

-- Keymaps for better default experience
map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Format file or region
map({ 'v', 'n' }, '<leader>ff', function()
  vim.lsp.buf.format { async = true }
end, { desc = "[F]ormat [F]ile or selection" })

-- Diagnostic keymaps
map('n', '[d', vim.diagnostic.goto_prev)
map('n', ']d', vim.diagnostic.goto_next)
map('n', '<leader>q', vim.diagnostic.setloclist)
map('n', '<leader>e', vim.diagnostic.open_float)

-- Allows to move highlited code
map('v', 'J', ":m '>+1<CR>gv=gv", { silent = true })
map('v', 'K', ":m '<-2<CR>gv=gv", { silent = true })

-- Keep visual selection when indenting and dedenting
map('v', '<', '<gv^', { silent = true })
map('v', '>', '>gv^', { silent = true })

-- Allows to quickly move cursor if in insert mode
map('i', '<A-h>', '<Esc>', { silent = true })
map('i', '<A-j>', '<Esc>jl', { silent = true })
map('i', '<A-k>', '<Esc>kl', { silent = true })
map('i', '<A-l>', '<Esc>ll', { silent = true })

-- Split controls
map('n', '<leader>`', '<C-w>=', { silent = true })

-- Shift+Tab to unindent in insert mode'
map('i', '<S-Tab>', '<C-d>', { silent = true })

-- QuickFix navigation
map('n', '<A-n>', '<cmd>cn<CR>', { silent = true })
map('n', '<A-p>', '<cmd>cp<CR>', { silent = true })

-- Keep the cursor in place when appending bottom line
map('n', 'J', 'mzJ`z', { silent = true })

-- Toggle wrapping
map('n', '<A-z>', ':set wrap!<CR>', { silent = true })

-- Keep cursor in the middle when jumping half a screen
map('n', '<C-d>', '<C-d>zz', { silent = true })
map('n', '<C-u>', '<C-u>zz', { silent = true })

-- Keep search terms in the middle
map('n', 'n', 'nzzzv', { silent = true })
map('n', 'N', 'Nzzzv', { silent = true })

-- Special paste that keeps the original value in the register
map('x', 'p', [["_dP]])

-- Delete into void register. If we want to copy - just use "c" instead
map({ 'n', 'v' }, 'd', [["_d]], { silent = true })

-- Repalce macro key for visual block
map({ 'n', 'v' }, 'q', '<c-v>', { silent = true })

-- There's a reason this is mapped to "nop(e)"
map('n', 'Q', '<nop>', { silent = true })
