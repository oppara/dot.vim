" junegunn/fzf.vim: fzf vim
" https://github.com/junegunn/fzf.vim

if empty(globpath(&rtp, 'plugin/fzf.vim'))
  finish
endif

let g:fzf_preview_window = 'right:45%'
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

command! -bang -nargs=* Rg
    \ call fzf#vim#grep(
    \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
    \   <bang>0 ? fzf#vim#with_preview('up:60%')
    \           : fzf#vim#with_preview('right:50%:hidden', '?'),
    \   <bang>0)


nnoremap fff :Files<cr>
nnoremap ffg :GFiles<cr>
nnoremap ffb :Buffers<cr>
nnoremap ffh :History<cr>
nnoremap ffm :History<cr>

