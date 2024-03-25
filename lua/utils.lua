local utils = {}

--Truncate the path based on the elements and overall length
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

return utils
