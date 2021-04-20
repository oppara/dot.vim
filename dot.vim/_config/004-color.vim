
syntax enable

augroup vimrc-color
  autocmd!
  autocmd ColorScheme * call s:onColorScheme()
  autocmd VimEnter,WinEnter * call matchadd('ZenkakuSpace', '　')

  function! s:onColorScheme()
    if !exists('g:colors_name')
      return
    endif

    highlight ZenkakuSpace ctermbg=Red ctermfg=Red guibg=Red

    highlight DiffAdd          ctermbg=235  ctermfg=108  cterm=reverse
    highlight DiffChange       ctermbg=235  ctermfg=27  cterm=reverse
    highlight DiffDelete       ctermbg=235  ctermfg=131  cterm=reverse
    highlight DiffText         ctermbg=235  ctermfg=33  cterm=reverse

    if g:colors_name !~? '^wombat'
      highlight Pmenu ctermbg=black
      highlight PmenuSel ctermfg=black ctermbg=white
      highlight PmenuSbar ctermbg=0
    endif
  endfunction
augroup END


if 200 < &t_Co && FindPlugin('wombat256opp')
    set t_Co=256
    colorscheme wombat256opp
else
    colorscheme delek
endif

