" z0mbix/vim-shfmt: Vim plugin for shfmt (https://github.com/mvdan/sh)
" https://github.com/z0mbix/vim-shfmt

UsePlugin 'vim-shfmt'

let g:shfmt_extra_args = '-i 2 -ci -bn -s'

augroup my-shfmt
  autocmd!
  autocmd FileType sh nnoremap <silent><buffer><leader>ti :Shfmt<cr>
augroup END
