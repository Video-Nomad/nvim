local M = { 'hrsh7th/nvim-cmp' }

M.dependencies = {
  -- Essentials
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-nvim-lua',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',

  -- Snippets
  'L3MON4D3/LuaSnip',
  'saadparwaiz1/cmp_luasnip',
  -- 'rafamadriz/friendly-snippets',

  -- Additional stuff
  'lukas-reineke/cmp-under-comparator',
}

M.event = "InsertEnter"

M.config = function()
  -- nvim-cmp setup
  local cmp = require('cmp')
  local luasnip = require('luasnip')
  require('luasnip.loaders.from_vscode').lazy_load()
  luasnip.config.setup()

  -- Additional snippets
  -- require 'luasnip'.filetype_extend("python", { "base" })

  local icons = {
    Namespace     = "󰌗",
    Text          = "󰉿",
    Method        = "󰆧",
    Function      = "󰊕",
    Constructor   = "",
    Field         = "󰜢",
    Variable      = "󰀫",
    Class         = "󰠱",
    Interface     = "",
    Module        = "",
    Property      = "󰜢",
    Unit          = "󰑭",
    Value         = "󰎠",
    Enum          = "",
    Keyword       = "󰌋",
    Snippet       = "",
    Color         = "󰏘",
    File          = "󰈚",
    Reference     = "󰈇",
    Folder        = "󰉋",
    EnumMember    = "",
    Constant      = "󰏿",
    Struct        = "󰙅",
    Event         = "",
    Operator      = "󰆕",
    TypeParameter = "󰊄",
    Table         = "",
    Object        = "󰅩",
    Tag           = "",
    Array         = "",
    Boolean       = "",
    Number        = "",
    Null          = "󰟢",
    String        = "󰉿",
    Calendar      = "",
    Watch         = "󰥔",
    Package       = "",
    Copilot       = "",
    Codeium       = "",
    TabNine       = "",
  }

  -- Setup cmp
  cmp.setup {
    preselect = cmp.PreselectMode.Item,
    completion = { completeopt = 'menu,menuone,noinsert' },
    window = {
      completion = {
        border = "rounded",
        winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
      },
      documentation = {
        border = "rounded"
      },
    },
    sorting = {
      comparators = {
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        cmp.config.compare.score,
        require('cmp-under-comparator').under,
        cmp.config.compare.kind,
        cmp.config.compare.sort_text,
        cmp.config.compare.length,
        cmp.config.compare.order,
      },
    },
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    formatting = {
      fields = {
        "kind",
        "abbr",
        "menu"
      },
      format = function(_, vim_item)
        vim_item.kind = icons[vim_item.kind] or ''
        -- vim_item.abbr = vim_item.abbr:match("[^(]+")
        -- vim_item.menu = (entry:get_completion_item().detail or ""):match("->.+")
        vim_item.menu = ""
        return vim_item
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
      ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ["<C-q>"] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ["<C-e>"] = cmp.mapping.close(),
      ["<CR>"] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      },
    }),
    sources = cmp.config.sources({
      { name = "path" },
      { name = 'nvim_lsp_signature_help' },
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "buffer" },
      { name = "nvim_lua" },
    }),
  }
end

return M
