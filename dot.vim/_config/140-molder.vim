" mattn/vim-molder
" https://github.com/mattn/vim-molder

UsePlugin 'vim-molder'

augroup vim-molder
  autocmd!
  autocmd FileType molder nmap <buffer> u <plug>(molder-up)
  autocmd FileType molder nmap <buffer> o <plug>(molder-open)
augroup END
