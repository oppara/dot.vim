" sheerun/vim-polyglot: A solid language pack for Vim.
" https://github.com/sheerun/vim-polyglot

if empty(globpath(&rtp, 'ftdetect/polyglot.vim'))
  finish
endif

let g:polyglot_disabled = ['jsx']
let g:jsx_ext_required = 1


