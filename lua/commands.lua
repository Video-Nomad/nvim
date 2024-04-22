-- CUSTOM COMMANDS FOR NEOVIM

-- Align functionality
vim.cmd([[
  command! -nargs=? -range Align <line1>,<line2>call AlignSection('<args>')
  vnoremap <silent> <Leader>al :Align<CR>
  function! AlignSection(regex) range
    let extra = 1
    let sep = empty(a:regex) ? '=' : a:regex
    let maxpos = 0
    let section = getline(a:firstline, a:lastline)
    for line in section
      let pos = match(line, ' *'.sep)
      if maxpos < pos
        let maxpos = pos
      endif
    endfor
    call map(section, 'AlignLine(v:val, sep, maxpos, extra)')
    call setline(a:firstline, section)
  endfunction

  function! AlignLine(line, sep, maxpos, extra)
    let m = matchlist(a:line, '\(.\{-}\) \{-}\('.a:sep.'.*\)')
    if empty(m)
      return a:line
    endif
    let spaces = repeat(' ', a:maxpos - strlen(m[1]) + a:extra)
    return m[1] . spaces . m[2]
  endfunction
]])

-- Custom TreeSitter toggle

-- Disable Tree-sitter highlighting
function _G.disable_treesitter_highlight()
  require("nvim-treesitter.configs").setup({
    highlight = { enable = false, disable = true },
  })
end

-- Enable Tree-sitter highlighting
function _G.enable_treesitter_highlight()
  require("nvim-treesitter.configs").setup({
    highlight = { enable = true, disable = false },
  })
end

vim.cmd([[
  " Disable Tree-sitter highlighting when entering insert mode
  autocmd InsertEnter * lua disable_treesitter_highlight()
  " Enable Tree-sitter highlighting when leaving insert mode
  autocmd InsertLeave * lua enable_treesitter_highlight()
]])
