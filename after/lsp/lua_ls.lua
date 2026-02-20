---@type vim.lsp.Config
return {
  settings = {
    Lua = {
      workspace = { checkThirdParty = true },
      telemetry = { enable = false },
      diagnostics = {
        disable = { "missing-fields" },
      },
    },
  },
}
