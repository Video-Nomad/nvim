-- Helper function to trim leading whitespace
local function ltrim(s)
  return s:match("^%s*(.*)")
end

-- Helper function to trim trailing whitespace
local function rtrim(s)
  return s:match("(.-)%s*$")
end

--- Formats a single line for alignment.
--- @param line string The original line content.
--- @param sep string The alignment separator (unescaped).
--- @param escaped_sep string The Lua-pattern-escaped separator.
--- @param max_prefix_len number The maximum length of the trimmed prefix among all lines.
--- @param align_config table Configuration options (e.g., { space_before = true, space_after = true })
--- @return string The formatted line, or the original line if separator not found.
local function format_aligned_line(line, sep, escaped_sep, max_prefix_len, align_config)
  -- Use plain search to avoid issues with special characters in sep
  local sep_start, sep_end = string.find(line, escaped_sep, 1, true)

  if not sep_start then
    return line -- Separator not found, return original line
  end

  local prefix = string.sub(line, 1, sep_start - 1)
  local suffix = string.sub(line, sep_end + 1)

  local trimmed_prefix = rtrim(prefix)
  local trimmed_suffix = ltrim(suffix)

  -- Calculate padding spaces needed before the separator
  local spaces_count = max_prefix_len - #trimmed_prefix
  -- Ensure non-negative spaces (can happen if line content exceeds max_prefix_len somehow, defensive)
  spaces_count = math.max(0, spaces_count)

  local spaces_before_sep = align_config.space_before and " " or ""
  local spaces_after_sep = align_config.space_after and " " or ""

  local padding = string.rep(" ", spaces_count)

  return trimmed_prefix .. padding .. spaces_before_sep .. sep .. spaces_after_sep .. trimmed_suffix
end

--- Aligns a range of lines in the current buffer based on a separator.
--- @param start_line number The starting line number (1-based).
--- @param end_line number The ending line number (1-based).
--- @param separator string? The separator to align on. Defaults to "=".
local function align_range(start_line, end_line, separator)
  local sep = (separator or ""):match("^%s*(.-)%s*$") -- Trim separator itself
  if sep == "" then
    sep = "="
  end

  -- Escape the separator for safe use in string.find (plain=true makes this less critical, but good practice)
  -- Using vim.pesc() ensures robust escaping of all potential Lua pattern characters.
  local escaped_sep = vim.pesc(sep)

  -- Configuration for spacing around the separator
  local align_config = {
    space_before = true, -- Add a space before the separator
    space_after = true,  -- Add a space after the separator
  }

  -- Get lines from buffer (0-based index for API)
  local lines, err = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
  if err or not lines then
    vim.notify("Error getting buffer lines: " .. tostring(err), vim.log.levels.ERROR)
    return
  end

  local max_prefix_len = 0
  local lines_with_sep = 0

  -- First pass: Find the maximum length of the content before the separator
  for _, line in ipairs(lines) do
    local sep_start = string.find(line, escaped_sep, 1, true)
    if sep_start then
      lines_with_sep = lines_with_sep + 1
      local prefix = string.sub(line, 1, sep_start - 1)
      local trimmed_prefix = rtrim(prefix)
      max_prefix_len = math.max(max_prefix_len, #trimmed_prefix)
    end
  end

  -- Check if any lines contained the separator
  if lines_with_sep == 0 then
    vim.notify('Separator "' .. sep .. '" not found in the selected range.', vim.log.levels.WARN)
    return
  end

  -- Second pass: Format each line
  local formatted_lines = {}
  for i, line in ipairs(lines) do
    formatted_lines[i] = format_aligned_line(line, sep, escaped_sep, max_prefix_len, align_config)
  end

  -- Replace lines in buffer (0-based index for API)
  local ok, err2 = pcall(vim.api.nvim_buf_set_lines, 0, start_line - 1, end_line, false, formatted_lines)
  if not ok then
    vim.notify("Error setting buffer lines: " .. tostring(err2), vim.log.levels.ERROR)
  end
end

-- Create Align command
vim.api.nvim_create_user_command("Align", function(opts)
  -- opts.line1 and opts.line2 are the start and end lines of the range (1-based)
  -- opts.args is the string provided after the command
  align_range(opts.line1, opts.line2, opts.args)
end, {
  range = true, -- Allows specifying a range like :'<,'>Align
  nargs = "?",  -- Allows zero or one argument (the separator)
  desc = 'Align current line or selection on "=" or custom character/string',
})
