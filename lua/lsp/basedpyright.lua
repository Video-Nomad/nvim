---@type vim.lsp.Config
return {
  settings = {
    basedpyright = {
      analysis = {
        root_dir = ".",
        diagnosticMode = "openFilesOnly",
      }
    },
  }
}
