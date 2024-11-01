-- Language specific settings

-- GO
-- Use tabs in go files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
    vim.bo.expandtab = false
  end,
})

-- Treesitter RST fix (broken highlights)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    if vim.bo.filetype == "rst" then
      local parser = vim.treesitter.get_parser(0)
      if parser then
        parser:register_cbs({
          on_bytes = function()
            parser:parse()
          end,
        })
      end
    end
  end,
})
