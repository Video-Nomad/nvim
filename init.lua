-- Main entry point for Neovim

-- Lazy should already enable this but just in case
vim.loader.enable(true)

-- Installing Lazy package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_lstat(lazypath) then
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
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Lazy package manager options
local lazy_opts = {
  defaults = {
    lazy = true,
  },
  ui = {
    border = "rounded",
  },
  change_detection = {
    enabled = true,
    notify = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "zipPlugin",
        "tohtml",
        "tutor",
        "netrwPlugin",
        "rplugin",
        -- "matchit",
        -- "matchparen",
      },
    },
  },
}
require("lazy").setup("plugins", lazy_opts)

-- Load everything else
require("neovide")
require("autoread")
require("shada_cleaner")
require("symlink_resolver")
require("settings")
require("remap")
require("commands")
require("theme_switcher")
require("lang")
require("lsp")
