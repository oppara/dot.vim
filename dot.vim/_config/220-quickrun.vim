" thinca/vim-quickrun: Run commands quickly.
" https://github.com/thinca/vim-quickrun

map <unique> <Leader>r <plug>(quickrun)

augroup vim-quickrun
  autocmd!
  autocmd FileType quickrun nnoremap <silent><buffer>q :quit<CR>
augroup END

let g:quickrun_config = get(g:, 'quickrun_config', {})
let g:quickrun_config._ = {
      \ 'outputter/buffer/opener': 'new',
      \ 'outputter/buffer/into': 1,
      \ 'outputter/buffer/close_on_empty': 1,
      \ }

" " http://www.karakaram.com/vim/phpunit-location-list/
" augroup QuickRunPHPUnit
  " autocmd!
  " autocmd BufWinEnter,BufNewFile *Test.php set filetype=php.phpunit
" augroup END
" let g:quickrun_config['php.phpunit'] = {}
" let g:quickrun_config['php.phpunit']['outputter'] = 'phpunit'
" let g:quickrun_config['php.phpunit']['command'] = 'phpunit'
" let g:quickrun_config['php.phpunit']['exec'] = '%c %o %s'
" let g:quickrun_config['php.phpunit']['outputter/phpunit/height'] = 3
" let g:quickrun_config['php.phpunit']['outputter/phpunit/running_mark'] = 'running...'
" let g:quickrun_config['php.phpunit']['outputter/phpunit/auto_open'] = 1

let g:quickrun_config['objc'] = {
      \ 'command': 'cc',
      \ 'exec': ['%c %s -o %s:p:r -framework Foundation', '%s:p:r %a', 'rm -f %s:p:r'],
      \ 'tempfile': '{tempname()}.m',
      \}


