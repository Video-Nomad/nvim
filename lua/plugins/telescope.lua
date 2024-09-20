local M = { "nvim-telescope/telescope.nvim" }

M.event = "VeryLazy"

M.dependencies = {
  "nvim-lua/plenary.nvim",
  "nvim-telescope/telescope-project.nvim",
  "nvim-telescope/telescope-fzf-native.nvim",
}

M.config = function()
  -- Configure Telescope
  local gs_utils = require("utils")
  require("telescope").setup({
    -- Main Telescope defaults
    defaults = {
      prompt_prefix = "   ",
      selection_caret = "  ",
      entry_prefix = "  ",
      layout_strategy = "vertical",
      follow = true,
      layout_config = {
        vertical = {
          width = 0.9,
          preview_cutoff = 0,
        },
        horizontal = {
          width = 0.9,
          preview_cutoff = 0,
        },
        flex = {
          flip_columns = 200,
        },
      },
      mappings = {
        i = {
          ["<C-u>"] = false,
          ["<C-d>"] = false,
          ["<C-p>"] = false,
          ["<C-n>"] = false,
          ["<A-n>"] = "move_selection_next",
          ["<A-p>"] = "move_selection_previous",
        },
      },
      file_ignore_patterns = {
        "%.pyc",
        "%.pyd",
        "%.otf",
        "%.ttf",
        "%.code.workspace",
        "%.ico",
        "%.png",
        "%.mll",
        "%.webp",
        "%.jpg",
        "%.jpeg",
        "^node_modules",
        "\\migrations\\.*%.py",
      },
    },
    -- Pickers config
    pickers = {
      live_grep = {
        layout_strategy = "vertical",
        width = 0.8,
      },
      find_files = {
        layout_strategy = "vertical",
        layout_config = {
          width = 0.7,
        },
        previewer = false,
        path_display = { "filename_first" },
      },
      git_files = {},
      lsp_document_symbols = {
        layout_strategy = "flex",
        symbol_width = 0.7,
        symbol_type_width = 0.3,
        show_line = true,
      },
      lsp_dynamic_workspace_symbols = {
        fname_width = 0.5,
        symbol_width = 0.3,
        symbol_type_width = 0.2,
        layout_strategy = "flex",
        path_display = { "filename_first" },
        show_line = true,
      },
      current_buffer_fuzzy_find = {
        theme = "ivy",
        previewer = false,
        winblend = 0,
      },
      spell_suggest = {
        theme = "cursor",
        winblend = 0,
        previewer = false,
      },
    },
    -- Extensions config
    extensions = {
      project = {
        theme = "dropdown",
        sync_with_nvim_tree = true,
      },
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
    },
  })

  -- Load extensions
  require("telescope").load_extension("project")
  require("telescope").load_extension("todo-comments")
  require("telescope").load_extension("fzf")

  -- Configure Telescope Keymaps
  local map = vim.keymap.set
  local builtin = require("telescope.builtin")
  local extensions = require("telescope").extensions

  -- Todo keywords
  local todo_notes = function()
    extensions["todo-comments"].todo({ keywords = "NOTE,INFO", layout_strategy = "vertical" })
  end
  local function todo()
    extensions["todo-comments"].todo({
      keywords =
      "FIX,FIXME,BUG,CRITICAL,FIXIT,ISSUE,WIP,UNFINISHED,FINISH,TODO,HACK,WARN,WARNING,XXX,PERF,OPTIM,PERFORMANCE,OPTIMIZE,TEST,TESTING,PASSED,FAILED",
      layout_strategy = "vertical",
    })
  end

  map("n", "<leader>?", builtin.oldfiles, { desc = "[?] Find recently opened files" })
  map("n", "<leader><space>", builtin.buffers, { desc = "[ ] Find existing buffers" })
  map("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
  map("n", "<leader>sg", function()
    builtin.live_grep({ additional_args = { "--pcre2" } })
  end, { desc = "[S]earch by [G]rep" })
  -- map('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' }) -- Delegated to Trouble (for now)
  map("n", "gr", builtin.lsp_references, { desc = "[G]oto [R]eferences" })
  map("n", "<leader>sG", builtin.git_files, { desc = "[S]earch [Git] files" })
  map("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
  map("n", "<leader>/", builtin.current_buffer_fuzzy_find, { desc = "[/] Fuzzily search in current buffer]" })
  map("n", "<leader>ds", builtin.lsp_document_symbols, { desc = "[D]ocument [S]ymbols" })
  map("n", "<leader>ws", builtin.lsp_dynamic_workspace_symbols, { desc = "[W]orkspace [S]ymbols" })
  map("n", "<leader>S", builtin.spell_suggest, { desc = "[S]pelling [S]uggestion" })
  map("n", "<leader>pm", extensions.project.project, { desc = "[P]roject [M]anager" })
  map("n", "<leader>wt", todo, { desc = "[W]orkspace [T]odo" })
  map("n", "<leader>wn", todo_notes, { desc = "[W]orkspace [N]otes" })
end

return M
