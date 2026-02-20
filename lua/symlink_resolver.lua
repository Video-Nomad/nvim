-- Automatically resolve symlinked directories for the workspace
vim.api.nvim_create_autocmd({ "VimEnter", "DirChanged" }, {
  group = vim.api.nvim_create_augroup("ResolveSymlinkCWD", { clear = true }),
  callback = function()
    local cwd = vim.fn.getcwd()
    local uv = vim.uv or vim.loop

    ---@diagnostic disable-next-line: undefined-field
    local real_cwd = uv.fs_realpath(cwd)
    if real_cwd and cwd ~= real_cwd then
      real_cwd = real_cwd:gsub("\\", "/")
      vim.api.nvim_set_current_dir(real_cwd)
    end
  end,
})
