local M = { "nvim-treesitter/nvim-treesitter", branch = "main" }

M.dependencies = {
  { "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
}

M.lazy = false

M.build = ":TSUpdate"

M.config = function()
  local ts = require("nvim-treesitter")

  ts.setup({})
  local pending_installs = {}

  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("TreesitterAutoInstall", { clear = true }),
    callback = function(event)
      local lang = vim.treesitter.language.get_lang(event.match)
      if not lang or not vim.list_contains(ts.get_available(), lang) then
        return
      end

      -- Share an in-flight install when several buffers use the same parser.
      local task = pending_installs[lang]
      if not task then
        task = ts.install({ lang })
        pending_installs[lang] = task
        task:await(function()
          pending_installs[lang] = nil
        end)
      end

      task:await(vim.schedule_wrap(function(err, installed)
        if err or not installed then
          return
        end
        if not vim.api.nvim_buf_is_loaded(event.buf) or vim.bo[event.buf].filetype ~= event.match then
          return
        end

        pcall(vim.treesitter.start, event.buf)
        if event.match ~= "qml" then
          vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end))
    end,
  })

  -- 1. Core Configuration
  require("nvim-treesitter-textobjects").setup({
    select = {
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      selection_modes = {
        ["@function.outer"] = "V",
        ["@function.inner"] = "V",
        ["@class.outer"] = "V",
        ["@class.inner"] = "V",
      },
    },
    move = {
      set_jumps = true, -- whether to set jumps in the jumplist
    },
  })

  -- 2. Select Keymaps
  -- The select module uses modes "x" (visual) and "o" (operator-pending)
  local select = require("nvim-treesitter-textobjects.select")

  vim.keymap.set({ "x", "o" }, "at", function()
    select.select_textobject("@tag.outer", "textobjects")
  end)
  vim.keymap.set({ "x", "o" }, "it", function()
    select.select_textobject("@tag.inner", "textobjects")
  end)
  vim.keymap.set({ "x", "o" }, "aa", function()
    select.select_textobject("@parameter.outer", "textobjects")
  end)
  vim.keymap.set({ "x", "o" }, "ia", function()
    select.select_textobject("@parameter.inner", "textobjects")
  end)
  vim.keymap.set({ "x", "o" }, "af", function()
    select.select_textobject("@function.outer", "textobjects")
  end)
  vim.keymap.set({ "x", "o" }, "if", function()
    select.select_textobject("@function.inner", "textobjects")
  end)
  vim.keymap.set({ "x", "o" }, "ac", function()
    select.select_textobject("@class.outer", "textobjects")
  end)
  vim.keymap.set({ "x", "o" }, "ic", function()
    select.select_textobject("@class.inner", "textobjects")
  end)

  -- 3. Move Keymaps
  -- The move module uses modes "n" (normal), "x" (visual), and "o" (operator-pending)
  local move = require("nvim-treesitter-textobjects.move")

  -- goto_next_start
  vim.keymap.set({ "n", "x", "o" }, "]m", function()
    move.goto_next_start("@function.outer", "textobjects")
  end)
  vim.keymap.set({ "n", "x", "o" }, "]]", function()
    move.goto_next_start("@class.outer", "textobjects")
  end)

  -- goto_next_end
  vim.keymap.set({ "n", "x", "o" }, "]M", function()
    move.goto_next_end("@function.outer", "textobjects")
  end)
  vim.keymap.set({ "n", "x", "o" }, "][", function()
    move.goto_next_end("@class.outer", "textobjects")
  end)

  -- goto_previous_start
  vim.keymap.set({ "n", "x", "o" }, "[m", function()
    move.goto_previous_start("@function.outer", "textobjects")
  end)
  vim.keymap.set({ "n", "x", "o" }, "[[", function()
    move.goto_previous_start("@class.outer", "textobjects")
  end)

  -- goto_previous_end
  vim.keymap.set({ "n", "x", "o" }, "[M", function()
    move.goto_previous_end("@function.outer", "textobjects")
  end)
  vim.keymap.set({ "n", "x", "o" }, "[]", function()
    move.goto_previous_end("@class.outer", "textobjects")
  end)

  -- 4. Swap Keymaps
  local swap = require("nvim-treesitter-textobjects.swap")

  -- Swap with the next parameter
  vim.keymap.set("n", "<leader>a", function()
    swap.swap_next("@parameter.inner")
  end)

  -- Swap with the previous parameter
  vim.keymap.set("n", "<leader>A", function()
    swap.swap_previous("@parameter.inner")
  end)
end

return M
