local M = { 'williamboman/mason.nvim' }

M.lazy = true

M.cmd = {
  "Mason",
  "MasonInstall",
  "MasonInstallAll",
  "MasonUninstall",
  "MasonUninstallAll",
  "MasonLog",
}

M.dependencies = {
  'williamboman/mason-lspconfig.nvim'
}

M.opts = {
  ui = {
    border = "rounded"
  }
}

return M
