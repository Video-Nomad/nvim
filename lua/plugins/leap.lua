local M = { 'ggandor/leap.nvim' }

M.keys = { "s", "S" }

M.config = function()
  require('leap').add_default_mappings()
end

return M
