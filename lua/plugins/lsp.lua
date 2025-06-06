local M = { "neovim/nvim-lspconfig" }

M.event = "VeryLazy"

M.dependencies = {
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
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
    clangd = {
      -- root_dir = vim.lsp.buf.list_workspace_folders()
    },
    vue_ls = {
    },
    basedpyright = {
      python = {
        analysis = {
          root_dir = ".",
          diagnosticMode = "openFilesOnly", -- ["openFilesOnly", "workspace"]
        },
      },
    },
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
    },
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
    omnisharp = {},
    astro = {
      typescript = {},
    },
  }

  -- Setup mason so it can manage external tooling
  require("mason").setup()

  -- Ensure the servers above are installed
  local mason_lspconfig = require("mason-lspconfig")

  mason_lspconfig.setup({
    automatic_enable = true,
    ensure_installed = vim.tbl_keys(servers),
  })

  -- Some custom options for certain LSPs
  require("lspconfig")["html"].setup({
    filetypes = { "html", "htmldjango" },
  })

  require("lspconfig")["docker_compose_language_service"].setup({
    filetypes = { "yml", "yaml" },
  })

  -- Hardcoded and only for Windows for now
  if vim.fn.has("win32") == 1 then
    local nginx_lsp_path = vim.fn.expand("$USERPROFILE")
        .. "/Python/3.11.4/Scripts/nginx-language-server.exe"
    require("lspconfig")["nginx_language_server"].setup({
      cmd = { nginx_lsp_path },
      filetypes = { "nginx" },
    })
  end

  vim.lsp.config('vue_ls', {
    init_options = {
      vue = {
        -- disable hybrid mode
        hybridMode = false,
      },
    },
  })
end

return M
