" prabirshrestha/asyncomplete.vim: async completion in pure vim script for vim8 and neovim
" https://github.com/prabirshrestha/asyncomplete.vim

if empty(globpath(&rtp, 'autoload/asyncomplete.vim'))
  finish
endif

" " 補完表示時のEnterで改行をしない
" inoremap <expr><CR>  pumvisible() ? "<C-y>" : "<CR>"

" set completeopt=menuone,noinsert
" set completeopt=menuone,noinsert,noselect,preview
" inoremap <expr><C-n> pumvisible() ? "<Down>" : "<C-n>"
" inoremap <expr><C-p> pumvisible() ? "<Up>" : "<C-p>"
