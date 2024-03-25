-- MAIN SETTINGS

-- Disable neovim startup screen and some other messages
vim.opt.shortmess:append("c")
vim.opt.shortmess:append("I")

-- Use unix file format by default
vim.opt.fileformat = "unix"
vim.opt.fileformats = "unix,dos"

-- Remove cmd line when not needed
vim.o.cmdheight = 0

-- Change title
vim.o.title = true

-- Use pwsh as default shell
vim.o.shell = 'pwsh'
vim.o.shellxquote = ''
vim.o.shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command '
vim.o.shellquote = ''
vim.o.shellpipe = '| Out-File -Encoding utf8 %s'
vim.o.shellredir = '| Out-File -Encoding utf88 %s'

-- Set colors and cursor
vim.o.termguicolors = true
vim.o.cursorline = true

-- Use Windows clipboard by default
vim.opt.clipboard = "unnamedplus"

-- Set highlight on search
vim.o.hlsearch = false
vim.o.incsearch = true

-- Indents
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true

-- Add lines margin when scrolling up or down
vim.o.scrolloff = 4

-- Make line numbers default
vim.wo.number = true
vim.wo.rnu = true

-- Enable mouse mode and remove annoying lines
vim.o.mouse = 'a'
vim.cmd([[
silent! aunmenu PopUp.How-to\ disable\ mouse
silent! aunmenu PopUp.-1-
]])

-- Enable break indent
vim.o.breakindent = true
vim.o.linebreak = true
vim.o.showbreak = '   ↪'
-- vim.opt.display = 'lastline'
vim.o.wrap = false

-- Save undo history
vim.o.swapfile = false
vim.o.backup = false
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 100
vim.o.timeout = true
vim.o.timeoutlen = 300
vim.o.ttimeoutlen = 0

-- Some other stuff
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.wo.signcolumn = 'yes'
vim.opt.fillchars = { eob = " " }
vim.opt.listchars = { trail = "∙", extends = "→", tab = "  " }
vim.opt.list = true

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menu,menuone,noselect'
vim.o.pumheight = 11

-- Set spell checker to support CamelCase
vim.opt.spelloptions = 'camel,noplainbuffer'

-- Change diagnostic signs (icons)
local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
