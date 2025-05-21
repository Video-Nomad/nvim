-- CUSTOM COMMANDS FOR NEOVIM

-- Open current file in a separate Windows Terminal pane
vim.api.nvim_create_user_command("Open", function(_)
  local file_path = vim.fn.expand("%:p:h")
  vim.fn.system("wt -w 0 split-pane -V -d " .. file_path)
end, { desc = "Open current file in a separate terminal pane" })

-- Open current file in a separate Windows Terminal tab
vim.api.nvim_create_user_command("OpenTab", function(_)
  local file_path = vim.fn.expand("%:p:h")
  vim.fn.system("wt -w 0 -d " .. file_path)
end, { desc = "Open current file in a separate terminal tab" })

-- Function to execute ripgrep and populate quickfix list ignoring the ignore list
local function ripgrep_to_quickfix(args)
  -- Parse commands to be one string
  local cmd = "rg " .. args .. " --vimgrep --pcre2"
  vim.cmd("cgetexpr system('" .. cmd .. "')")
  vim.cmd("cw")
end

-- Register the custom command 'Grep'
vim.api.nvim_create_user_command("Grep", function(opts)
  -- Concat opts to one string
  local args = table.concat(opts.fargs, " ")
  ripgrep_to_quickfix(args)
end, { nargs = 1 })
