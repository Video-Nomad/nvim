local M = { 'neomake/neomake' }

M.event = 'VeryLazy'


local function build()
  print("[Neomake] Running...")
  vim.cmd("NeomakeCancelJobs")
  vim.cmd("NeomakeClean!")
  vim.cmd("Neomake")
  print("[Neomake] Finished!")
end


M.config = function()
  -- Config
  vim.cmd([[ let g:neomake_rust_cargo_command = ['build'] ]])
  vim.g.neomake_python_enabled_makers = { 'python' }
  -- vim.g.neomake_python_python_args = { '-m', 'py_compile' }
  vim.g.neomake_open_list = 2
  -- Keymaps
  vim.keymap.set('n', '<F5>', build, { desc = "Run Neomake" })
  vim.keymap.set('n', '<F7>', function() vim.cmd("NeomakePrevLoclist") end, { desc = "Prev Neomake Error" })
  vim.keymap.set('n', '<F8>', function() vim.cmd("NeomakeNextLoclist") end, { desc = "Next Neomake Error" })
end

return M
