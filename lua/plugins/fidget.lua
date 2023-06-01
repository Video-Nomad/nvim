local M = { 'j-hui/fidget.nvim' }

M.config = function()
  require('fidget').setup {
    timer = {
      spinner_rate = 125,
      fidget_decay = 50,
      task_decay = 50,
    },
    window = {
      blend = 0,
    },
    text = {
      spinner = "dots_hop",
      done = "",
      commenced = "Started",
      completed = "Completed",
    },
  }
end

return M
