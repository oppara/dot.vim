"
" General things that should be done at the very end, to override plugin
" settings
"
if exists('loaded_my_general')
  finish
endif

augroup AfterPlugin
  autocmd!
augroup END

set formatoptions+=BM

" コメントアウト行の改行時に次行をコメントアウトしない
set formatoptions-=r
set formatoptions-=o



"----------------------------------------------------------------------------"
" xhtml.vim : XHTML syntax highlighting
" http://www.vim.org/scripts/script.php?script_id=1236
"
" @TODO ftplugin にする
let xhtml_no_embedded_mathml = 1
let xhtml_no_embedded_svg = 1



" Plugins: "{{{1

" unite.vim  "{{{2
if exists('g:loaded_unite')

  autocmd AfterPlugin FileType unite call s:unite_my_settings()
  function! s:unite_my_settings()
    " Overwrite settings.

    nnoremap <buffer> <C-n> <Plug>(unite_select_next_line)
    nnoremap <buffer> <C-p> <Plug>(unite_select_previous_line)

    nnoremap <buffer> <ESC> <Plug>(unite_exit)
    imap <buffer> <ESC> <ESC><Plug>(unite_exit)
    nmap <buffer> <C-[> <Plug>(unite_exit)
    imap <buffer> jj <Plug>(unite_insert_leave)
    "imap <buffer> <C-w>     <Plug>(unite_delete_backward_path)

    nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
    inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
    nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
    inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
  endfunction

endif


" ref.vim  "{{{2
if exists('g:loaded_ref')
  nnoremap <space>al :<C-u>Ref alc
endif


" fakeclip.vim  "{{{2
if exists('g:loaded_fakeclip')
  nmap fy <Plug>(fakeclip-y)
  nmap fyy <Plug>(fakeclip-Y)
  nmap fY <Plug>(fakeclip-Y)
  vmap fy <Plug>(fakeclip-y)
  nmap fp <Plug>(fakeclip-p)
  nmap fP <Plug>(fakeclip-P)
endif




" Load: "{{{1
let loaded_my_general = 1

" vim: set fenc=utf-8 et tw=78 ts=2 sts=2 sw=2 fdm=marker :
