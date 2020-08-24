" clones/vim-autocomplpop: Mirror of vim-autocomplpop
" https://github.com/clones/vim-autocomplpop

if empty(globpath(&rtp, 'autoload/acp.vim'))
  finish
endif

let g:acp_behaviorSnipmateLength = 1
let g:AutoComplPop_MappingDriven = 1
let g:acp_behaviorKeywordLength = 2
let g:acp_behaviorFileLength = 2
let g:acp_behaviorHtmlOmniLength = 1
let g:acp_ignorecaseOption = 0

" http://subtech.g.hatena.ne.jp/cho45/20071111/1194766579
" 補完候補表示したままRETおして改行できるようにする。
" inoremap <expr> <CR> pumvisible() ? "\<C-Y>\<CR>" : "\<CR>"

" 使用するか考え中
" http://d.hatena.ne.jp/cooldaemon/20071114/1195029893
" autocmd FileType * let g:AutoComplPop_CompleteOption = '.,w,b,u,t,i'
" autocmd FileType perl let g:AutoComplPop_CompleteOption = '.,w,b,u,t,k~/.vim/dict/perl_dunctions.dict'
" autocmd FileType php let g:AutoComplPop_CompleteOption = '.,w,b,u,t,k~/.vim/dict/PHP.dict'
" autocmd FileType ruby let g:AutoComplPop_CompleteOption = '.,w,b,u,t,i,k~/.vim/dict/ruby.dict'
" autocmd FileType javascript let g:AutoComplPop_CompleteOption = '.,w,b,u,t,i,k~/.vim/dict/javascript.dict'
" autocmd FileType erlang let g:AutoComplPop_CompleteOption = '.,w,b,u,t,i,k~/.vim/dict/erlang.dict'

" set omnifunc=phpcomplete#CompletePHP
