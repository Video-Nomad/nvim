local M = { "saghen/blink.cmp" }

M.dependencies = {
  "rafamadriz/friendly-snippets",
  "folke/neodev.nvim",
  { "L3MON4D3/LuaSnip", version = "v2.*" },
}

M.event = "VeryLazy"

M.version = "1.*"


M.config = function()
  local ft = vim.bo.filetype

  local default_sources = {
    "lazydev",
    "lsp",
    "path",
    "snippets",
    "buffer",
  }

  -- Remove "snippets" for PowerShell files because of lag
  if ft == "ps1" then
    default_sources = vim.tbl_filter(function(source)
      return source ~= "snippets"
    end, default_sources)
  end

  require("blink-cmp").setup({
    keymap = {
      ["<C-q>"] = { "show", "fallback" },
      ['<Tab>'] = {
        function(cmp)
          if cmp.snippet_active() then
            return cmp.accept()
          else
            return cmp.select_and_accept()
          end
        end,
        'snippet_forward',
        'fallback'
      },
      ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
      ["<CR>"] = { "select_and_accept", "fallback" },
      ["<C-p>"] = { "select_prev", "fallback" },
      ["<C-n>"] = { "select_next", "fallback" },
      ["<A-p>"] = { "select_prev", "fallback" },
      ["<A-n>"] = { "select_next", "fallback" },
    },

    appearance = {
      nerd_font_variant = "mono",
    },

    completion = {
      trigger = {
        show_in_snippet = false,
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 300,
        window = {
          border = "none",
        }
      },
      menu = {
        border = "none",
      }
    },

    snippets = { preset = "default" },

    signature = {
      enabled = true,
      window = {
        show_documentation = false,
        border = "none",
      },
    },

    sources = {
      min_keyword_length = function(ctx)
        if ctx.mode == "cmdline" and string.find(ctx.line, " ") == nil then
          return 3
        end
        return 0
      end,
      default = default_sources,
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
      },
    },

    fuzzy = { implementation = "prefer_rust_with_warning" },
  })
end


M.opts_extend = { "sources.default" }

return M
