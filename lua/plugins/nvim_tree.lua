local M = { "nvim-tree/nvim-tree.lua" }

M.dependencies = {
  "nvim-tree/nvim-web-devicons",
}

M.cmd = "NvimTreeToggle"

M.keys = {
  { "<A-e>",      vim.cmd.NvimTreeToggle,  desc = "Nvim Tree",                mode = "n" },
}

M.opts = {
  sort_by = "name",
  view = {
    width = 50,
    debounce_delay = 300,
  },
  renderer = {
    group_empty = true,
  },
  update_focused_file = {
    enable = true,
    update_root = false,
    ignore_list = {},
  },
  filters = {
    dotfiles = true,
    custom = {
      "__pycache__",
      ".vscode",
      "*.pyc",
      "/.git/",
    },
  },
  filesystem_watchers = {
    enable = true,
    debounce_delay = 300,
    ignore_dirs = { "./target/debug/", "./target/release/", "./.git/", "./git/" },
  },
  git = {
    ignore = false,
  },
}

return M
