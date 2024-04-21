-- Neovide specific stuff
if vim.g.neovide then
  vim.o.guifont = "JetBrainsMono Nerd Font Mono:h12"
  vim.g.neovide_refresh_rate = 240
  vim.g.neovide_cursor_animate_command_line = false
  vim.g.neovide_hide_mouse_when_typing = false

  -- Some additional keymaps for neovide
  local font_size = 12
  local font = "JetBrainsMono Nerd Font Mono"
  local map = vim.keymap.set
  map({ 'i', 'x', 'n', 'c' }, '<C-S-V>', '<C-R>*')

  -- Zoom
  map({ 'i', 'n' }, '<A-=>', function()
    font_size = font_size + 1
    vim.o.guifont = font .. ":h" .. font_size
  end)
  map({ 'i', 'n' }, '<A-->', function()
    font_size = font_size - 1
    vim.o.guifont = font .. ":h" .. font_size
  end)
  map({ 'i', 'n' }, '<A-0>', function()
    font_size = 12
    vim.o.guifont = font .. ":h" .. font_size
  end)

  -- Override background for neovide
  require("onedark").setup({
    transparent = false,
    colors = {
      bg0 = "#1E1E1E",
      bg_d = "#1E1E1E",
    }
  })
  vim.cmd([[colorscheme onedark]])
end
