local utils = {}

--Truncate the path based on the elements and overall length (UNUSED)
---@param path string input path
---@param n number max length of the path (elements)
---@param max number max length of the path (symbols)
---@param show_file_name? boolean show file or just the folders
---@return string
function utils:format_path(path, n, max, show_file_name)
  local err, separator = pcall(require("telescope.utils").get_separator)
  if not err then
    print("Can't import Telescope")
    return ""
  end
  local parts = vim.split(path, separator)
  if n > #parts then
    n = #parts
  end
  local final_path = ""
  if show_file_name then
    final_path = parts[#parts]
  end
  for i = 2, n, 1 do
    final_path = parts[#parts - i + 1] .. separator .. final_path
  end
  if #final_path > max then
    final_path = "..." .. final_path:sub(-max)
  end
  if #final_path == 0 then
    final_path = "."
  end
  return final_path
end

-- Macro indicator for lualine
local macro_state = ""
local timer = nil
local refresh_interval = 1000 -- milliseconds

local function update_macro_state()
  local recording_register = vim.fn.reg_recording()
  if recording_register ~= "" then
    macro_state = "Rec  @" .. recording_register
    refresh_interval = 100
  else
    macro_state = ""
    refresh_interval = 500
  end

  -- Schedule the next update
  timer = vim.defer_fn(update_macro_state, refresh_interval)
end

function utils:macro_recording()
  -- Start the update cycle if it hasn't been started yet
  if timer == nil then
    timer = vim.defer_fn(update_macro_state, 0)
  end
  return macro_state
end

function utils:swap_windows(direction)
  local current_win = vim.api.nvim_get_current_win()
  local current_pos = vim.api.nvim_win_get_cursor(current_win)
  vim.cmd("wincmd " .. direction)
  local target_win = vim.api.nvim_get_current_win()

  if current_win ~= target_win then
    local target_pos = vim.api.nvim_win_get_cursor(target_win)
    local current_buf = vim.api.nvim_win_get_buf(current_win)
    local target_buf = vim.api.nvim_win_get_buf(target_win)

    -- Swap buffers
    vim.api.nvim_win_set_buf(current_win, target_buf)
    vim.api.nvim_win_set_buf(target_win, current_buf)

    -- Swap cursor positions
    vim.api.nvim_win_set_cursor(current_win, target_pos)
    vim.api.nvim_win_set_cursor(target_win, current_pos)

    vim.api.nvim_set_current_win(target_win)
  end
end

function utils:setup_cursorline()
  -- Enable cursorline globally
  vim.opt.cursorline = true

  local cursorline_group = vim.api.nvim_create_augroup("CursorLineControl", { clear = true })

  vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter", "InsertLeave" }, {
    group = cursorline_group,
    callback = function()
      vim.opt_local.cursorline = true
    end,
  })

  vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave", "InsertEnter" }, {
    group = cursorline_group,
    callback = function()
      vim.opt_local.cursorline = false
    end,
  })
end

return utils
