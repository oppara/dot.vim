" rhysd/vim-gfm-syntax: GitHub Flavored Markdown syntax highlight extension for Vim
" https://github.com/rhysd/vim-gfm-syntax

let g:gfm_syntax_enable_always = 0
let g:gfm_syntax_enable_filetypes = ['markdown.gfm']

augroup vimrc-vim-gfm-syntax
  autocmd!
  autocmd BufRead,BufNew,BufNewFile README.md setlocal ft=markdown.gfm
augroup END

" GitHub Flavored Markdown をもっと Vim でハイライトする vim-gfm-syntax つくった - はやくプログラムになりたい
" https://rhysd.hatenablog.com/entry/2016/10/09/213550
