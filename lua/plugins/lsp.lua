local M = { 'neovim/nvim-lspconfig' }

M.dependencies = {
  'hrsh7th/nvim-cmp',
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  'folke/neodev.nvim',
}

M.config = function()
  local map = vim.keymap.set
  -- LSP related keymaps
  map('n', '<leader>rn', vim.lsp.buf.rename, { desc = '[R]e[n]ame' })
  map('n', '<leader>ca', vim.lsp.buf.code_action, { desc = '[C]ode [A]ction' })
  map('n', 'gd', vim.lsp.buf.definition, { desc = '[G]oto [D]efinition' })
  map('n', 'gI', vim.lsp.buf.implementation, { desc = '[G]oto [I]mplementation' })
  map('n', '<leader>D', vim.lsp.buf.type_definition, { desc = 'Type [D]efinition' })

  -- Signature help and hover
  map('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation' })
  map({ 'n', 'i', 's' }, '<C-k>', vim.lsp.buf.signature_help, { desc = 'Signature Documentation' })

  -- Lesser used LSP functionality
  map('n', 'gD', vim.lsp.buf.declaration, { desc = '[G]oto [D]eclaration' })
  map('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { desc = '[W]orkspace [A]dd Folder' })
  map('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, { desc = '[W]orkspace [R]emove Folder' })
  map('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, { desc = '[W]orkspace [L]ist Folders' })

  -- This function gets run when an LSP connects to a particular buffer.
  local on_attach = function(_, bufnr)
    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
      vim.lsp.buf.format({ async = true })
    end, { desc = 'Format current buffer with LSP' })
  end

  -- Enable the following language servers
  local servers = {
    rust_analyzer = {
    },
    cssls = {
    },
    html = {
    },
    clangd = {
    },
    pyright = {
      python = {
        analysis = {
          root_dir = ".",
          diagnosticMode = "openFilesOnly",
        }
      }
    },
    lua_ls = {
      Lua = {
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
      },
    },
  }

  -- Setup neovim lua configuration
  require('neodev').setup()

  -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

  -- Setup mason so it can manage external tooling
  require('mason').setup()

  -- Ensure the servers above are installed
  local mason_lspconfig = require('mason-lspconfig')

  mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
  }

  mason_lspconfig.setup_handlers {
    function(server_name)
      require('lspconfig')[server_name].setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = servers[server_name],
      }
    end,
  }

  -- Show hover popup with a border
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover, {
      border = "rounded",
    })

  -- Show signature help with a rounded border
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help, {
      border = "rounded",
    })

  -- Configure the lsp diagnostics visualisation
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      underline = true,
      severity_sort = true,
      update_in_insert = false,
      signs = {
        severity_limit = vim.diagnostic.severity.WARN,
      },
      virtual_text = {
        severity_limit = vim.diagnostic.severity.WARN,
      },
    }
  )

  -- Set rounded borders for LspInfo window
  require('lspconfig.ui.windows').default_options.border = 'rounded'
end

return M
