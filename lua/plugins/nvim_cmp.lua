local M = { "hrsh7th/nvim-cmp" }

M.event = "VeryLazy"

M.dependencies = {
  "rafamadriz/friendly-snippets",
  "folke/neodev.nvim",
  { "L3MON4D3/LuaSnip", version = "v2.*" },
  "saadparwaiz1/cmp_luasnip",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-nvim-lsp-signature-help",
}

M.config = function()
  local cmp = require("cmp")
  local cmp_nvim_lsp = require("cmp_nvim_lsp")
  local luasnip = require("luasnip")
  local capabilities = cmp_nvim_lsp.default_capabilities()

  if vim.lsp.config then
    vim.lsp.config("*", {
      capabilities = capabilities,
    })
  end

  require("luasnip.loaders.from_vscode").lazy_load()

  local function has_words_before()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    if col == 0 then
      return false
    end

    local current_line = vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]
    return current_line:sub(col, col):match("%s") == nil
  end

  local function insert_sources()
    local sources = {
      { name = "lazydev", group_index = 0, priority = 1000 },
      { name = "nvim_lsp" },
      { name = "path" },
      { name = "luasnip" },
      { name = "buffer" },
      { name = "nvim_lsp_signature_help" },
    }

    if vim.bo.filetype == "ps1" then
      sources = vim.tbl_filter(function(source)
        return source.name ~= "luasnip"
      end, sources)
    end

    return sources
  end

  cmp.setup({
    preselect = cmp.PreselectMode.Item,
    completion = {
      completeopt = "menu,menuone,noinsert",
      keyword_length = 0,
    },
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    window = {
      completion = cmp.config.window.bordered({
        border = "none",
      }),
      documentation = cmp.config.window.bordered({
        border = "none",
      }),
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-q>"] = cmp.mapping(function()
        if cmp.visible() then
          cmp.close()
        else
          cmp.complete()
        end
      end, { "i", "c" }),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if luasnip.expand_or_locally_jumpable() then
          luasnip.expand_or_jump()
        elseif cmp.visible() then
          cmp.confirm({ select = true })
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if luasnip.locally_jumpable(-1) then
          luasnip.jump(-1)
        elseif cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
      ["<C-p>"] = cmp.mapping.select_prev_item(),
      ["<C-n>"] = cmp.mapping.select_next_item(),
      ["<A-p>"] = cmp.mapping.select_prev_item(),
      ["<A-n>"] = cmp.mapping.select_next_item(),
    }),
    experimental = {
      ghost_text = false,
    },
    formatting = {
      fields = { "abbr", "kind", "menu" },
      format = function(entry, item)
        local source_names = {
          lazydev = "[LazyDev]",
          nvim_lsp = "[LSP]",
          path = "[Path]",
          luasnip = "[Snip]",
          buffer = "[Buf]",
          nvim_lsp_signature_help = "[Sig]",
        }

        item.menu = source_names[entry.source.name]
        return item
      end,
    },
    sorting = {
      priority_weight = 2,
      comparators = {
        function(entry1, entry2)
          local lazydev_boost = {
            lazydev = 100,
          }

          local score1 = lazydev_boost[entry1.source.name] or 0
          local score2 = lazydev_boost[entry2.source.name] or 0

          if score1 ~= score2 then
            return score1 > score2
          end
        end,
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        cmp.config.compare.score,
        cmp.config.compare.recently_used,
        cmp.config.compare.kind,
        cmp.config.compare.sort_text,
        cmp.config.compare.length,
        cmp.config.compare.order,
      },
    },
    sources = cmp.config.sources(insert_sources()),
  })

  --[[
  cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline({
      ["<C-p>"] = { c = cmp.mapping.select_prev_item() },
      ["<C-n>"] = { c = cmp.mapping.select_next_item() },
      ["<A-p>"] = { c = cmp.mapping.select_prev_item() },
      ["<A-n>"] = { c = cmp.mapping.select_next_item() },
      ["<CR>"] = { c = cmp.mapping.confirm({ select = true }) },
    }),
    completion = {
      keyword_length = 0,
    },
    sources = {
      { name = "buffer" },
    },
  })
  ]]

  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline({
      ["<C-q>"] = cmp.mapping(function()
        if cmp.visible() then
          cmp.close()
        else
          cmp.complete()
        end
      end, { "c" }),
      ["<C-p>"] = { c = cmp.mapping.select_prev_item() },
      ["<C-n>"] = { c = cmp.mapping.select_next_item() },
      ["<A-p>"] = { c = cmp.mapping.select_prev_item() },
      ["<A-n>"] = { c = cmp.mapping.select_next_item() },
      ["<CR>"] = { c = cmp.mapping.confirm({ select = true }) },
    }),
    completion = {
      keyword_length = 3,
    },
    sources = cmp.config.sources({
      { name = "path" },
    }, {
      { name = "cmdline" },
    }),
    matching = {
      disallow_symbol_nonprefix_matching = false,
    },
  })
end

return M
