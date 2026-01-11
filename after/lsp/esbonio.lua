---@type vim.lsp.Config
local config = {
  cmd = { "esbonio" },
  filetypes = { "rst" },
  root_markers = { ".git" },
}

if vim.fn.executable("esbonio") ~= 1 then
  vim.notify("Esbonio not found. Attempting to install with uv...", vim.log.levels.INFO)

  vim.fn.system({
    "uv",
    "tool",
    "install",
    "esbonio",
    "--python",
    "3.13",
    "--with",
    "sphinx",
    "--with",
    "sphinx-rtd-theme",
    "--with",
    "sphinx-copybutton",
  })

  if vim.v.shell_error ~= 0 then
    vim.notify("Failed to install esbonio. Please install it manually.", vim.log.levels.ERROR, {
      title = "LSP Setup",
    })
  else
    vim.notify("Esbonio installed successfully.", vim.log.levels.INFO)
  end
end

return config
