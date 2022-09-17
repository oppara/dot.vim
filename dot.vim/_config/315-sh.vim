augroup my-ft-sh
  autocmd!
  autocmd FileType sh setlocal expandtab softtabstop=2 shiftwidth=2

  autocmd BufRead,BufNew .env setlocal filetype=bash
augroup END

