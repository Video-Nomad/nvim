local M = { "jake-stewart/multicursor.nvim" }

M.branch = "1.0"

M.event = "VeryLazy"

M.config = function()
  local mc = require("multicursor-nvim")
  mc.setup()

  local set = vim.keymap.set

  -- Add cursors above/below the main cursor.
  set({ "n", "v" }, "<c-up>", function()
    mc.lineAddCursor(-1)
  end)

  set({ "n", "v" }, "<c-down>", function()
    mc.lineAddCursor(1)
  end)

  -- Add a cursor and jump to the next word under cursor.
  set({ "n", "v" }, "<c-n>", function()
    mc.matchAddCursor(1)
  end)

  -- Jump to the next word under cursor but do not add a cursor.
  set({ "n", "v" }, "<c-s>", function()
    mc.matchSkipCursor(1)
  end)

  -- Rotate the main cursor.
  set({ "n", "v" }, "<c-left>", mc.nextCursor)
  set({ "n", "v" }, "<c-right>", mc.prevCursor)

  -- Delete the main cursor.
  set({ "n", "v" }, "<leader>x", mc.deleteCursor)

  -- Add and remove cursors with control + left click.
  set("n", "<c-leftmouse>", mc.handleMouse)

  set({ "n", "v" }, "<c-q>", function()
    if mc.cursorsEnabled() then
      -- Stop other cursors from moving.
      -- This allows you to reposition the main cursor.
      mc.disableCursors()
    else
      mc.addCursor()
    end
  end)

  set("n", "<esc>", function()
    if not mc.cursorsEnabled() then
      mc.enableCursors()
    elseif mc.hasCursors() then
      mc.clearCursors()
    else
      -- Default <esc> handler.
    end
  end)

  -- Align cursor columns.
  set("n", "<leader>a", mc.alignCursors)

  -- Split visual selections by regex.
  set("v", "<a-S>", mc.splitCursors)

  -- Append/insert for each line of visual selections.
  set("v", "I", mc.insertVisual)
  set("v", "A", mc.appendVisual)

  -- match new cursors within visual selections by regex.
  set("v", "M", mc.matchCursors)

  -- Rotate visual selection contents.
  set("v", "<leader>t", function()
    mc.transposeCursors(1)
  end)
  set("v", "<leader>T", function()
    mc.transposeCursors(-1)
  end)

  -- Customize how cursors look.
  vim.api.nvim_set_hl(0, "MultiCursorCursor", { link = "Cursor" })
  vim.api.nvim_set_hl(0, "MultiCursorVisual", { link = "Visual" })
  vim.api.nvim_set_hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
  vim.api.nvim_set_hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
end

return M
