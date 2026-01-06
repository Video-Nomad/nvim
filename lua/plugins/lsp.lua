local M = { "neovim/nvim-lspconfig" }

M.event = "VeryLazy"

M.dependencies = {
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "WhoIsSethDaniel/mason-tool-installer.nvim",
}

M.config = function()
  local map = vim.keymap.set
  -- LSP related keymaps
  map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[R]e[n]ame" })
  map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction" })
  map("n", "<leader>ih", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
  end, { desc = "[I]nlay [H]int Toggle" })

  -- Signature help and hover
  map("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })
  map(
    { "n", "i", "s" },
    "<C-k>",
    vim.lsp.buf.signature_help,
    { desc = "Signature Documentation", silent = true }
  )

  -- Lesser used LSP functionality
  map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { desc = "[W]orkspace [A]dd Folder" })
  map(
    "n",
    "<leader>wr",
    vim.lsp.buf.remove_workspace_folder,
    { desc = "[W]orkspace [R]emove Folder" }
  )
  map("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, { desc = "[W]orkspace [L]ist Folders" })

  -- Enable the following language servers
  local servers = {
    rust_analyzer = {},
    cssls = {
      css = {
        lint = {
          unknownAtRules = "ignore",
        },
      },
    },
    tailwindcss = {},
    html = {
      format = {
        wrapLineLength = 140,
        templating = true,
      },
    },
    clangd = {},
    basedpyright = {
      settings = {
        basedpyright = {
          analysis = {
            root_dir = ".",
            diagnosticMode = "openFilesOnly", -- ["openFilesOnly", "workspace"]
          }
        },
      }
    },
    -- gopls = {
    --   analyses = {
    --     unusedparams = true,
    --   },
    --   staticcheck = true,
    --   gofumpt = true,
    -- },
    lua_ls = {
      Lua = {
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
        diagnostics = {
          disable = { "missing-fields" },
        },
      },
    },
    jsonls = {},
    ruff = {},
    docker_compose_language_service = {},
    astro = {
      typescript = {},
    },
    vue_ls = {},
    vtsls = {},
  }

  -- Setup mason so it can manage external tooling
  require("mason").setup()

  -- Ensure the servers above are installed
  local mason_lspconfig = require("mason-lspconfig")
  local mason_tool_installer = require("mason-tool-installer")

  mason_lspconfig.setup({})
  mason_tool_installer.setup({
    ensure_installed = vim.tbl_keys(servers),
    automatic_enable = {
      exclude = {
        "vue_ls", -- Already managed by vtsls
      }
    }
  })

  for server, config in pairs(servers) do
    vim.lsp.config(server, config)
  end

  -- Esbonio post-install hook (for sphinx dependency)
  local mason_registry = require("mason-registry")
  local settings = require("mason.settings")
  local Path = require("mason-core.path") -- safe path join helper used by mason
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

  -- Vue language server configuration
  local vue_language_server_path = vim.fn.stdpath('data') ..
      "/mason/packages/vue-language-server/node_modules/@vue/language-server"
  local vue_plugin = {
    name = '@vue/typescript-plugin',
    location = vue_language_server_path,
    languages = { 'vue' },
    configNamespace = 'typescript',
  }
  vim.lsp.config('vtsls', {
    settings = {
      vtsls = {
        tsserver = {
          globalPlugins = {
            vue_plugin,
          },
        },
      },
    },
    filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
  })

  -- Other servers
  vim.lsp.config('ty', {})
  vim.lsp.enable('ty')
  vim.lsp.config('gdscript', {})
  vim.lsp.enable('gdscript')
end


return M
