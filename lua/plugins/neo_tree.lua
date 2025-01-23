local M = { "nvim-neo-tree/neo-tree.nvim" }
M.branch = "v3.x"

M.dependencies = {
  "nvim-lua/plenary.nvim",
  "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
  "MunifTanjim/nui.nvim",
}

M.cmd = "Neotree"

M.keys = {
  { "<A-e>", "<cmd>Neotree toggle<CR>" },
}

M.config = function()
  local utils = require("utils")
  require("neo-tree").setup({
    source_selector = {
      winbar = true,
      statusline = true,
    },
    filesystem = {
      commands = {
        -- Override the delete command to move to trash
        delete = function(state)
          local inputs = require("neo-tree.ui.inputs")
          local path = state.tree:get_node().path
          local msg = "Are you sure you want to delete " .. path
          inputs.confirm(msg, function(confirmed)
            if not confirmed then
              return
            end
            utils:move_to_recycle_bin(path)
            require("neo-tree.sources.manager").refresh(state.name)
          end)
        end,

        -- Override default 'delete_visual' command to move to trash
        delete_visual = function(state, selected_nodes)
          local inputs = require("neo-tree.ui.inputs")

          -- get table items count
          function GetTableLen(tbl)
            local len = 0
            for _ in pairs(tbl) do
              len = len + 1
            end
            return len
          end

          local count = GetTableLen(selected_nodes)
          local msg = "Are you sure you want to trash " .. count .. " files ?"
          inputs.confirm(msg, function(confirmed)
            if not confirmed then
              return
            end
            for _, node in ipairs(selected_nodes) do
              utils:move_to_recycle_bin(node.path)
            end
            require("neo-tree.sources.manager").refresh(state.name)
          end)
        end,
      },
    },
    default_component_configs = {
      git_status = {
        symbols = {
          deleted = "",
          renamed = "󰁕",
          untracked = "★",
          ignored = "◌",
          unstaged = "󰄱",
          staged = "",
          conflict = "",
        },
      },
    },
    window = {
      mappings = {
        ["<A-,>"] = "prev_source",
        ["<A-.>"] = "next_source",
      },
    },
  })
end

return M
