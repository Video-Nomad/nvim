local M = { 'akinsho/bufferline.nvim' }

M.version = "*"

M.dependencies = {
  'nvim-tree/nvim-web-devicons',
}

M.event = "VeryLazy"

local icon_map = {
  ["error"] = " ",
  ["warning"] = " ",
  ["info"] = " ",
  ["hint"] = " "
}

M.config = function()
  vim.opt.termguicolors = true
  local bufferline = require('bufferline')
  bufferline.setup({
    options = {
      style_preset = bufferline.style_preset.no_italic,
      indicator = {
        icon = ' ⩺ ', --  ⇨▪■⩔⩺⩔⪧∇⫸∇◯⟫⪧⩒
        style = 'icon'
      },
      right_mouse_command = "bd %d",
      left_mouse_command = "buffer %d",
      middle_mouse_command = "bd %d",
      max_name_length = 20,
      tab_size = 22,
      diagnostics = "nvim_lsp",
      always_show_bufferline = false,
      diagnostics_indicator = function(count, level)
        local icon = icon_map[level] or ""
        return " " .. icon .. count
      end,
      offsets = {
        {
          filetype = "NvimTree",
          text = "Nvim Tree",
          text_align = "left",
          separator = true
        }
      },
    },
    highlights = {
      buffer_selected = {
        fg = "#d19a66",
      },
      indicator_selected = {
        fg = "#d19a66",
      },
    }
  })

  local map = vim.api.nvim_set_keymap
  local opts = { noremap = true, silent = true }

  -- Move to previous/next
  map('n', '<A-,>', '<Cmd>BufferLineCyclePrev<CR>', opts)
  map('n', '<A-.>', '<Cmd>BufferLineCycleNext<CR>', opts)

  -- Re-order to previous/next
  map('n', '<A-<>', '<Cmd>BufferLineMovePrev<CR>', opts)
  map('n', '<A->>', '<Cmd>BufferLineMoveNext<CR>', opts)

  -- Close buffers
  map('n', '<leader>bc', '<Cmd>BufferLineCloseOthers<CR>', opts)
  map('n', '<A-c>', '<Cmd>bd<CR>', opts)
end

return M
