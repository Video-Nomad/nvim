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
        '/*.webp',
        '/*.jpg',
        '/*.jpeg',
      }
    },
    -- Extensions config
    extensions = {
      project = {
        theme = 'dropdown',
        sync_with_nvim_tree = true,
      },
      undo = {
        initial_mode = 'normal',
        use_delta = false,
        layout_strategy = 'vertical',
      },
    },
  })

  -- Load extensions
  require('telescope').load_extension('undo')
  require('telescope').load_extension('project')
  --require('telescope').load_extension('noice')
  require('telescope').load_extension('todo-comments')

  -- Configure Telescope Keymaps
  local map = vim.keymap.set
  local builtin = require('telescope.builtin')
  local themes = require('telescope.themes')
  local extensions = require('telescope').extensions

  -- Setup custom options for some pickers
  local git_files_picker = function() builtin.git_files({ layout_strategy = 'flex' }) end
  local search_files_picker = function() builtin.find_files({ layout_strategy = 'flex', follow = true }) end
  local fuzzy_find = function() builtin.current_buffer_fuzzy_find(themes.get_ivy { winblend = 0, previewer = false }) end
  local spelling_picker = function() builtin.spell_suggest(themes.get_cursor { winblend = 0, previewer = false }) end
  --local noice = function() extensions.noice.noice({ layout_strategy = 'vertical' }) end

  -- Todo keywords
  local todo_notes = function() extensions['todo-comments'].todo({ keywords = "NOTE", layout_strategy = 'vertical' }) end
  local function todo()
    extensions['todo-comments'].todo({
      keywords = "FIX,TODO,HACK,WARN,PERF,TEST,FIXME,BUG,FIXIT,ISSUE,WIP,FINISH,UNFINISHED",
      layout_strategy = 'vertical',
    })
  end

  -- LSP document symbols
  local function lsp_doc_symbols()
    builtin.lsp_document_symbols({
      layout_strategy = 'flex',
      symbol_width = 0.7,
      symbol_type_width = 0.3,
      show_line = true,
    })
  end

  -- LSP workspace symbols
  local function local_symbols()
    builtin.lsp_dynamic_workspace_symbols({
      fname_width = 0.5,
      symbol_width = 0.3,
      symbol_type_width = 0.2,
      layout_strategy = 'flex',
      path_display = { 'tail' },
      show_line = true,
    })
  end

  map('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
  map('n', '<leader><space>', builtin.buffers, { desc = '[ ] Find existing buffers' })
  map('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
  map('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
  map('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
  map('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
  map('n', 'gr', builtin.lsp_references, { desc = '[G]oto [R]eferences' })
  map('n', '<leader>u', extensions.undo.undo, { desc = 'Telescope Undo' })
  map('n', '<leader>pm', extensions.project.project, { desc = '[P]roject [M]anager' })
  map('n', '<leader>sG', git_files_picker, { desc = '[S]earch [Git] files' })
  map('n', '<leader>sf', search_files_picker, { desc = '[S]earch [F]iles' })
  map('n', '<leader>/', fuzzy_find, { desc = '[/] Fuzzily search in current buffer]' })
  map('n', '<leader>ds', lsp_doc_symbols, { desc = '[D]ocument [S]ymbols' })
  map('n', '<leader>ws', local_symbols, { desc = '[W]orkspace [S]ymbols' })
  map('n', '<leader>ss', spelling_picker, { desc = '[S]pelling [S]uggestion' })
  --map('n', '<leader>sm', noice, { desc = '[S]how [M]essages' })
  map('n', '<leader>wt', todo, { desc = '[W]orkspace [T]odo' })
  map('n', '<leader>wn', todo_notes, { desc = '[W]orkspace [N]otes' })
end

return M
