" Valloric/MatchTagAlways: A Vim plugin that always highlights the enclosing html/xml tags
" https://github.com/Valloric/MatchTagAlways

UsePlugin 'MatchTagAlways'

let g:mta_filetypes = {
    \ 'html' : 1,
    \ 'xhtml' : 1,
    \ 'xml' : 1,
    \ 'jinja' : 1,
    \ 'php' : 1,
    \}

noremap mt :MtaJumpToOtherTag<cr>

