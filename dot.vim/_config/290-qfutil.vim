" anyakichi/vim-qfutil: Quickfix utility
" https://github.com/anyakichi/vim-qfutil

" http://www.sopht.jp/blog/index.php?/archives/458-Quickfix-utility-for-Vim.html
nnoremap <silent> q\ :<C-u>call qfutil#toggle()<CR>
nnoremap <silent> q. :<C-u>call qfutil#toggle_window()<CR>
nnoremap <silent> qq :<C-u>call qfutil#qq(v:count)<CR>

" nnoremap <silent> [Quickfix]o :<C-u>call qfutil#open()<CR>
nnoremap <silent> [Quickfix]o :<C-u>call qfutil#open()<Return>:execute "set modifiable"<cr>
nnoremap <silent> [Quickfix]c :<C-u>call qfutil#close()<CR>
nnoremap <silent> [Quickfix]j :<C-u>call qfutil#next(v:count)<CR>
nnoremap <silent> [Quickfix]k :<C-u>call qfutil#previous(v:count)<CR>
nnoremap <expr> [Quickfix]g qfutil#grep('')


