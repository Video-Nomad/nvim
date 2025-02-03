local M = { "saghen/blink.cmp" }
-- optional: provides snippets for the snippet source
M.dependencies = {
  "rafamadriz/friendly-snippets",
  -- { "L3MON4D3/LuaSnip", version = "v2.*" },
}

M.lazy = false

M.build = "cargo build --release"

---@module 'blink.cmp'
---@type blink.cmp.Config
M.opts = {
  keymap = {
    ["<C-q>"] = { "show", "fallback" },
    ["<TAB>"] = { "select_and_accept", "fallback" },
    ["<CR>"] = { "select_and_accept", "fallback" },
    ["<C-p>"] = { "select_prev", "fallback" },
    ["<C-n>"] = { "select_next", "fallback" },
    ["<A-p>"] = { "select_prev", "fallback" },
    ["<A-n>"] = { "select_next", "fallback" },
    cmdline = {
      ["<TAB>"] = { "accept", "fallback" },
      ["<CR>"] = { "fallback" },
    },
  },

  appearance = {
    -- Sets the fallback highlight groups to nvim-cmp's highlight groups
    -- Useful for when your theme doesn't support blink.cmp
    -- Will be removed in a future release
    use_nvim_cmp_as_default = true,
    -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
    -- Adjusts spacing to ensure icons are aligned
    nerd_font_variant = "mono",
  },

  -- snippets = { preset = "luasnip" },

  -- Default list of enabled providers defined so that you can extend it
  -- elsewhere in your config, without redefining it, due to `opts_extend`
  sources = {
    min_keyword_length = function(ctx)
      -- only applies when typing a command, doesn't apply to arguments
      if ctx.mode == "cmdline" and string.find(ctx.line, " ") == nil then
        return 3
      end
      return 0
    end,
    default = {
      "lsp",
      "path",
      "snippets",
      "buffer",
    },
  },
}

M.opts_extend = { "sources.default" }

return M
