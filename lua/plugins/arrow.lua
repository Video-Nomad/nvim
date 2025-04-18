local M = { "otavioschwanck/arrow.nvim" }

M.keys = {
  { ";" }, { "m" }
}

M.dependencies = {
  { "nvim-tree/nvim-web-devicons" },
}

M.opts = {
  show_icons = true,
  leader_key = ';',        -- Recommended to be a single key
  buffer_leader_key = 'm', -- Per Buffer Mappings
}

return M
