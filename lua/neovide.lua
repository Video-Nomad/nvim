if not vim.g.neovide then
  return {}
end

vim.o.guifont = "JetBrainsMono NFP:h12"
vim.opt.linespace = 0

vim.g.neovide_hide_mouse_when_typing = true

vim.g.neovide_refresh_rate = 180
vim.g.neovide_no_idle = true
