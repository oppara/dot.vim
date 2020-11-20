" preservim/nerdcommenter: Vim plugin for intensely nerdy commenting powers
" https://github.com/preservim/nerdcommenter

" http://d.hatena.ne.jp/tanakaBox/20070409/1176062438
" <leader>cc  コメント
" <leader>cu  コメント削除
" <leader>cA  行末にコメント
" <leader>c<space>  トグル
"
let g:NERDSpaceDelims = 1
let g:NERDShutUp = 1
let g:NERDCustomDelimiters = {
  \ 'html': { 'left': '<!--', 'right': '-->' },
  \ 'vue': { 'left': '//' }
  \ }
