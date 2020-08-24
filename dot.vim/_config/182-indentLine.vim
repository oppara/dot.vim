" Yggdroot/indentLine: A vim plugin to display the indention levels with thin vertical lines
" https://github.com/Yggdroot/indentLine

if empty(globpath(&rtp, 'after/plugin/indentLine.vim'))
  finish
endif

let g:indentLine_color_term = 235

let g:indentLine_fileType = [
    \ 'javascript',
    \ 'json',
    \ 'yaml',
    \ 'scss',
    \ 'sass',
    \ 'slim',
    \ 'haml',
    \ 'html',
    \ 'ansible'
    \]

