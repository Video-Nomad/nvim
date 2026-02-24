-- Deletes orphaned temporary files (*.tmp*) and checks for corrupted
-- main.shada file
local function cleanup_shada()
  local shada_dir = vim.fn.stdpath("state") .. "/shada"
  if vim.fn.has("nvim-0.8") == 0 then
    shada_dir = vim.fn.stdpath("data") .. "/shada" -- Fallback for older Nvim
  end
  local tmp_files = vim.fn.glob(shada_dir .. "/*.tmp*", false, true)
  for _, file in ipairs(tmp_files) do
    os.remove(file)
  end
  local ok, _ = pcall(function()
    vim.cmd("rshada")
  end)
  if not ok then
    local main_shada = shada_dir .. "/main.shada"
    os.remove(main_shada)
    vim.notify("Corrupted ShaDa file detected and automatically removed.", vim.log.levels.WARN)
  end
end

cleanup_shada()
