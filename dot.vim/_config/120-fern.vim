" lambdalisue/fern.vim: 🌿 General purpose asynchronous tree viewer written in Pure Vim script
" https://github.com/lambdalisue/fern.vim

if empty(globpath(&rtp, 'autoload/fern.vim'))
  finish
endif

nnoremap <silent> <Leader>f :<C-u>Fern . -reveal=% -drawer -toggle -width=40<CR>

function! s:init_fern() abort
  " TODO ファイルだったらドローワーを閉じてファイルを開く
  " nmap <buffer> <CR> <Plug>(fern-action-open:edit):<C-u>FernDo close -drawer -stay<CR>

  nmap <buffer> <C-s> <Plug>(fern-action-open:split):<C-u>FernDo close -drawer -stay<CR>
  nmap <buffer> <C-v> <Plug>(fern-action-open:vsplit):<C-u>FernDo close -drawer -stay<CR>

  nmap <buffer><expr>
      \ <Plug>(fern-my-expand-or-collapse)
      \ fern#smart#leaf(
      \   "\<Plug>(fern-action-collapse)",
      \   "\<Plug>(fern-action-expand)",
      \   "\<Plug>(fern-action-collapse)",
      \ )

  nmap <buffer><nowait> l <Plug>(fern-my-expand-or-collapse)
endfunction

augroup fern-custom
  autocmd! *
  autocmd FileType fern call s:init_fern()
augroup END

