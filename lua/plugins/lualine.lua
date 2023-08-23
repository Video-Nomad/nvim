local M = { 'nvim-lualine/lualine.nvim' }

M.event = "VeryLazy"

M.dependencies = {
  'nvim-tree/nvim-web-devicons',
  'arkav/lualine-lsp-progress'
}

local function lsp_progress()
  return {
    'lsp_progress',
    separators = {
      component = '',
      progress = '',
      lsp_client_name = { pre = ' [', post = ']' },
      spinner = { pre = ' ', post = '' },
    },
    display_components = { 'lsp_client_name', 'spinner' },
    timer = { progress_enddelay = 50, spinner = 1000, lsp_client_name_enddelay = 50 },
    spinner_symbols = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏", },
  }
end

M.opts = {
  options = {
    icons_enabled = true,
    theme = 'onedark',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { {'branch', icon = '󰘬'}, 'diff', 'diagnostics' },
    lualine_c = {
      { 'filename', component_separators = { left = "", right = "" } },
      { "%=",       component_separators = { left = "", right = "" } },
      lsp_progress(),
    },
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

M.config = true

return M
