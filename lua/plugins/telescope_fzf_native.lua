local M = { "nvim-telescope/telescope-fzf-native.nvim" }

M.dependencies = {
  "nvim-telescope/telescope.nvim",
}

M.build =
  "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"

M.config = function()
  require("telescope").load_extension("fzf")
end

return M
