" vim-quickrun-phpunit/README.md at master 揃 karakaram/vim-quickrun-phpunit
" https://github.com/karakaram/vim-quickrun-phpunit/blob/master/README.md
"

augroup QuickRunPHPUnit
  autocmd!
  autocmd BufWinEnter,BufNewFile *Test.php nnoremap <buffer><Leader>r :QuickRun phpunit<cr>
augroup END

let g:quickrun_config['phpunit'] = {}
let g:quickrun_config['phpunit']['outputter'] = 'phpunit'

" let g:quickrun_config['phpunit']['outputter'] = 'buffer'
" buffer を使用した場合、syntax/quickrun.vim が使われる

let g:quickrun_config['phpunit']['type'] = 'phpunit'
let g:quickrun_config['phpunit']['command'] = 'phpunit'
let g:quickrun_config['phpunit']['cmdopt'] = ''
let g:quickrun_config['phpunit']['exec'] = '%c %o %s'

