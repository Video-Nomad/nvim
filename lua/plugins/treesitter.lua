local M = { "nvim-treesitter/nvim-treesitter" }

M.event = "VeryLazy"

M.build = function()
  pcall(require("nvim-treesitter.install").update({ with_sync = true }))
end

M.dependencies = {
  "nvim-treesitter/nvim-treesitter-textobjects",
  -- "nvim-treesitter/playground",
}

M.config = function()
  -- See `:help nvim-treesitter`
  require("nvim-treesitter.configs").setup({
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = {
      "c",
      "cpp",
      "css",
      "go",
      "html",
      "htmldjango",
      "javascript",
      "typescript",
      "astro",
      "vue",
      "json",
      "lua",
      "markdown",
      "markdown_inline",
      "python",
      "regex",
      "rust",
      "scss",
      "toml",
      "vim",
      "yaml"
    },
    ignore_install = {},
    modules = {},

    sync_install = false,
    auto_install = true,

    highlight = {
      enable = true,
      additional_vim_regex_highlighting = { "markdown", "rst" },

      -- We can disable treesitter highligh on large files
      -- disable = function(lang, buf)
      --   return vim.api.nvim_buf_line_count(buf) > 5000
      -- end,
      -- use_languagetree = true,
    },
    indent = {
      enable = true,
      -- disable = { "python" }, -- TODO: Do we want to disable this?
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        node_incremental = "<a-=>",
        node_decremental = "<a-->",
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["at"] = "@tag.outer",
          ["it"] = "@tag.inner",
          ["aa"] = "@parameter.outer",
          ["ia"] = "@parameter.inner",
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          ["]m"] = "@function.outer",
          ["]]"] = "@class.outer",
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
          ["]["] = "@class.outer",
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[["] = "@class.outer",
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer",
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ["<leader>a"] = "@parameter.inner",
        },
        swap_previous = {
          ["<leader>A"] = "@parameter.inner",
        },
      },
    },
  })
end

return M
