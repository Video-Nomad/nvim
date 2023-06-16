-- Main entry point for NeoVim

-- Disable default file browser
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Installing Lazy package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Setting a leader key early for Lazy
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Lazy package manager options
local lazy_opts = {
  defaults = {
    lazy = false,
  },
  ui = {
    border = "rounded"
  },
  change_detection = {
    enabled = true,
    notify = false,
  },
}
-- Load all the plugins from Lazy
require('lazy').setup('plugins', lazy_opts)

-- Color theme
-- require('onedark').load()
vim.cmd([[colorscheme onedark]])

-- Load everything else
require('set')
require('remap')
require('commands')
require('highlight')
