" mattn/vim-molder
" https://github.com/mattn/vim-molder

if empty(globpath(&rtp, 'autoload/molder.vim'))
  finish
endif

augroup vim-molder
  autocmd!
  autocmd FileType molder nmap u <plug>(molder-up)
  autocmd FileType molder nmap o <plug>(molder-open)
augroup END
