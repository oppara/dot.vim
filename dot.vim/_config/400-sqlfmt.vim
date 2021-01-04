" vim-sqlfmt/sqlfmt.vim at master  mattn/vim-sqlfmt
" https://github.com/mattn/vim-sqlfmt/blob/master/ftplugin/sql/sqlfmt.vim

let g:sqlfmt_program = "sqlformat --comma_first true -r -k upper -o %s -"

nmap <buffer><leader>ti <Plug>(sqlfmt)
