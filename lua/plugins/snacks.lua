local M = { "folke/snacks.nvim" }

M.lazy = false

---@type snacks.Config
M.opts = {
  statuscolumn = {
    enabled = false,
  },
  rename = {
    enabled = true
  },
  picker = {
    win = {
      input = {
        keys = {
          ["<c-n>"] = false,
          ["<c-p>"] = { "toggle_preview", mode = { "i", "n" } },
          ["<a-n>"] = { "list_down", mode = { "i", "n" } },
          ["<a-p>"] = { "list_up", mode = { "i", "n" } },
        }
      }

    }
  },
}

local files_config = {
  exclude = { "*.png", "*.svg", "*.uid", "*.import" },
}

---@type snacks.picker.lsp.symbols.Config
local workspace_symbols_config = {
  workspace = true,
  tree = false,
  supports_live = true,
  live = true,
  limit = 250,
}

M.keys = {
  -- find
  { "<leader><space>", function() Snacks.picker.buffers() end,                                       desc = "Buffers" },
  { "<leader>sf",      function() Snacks.picker.files(files_config) end,                             desc = "Find Files" },
  { "<leader>sG",      function() Snacks.picker.git_files() end,                                     desc = "Find Git Files" },
  { "<leader>pm",      function() Snacks.picker.projects() end,                                      desc = "Projects" },
  { "<leader>?",       function() Snacks.picker.recent() end,                                        desc = "Recent" },
  { "<leader>sh",      function() Snacks.picker.help() end,                                          desc = "Help Pages" },
  { "<leader>sg",      function() Snacks.picker.grep() end,                                          desc = "Grep" },
  { "<leader>/",       function() Snacks.picker.lines() end,                                         desc = "Buffer Lines" },
  { "<leader>gs",      function() Snacks.picker.git_status() end,                                    desc = "Git Status" },
  { "<leader>sd",      function() Snacks.picker.diagnostics() end,                                   desc = "Diagnostics" },
  { "<leader>sD",      function() Snacks.picker.diagnostics_buffer() end,                            desc = "Buffer Diagnostics" },
  -- LSP
  { "gr",              function() Snacks.picker.lsp_references() end,                                nowait = true,                  desc = "References" },
  { "gd",              function() Snacks.picker.lsp_definitions() end,                               desc = "Goto Definition" },
  { "gD",              function() Snacks.picker.lsp_declarations() end,                              desc = "Goto Declaration" },
  { "gr",              function() Snacks.picker.lsp_references() end,                                nowait = true,                  desc = "References" },
  { "gI",              function() Snacks.picker.lsp_implementations() end,                           desc = "Goto Implementation" },
  { "gy",              function() Snacks.picker.lsp_type_definitions() end,                          desc = "Goto T[y]pe Definition" },
  { "<leader>ds",      function() Snacks.picker.lsp_symbols() end,                                   desc = "LSP Symbols" },
  { "<leader>ws",      function() Snacks.picker.lsp_workspace_symbols(workspace_symbols_config) end, desc = "LSP Workspace Symbols" },
  -- Spelling
  { "<leader>S",       function() Snacks.picker.spelling() end,                                      desc = "Spelling" },
  -- Misc
  { "<leader>sH",      function() Snacks.picker.highlights() end,                                    desc = "Highlights" },
  { "<leader>bb",      function() Snacks.picker.marks() end,                                         desc = "Bookmarks" },

}


return M
