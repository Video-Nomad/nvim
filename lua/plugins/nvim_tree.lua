local M = { "nvim-tree/nvim-tree.lua" }

M.lazy = false

M.cmd = "NvimTreeToggle"

M.keys = {
  { "<A-e>", "<cmd>NvimTreeToggle<CR>" },
}

M.config = function()
  local api = require("nvim-tree.api")
  local Event = api.events.Event

  -- Snacks LSP rename callback
  api.events.subscribe(Event.NodeRenamed, function(data)
    Snacks.rename.on_rename_file(data.old_name, data.new_name)
  end)

  local function my_on_attach(bufnr)
    local function opts(desc)
      return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- default mappings
    api.map.on_attach.default(bufnr)

    -- custom mappings
    local utils = require("utils")

    -- Override default delete command to move to trash
    local function trash_node()
      local node = api.tree.get_node_under_cursor()
      if not node then
        return
      end

      local marks = api.marks.list()
      if #marks > 0 then
        local msg = "Are you sure you want to trash " .. #marks .. " files?"
        local choice = vim.fn.confirm(msg, "&Yes\n&No")
        if choice == 1 then
          for _, m in ipairs(marks) do
            utils:move_to_recycle_bin(m.absolute_path)
          end
          api.marks.clear()
          api.tree.reload()
        end
      else
        local msg = "Are you sure you want to trash " .. node.absolute_path .. "?"
        local choice = vim.fn.confirm(msg, "&Yes\n&No")
        if choice == 1 then
          utils:move_to_recycle_bin(node.absolute_path)
          api.tree.reload()
        end
      end
    end

    vim.keymap.set("n", "d", trash_node, opts("Trash"))
  end

  require("nvim-tree").setup({
    on_attach = my_on_attach,
    diagnostics = {
      enable = true,
      show_on_dirs = true,
      show_on_open_dirs = true,
      debounce_delay = 50,
      severity = {
        min = vim.diagnostic.severity.HINT,
        max = vim.diagnostic.severity.ERROR,
      },
      icons = {
        hint = "",
        info = "",
        warning = "",
        error = "",
      },
    },
    sort = {
      sorter = "case_sensitive",
    },
    view = {
      width = 34,
    },
    update_focused_file = {
      enable = true,
    },
    renderer = {
      group_empty = true,
      icons = {
        glyphs = {
          git = {
            deleted = "",
            renamed = "󰁕",
            untracked = "?",
            ignored = "◌",
            unstaged = "󰄱",
            staged = "",
            unmerged = "",
          },
        },
      },
    },
    filters = {
      dotfiles = true,
      custom = {
        "%.gd%.uid$",
        "%.tmp$",
        "%.exe$",
        "%.dll$",
        "%.pck$",
        "%.uid$",
        "%.import$",
      },
      exclude = {
        ".gitignore",
        ".env",
      },
    },
  })
end

return M
