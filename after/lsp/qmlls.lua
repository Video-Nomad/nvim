---@type vim.lsp.Config
local config = {
  cmd = { "qmlls" },
  filetypes = { "qml" },
  root_markers = { '.qmlls.ini', '.git' },
}

return config
