-- CUSTOM COMMANDS FOR NEOVIM
local utils = require("utils")

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

--[[
-- Align Line
local function align_line(line, sep, maxpos, extra)
  local pattern = string.format("(.-)%s(.*)", sep)
  local start, _, m1, m2 = string.find(line, pattern)
  if not start then
    return line
  end
  local spaces = string.rep(" ", maxpos - #m1 + extra)
  return m1 .. spaces .. sep .. m2
end

-- Align Selection
local function align_section(start_line, end_line, regex)
  local extra = 1
  local sep = regex ~= "" and regex or "="
  local maxpos = 0
  local section = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)

  for _, line in ipairs(section) do
    local pos = string.find(line, "%s*" .. sep)
    if pos and pos > maxpos then
      maxpos = pos
    end
  end

  for i, line in ipairs(section) do
    section[i] = align_line(line, sep, maxpos, extra)
  end

  vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, section)
end

-- Create Align command
vim.api.nvim_create_user_command("Align", function(opts)
  align_section(opts.line1, opts.line2, opts.args)
end, {
  range = true,
  nargs = "?",
  desc = 'Align current line or selection on "=" sign or custom string if provided',
})
]]
--

-- Escape regex special characters
local function escape_regex(str)
  return str:gsub("[%-%.%+%*%?%^%$%(%)%[%]%{%}%|%\\]", "%%%0")
end

-- Align Selection
local function align_section(start_line, end_line, regex)
  local sep = regex ~= "" and regex or "="
  sep = escape_regex(sep)
  local section = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
  local max_m1_length = 0

  -- First pass: find maximum length of the part before the separator
  for _, line in ipairs(section) do
    local m1 = line:match("^(.-)" .. sep) or ""
    max_m1_length = math.max(max_m1_length, #m1)
  end

  -- Second pass: align each line
  for i, line in ipairs(section) do
    local m1, m2 = line:match("^(.-)" .. sep .. "(.*)$")
    if m1 then
      local padding = string.rep(" ", max_m1_length - #m1)
      section[i] = m1 .. padding .. sep .. m2
      -- else: line doesn't contain separator, leave unchanged
    end
  end

  vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, section)
end

-- Create Align command
vim.api.nvim_create_user_command("Align", function(opts)
  align_section(opts.line1, opts.line2, opts.args)
end, {
  range = true,
  nargs = "?",
  desc = 'Align text on the first occurrence of a separator (default "=")',
})

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
