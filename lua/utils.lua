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
local macro_state = ''
local timer = nil
local refresh_interval = 1000 -- milliseconds

local function update_macro_state()
  local recording_register = vim.fn.reg_recording()
  if recording_register ~= '' then
    macro_state = 'Rec  @' .. recording_register
    refresh_interval = 100
  else
    macro_state = ''
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

return utils
