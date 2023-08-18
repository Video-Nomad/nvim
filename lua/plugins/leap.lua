local M = { 'ggandor/leap.nvim' }


M.event = "VeryLazy"

M.config = function()
  require('leap').add_default_mappings()
end

return M
