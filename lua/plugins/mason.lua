local M = { "williamboman/mason.nvim" }

M.dependencies = {
  "neovim/nvim-lspconfig",
  "williamboman/mason-lspconfig.nvim",
  "WhoIsSethDaniel/mason-tool-installer.nvim",
}

M.event = "VeryLazy"

M.config = function()
  require("mason").setup()

  local mason_lspconfig = require("mason-lspconfig")
  local mason_tool_installer = require("mason-tool-installer")

  mason_lspconfig.setup({})
  mason_tool_installer.setup({
    ensure_installed = {
      "rust_analyzer",
      "cssls",
      "tailwindcss",
      "html",
      "clangd",
      "basedpyright",
      "lua_ls",
      "jsonls",
      "ruff",
      "docker_compose_language_service",
      "astro",
      "vtsls",
    },
  })

  -- Esbonio post-install hook
  local mason_registry = require("mason-registry")
  local settings = require("mason.settings")
  local Path = require("mason-core.path")
  mason_registry:on("package:install:success", function(pkg)
    if pkg.name == "esbonio" then
      local install_root = settings.current.install_root_dir
      local pkg_dir = Path.concat { install_root, "packages", pkg.name }
      local venv_path
      if vim.fn.has("win32") == 1 then
        venv_path = pkg_dir .. "/venv/Scripts/pip.exe"
      else
        venv_path = pkg_dir .. "/venv/bin/pip"
      end
      vim.schedule(function()
        vim.fn.jobstart({ venv_path, "install", "sphinx" })
        vim.fn.jobstart({ venv_path, "install", "sphinx_rtd_theme" })
        vim.fn.jobstart({ venv_path, "install", "sphinx_copybutton" })
      end)
    end
  end)
end

return M
