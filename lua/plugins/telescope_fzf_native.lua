local M = { "nvim-telescope/telescope-fzf-native.nvim" }

M.dependencies = {
  "nvim-telescope/telescope.nvim",
}

local os_name = vim.loop.os_uname().sysname

if os_name == "Linux" then
  M.build = "make"
elseif os_name == "Windows_NT" then
  M.build =
    "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
end

M.config = function()
  require("telescope").load_extension("fzf")
end

return M
