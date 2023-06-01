local M = { 'nvim-telescope/telescope.nvim' }

M.branch = '0.1.x'

M.dependencies = {
  'nvim-lua/plenary.nvim',
  'debugloop/telescope-undo.nvim',
  'nvim-telescope/telescope-project.nvim',
}

M.config = function()
  -- Configure Telescope
  require('telescope').setup({
    -- Main Telescope defaults
    defaults = {
      prompt_prefix = '   ',
      selection_caret = '  ',
      entry_prefix = '  ',
      layout_strategy = 'horizontal',
      set_env = { ['COLORTERM'] = 'truecolor' },
      layout_config = {
        vertical = {
          height = 0.96,
          width = 0.9
        },
        horizontal = {
          preview_width = 0.5,
          height = 0.96,
          width = 0.9
        },
      },
      mappings = {
        i = {
          ['<C-u>'] = false,
          ['<C-d>'] = false,
        },
      },
      file_ignore_patterns = {
        '/*.pyc',
        '/*.pyd',
        '/*.otf',
        '/*.ttf',
        '/*.code.workspace',
        '/*.ico',
        '/*.png',
        '/*.mll',
      }
    },
    -- Extensions config
    extensions = {
      project = {
        theme = "dropdown",
        sync_with_nvim_tree = true,
      },
      undo = {
        initial_mode = 'normal',
        use_delta = false,
        layout_strategy = 'horizontal',
        layout_config = {
          preview_width = 0.65,
        }
      },
    },
  })
  -- Load extensions
  require('telescope').load_extension('undo')
  require('telescope').load_extension('project')

  -- Configure Telescope Keymaps
  local set = vim.keymap.set
  local builtin = require('telescope.builtin')
  local themes = require('telescope.themes')
  local extensions = require('telescope').extensions

  local git_files_picker = function() builtin.git_files({ layout_strategy = 'flex' }) end
  local search_files_picker = function() builtin.find_files({ layout_strategy = 'flex', follow = true }) end
  local fuzzy_find = function() builtin.current_buffer_fuzzy_find(themes.get_ivy { winblend = 0, previewer = false }) end
  local spelling_picker = function() builtin.spell_suggest(themes.get_cursor { winblend = 0, previewer = false }) end

  local function lsp_doc_symbols()
    builtin.lsp_document_symbols({
      layout_strategy = 'flex',
      symbol_width = 0.7,
      symbol_type_width = 0.3,
      show_line = true,
    })
  end

  local function local_symbols()
    builtin.lsp_dynamic_workspace_symbols({
      fname_width = 0.5,
      symbol_width = 0.3,
      symbol_type_width = 0.2,
      layout_strategy = 'flex',
      path_display = { 'shorten', 'relative' },
      show_line = true,
    })
  end

  set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
  set('n', '<leader><space>', builtin.buffers, { desc = '[ ] Find existing buffers' })
  set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
  set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
  set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
  set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
  set('n', 'gr', builtin.lsp_references, { desc = '[G]oto [R]eferences' })
  set('n', '<leader>u', extensions.undo.undo, { desc = 'Telescope Undo' })
  set('n', '<leader>pm', extensions.project.project, { desc = '[P]roject [M]anager' })
  set('n', '<leader>sG', git_files_picker, { desc = '[S]earch [Git] files' })
  set('n', '<leader>sf', search_files_picker, { desc = '[S]earch [F]iles' })
  set('n', '<leader>/', fuzzy_find, { desc = '[/] Fuzzily search in current buffer]' })
  set('n', '<leader>ds', lsp_doc_symbols, { desc = '[D]ocument [S]ymbols' })
  set('n', '<leader>ws', local_symbols, { desc = '[W]orkspace [S]ymbols' })
  set('n', '<leader>ss', spelling_picker, { desc = '[S]pelling [S]uggestion' })
end

return M
