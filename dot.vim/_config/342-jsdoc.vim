" heavenshell/vim-jsdoc: Generate JSDoc to your JavaScript code.
" https://github.com/heavenshell/vim-jsdoc

let g:jsdoc_default_mapping = 0

augroup jsdoc
  autocmd!
  autocmd FileType javascript nmap <silent> <leader>d <Plug>(jsdoc)
augroup END
