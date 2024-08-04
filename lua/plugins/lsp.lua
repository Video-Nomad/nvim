local M = { "neovim/nvim-lspconfig" }

M.event = "VeryLazy"

M.dependencies = {
  "hrsh7th/nvim-cmp",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "folke/neodev.nvim",
}

M.config = function()
  local map = vim.keymap.set
  -- LSP related keymaps
  map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[R]e[n]ame" })
  map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction" })
  map("n", "gd", vim.lsp.buf.definition, { desc = "[G]oto [D]efinition" })
  map("n", "gI", vim.lsp.buf.implementation, { desc = "[G]oto [I]mplementation" })
  map("n", "<leader>D", vim.lsp.buf.type_definition, { desc = "Type [D]efinition" })

  -- Signature help and hover
  map("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })
  map({ "n", "i", "s" }, "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature Documentation" })

  -- Lesser used LSP functionality
  map("n", "gD", vim.lsp.buf.declaration, { desc = "[G]oto [D]eclaration" })
  map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { desc = "[W]orkspace [A]dd Folder" })
  map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { desc = "[W]orkspace [R]emove Folder" })
  map("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, { desc = "[W]orkspace [L]ist Folders" })

  -- This function gets run when an LSP connects to a particular buffer.
  local on_attach = function(_, bufnr)
    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
      require("conform").format({ lsp_format = "fallback" })
    end, { desc = "Format current buffer with LSP" })
  end

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
      },
    },
    volar = {},
    clangd = {
      -- root_dir = vim.lsp.buf.list_workspace_folders()
    },
    pyright = {
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
    csharp_ls = {},
    ruff_lsp = {},
    docker_compose_language_service = {},
  }

  -- Setup neovim lua configuration
  require("neodev").setup()

  -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

  -- Setup mason so it can manage external tooling
  require("mason").setup()

  -- Ensure the servers above are installed
  local mason_lspconfig = require("mason-lspconfig")

  mason_lspconfig.setup({
    ensure_installed = vim.tbl_keys(servers),
  })

  mason_lspconfig.setup_handlers({
    function(server_name)
      require("lspconfig")[server_name].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = servers[server_name],
      })
    end,
  })

  -- Some custom options for certain LSPs
  require("lspconfig")["html"].setup({
    filetypes = { "html", "htmldjango" },
  })

  require("lspconfig")["docker_compose_language_service"].setup({
    filetypes = { "yml", "yaml" },
  })

  require("lspconfig")["volar"].setup({
    filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
    init_options = {
      vue = {
        hybridMode = false,
      },
    },
  })

  -- Show hover popup with a border
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  -- Show signature help with a rounded border
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })

  -- Configure the lsp diagnostics visualisation
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    severity_sort = true,
    update_in_insert = false,
    signs = {
      severity = { min = vim.diagnostic.severity.WARN },
    },
    virtual_text = {
      severity = { min = vim.diagnostic.severity.WARN },
    },
  })

  -- Set rounded borders for LspInfo window
  require("lspconfig.ui.windows").default_options.border = "rounded"
end

return M
