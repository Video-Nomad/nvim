local M = { "lewis6991/gitsigns.nvim" }

-- M.event = "VeryLazy"
M.lazy = false

M.version = "*"

M.config = function()
  require("gitsigns").setup({
    signs_staged_enable = true,
    signcolumn = true,
    numhl = false,
    linehl = false,
    word_diff = false,
    watch_gitdir = {
      follow_files = true
    },
    auto_attach = true,
    attach_to_untracked = false,
    current_line_blame = false,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'eol',
      delay = 1000,
      ignore_whitespace = true,
      virt_text_priority = 100,
      use_focus = true,
    },
    current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil,
    max_file_length = 40000,
    preview_config = {
      -- Options passed to nvim_open_win
      border = 'single',
      style = 'minimal',
      relative = 'cursor',
      row = 0,
      col = 1
    },
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map("n", "]c", function()
        if vim.wo.diff then
          return "]c"
        end
        vim.schedule(function()
          gs.next_hunk()
        end)
        return "<Ignore>"
      end, { expr = true })

      map("n", "[c", function()
        if vim.wo.diff then
          return "[c"
        end
        vim.schedule(function()
          gs.prev_hunk()
        end)
        return "<Ignore>"
      end, { expr = true })

      -- Actions
      map("n", "<leader>=", gs.preview_hunk)
      map("n", "<leader>+", gs.diffthis)
      -- map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
      -- map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
      -- map('n', '<leader>hS', gs.stage_buffer)
      -- map('n', '<leader>hu', gs.undo_stage_hunk)
      -- map('n', '<leader>hR', gs.reset_buffer)
      -- map('n', '<leader>hb', function() gs.blame_line{full=true} end)
      -- map('n', '<leader>tb', gs.toggle_current_line_blame)
      -- map('n', '<leader>hD', function() gs.diffthis('~') end)
      -- map('n', '<leader>td', gs.toggle_deleted)

      -- Text object
      map({ "o", "x" }, "ih", gs.select_hunk)
    end,
  })
end

return M
