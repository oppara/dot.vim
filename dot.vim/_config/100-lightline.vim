" itchyny/lightline.vim: A light and configurable statusline/tabline plugin for Vim
" https://github.com/itchyny/lightline.vim

if empty(globpath(&rtp, 'autoload/lightline.vim'))
  finish
endif

let s:base04 = [ '#fdf6e3', 230 ]
let s:base03 = [ '#002b36', 234 ]
let s:base02 = [ '#073642', 235 ]
let s:base01 = [ '#586e75', 240 ]
let s:base00 = [ '#657b83', 245  ]
let s:green = [ '#859900', 64 ]
let s:red = [ '#dc322f', 160 ]
let s:orange = [ '#cb4b16', 166 ]
let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}}
let s:p.normal.left = [ [ s:base04, s:base01 ], [ s:base03, s:base00 ], [ s:base04, s:red ] ]
let s:p.inactive.left =  [ [ s:base00, s:base02 ], [ s:base00, s:base02 ] ]
let s:p.insert.left = [ [ s:base04, s:green ], [ s:base03, s:base00 ] ]
let s:p.replace.left = [ [ s:base04, s:red ], [ s:base03, s:base00 ] ]
let s:p.visual.left = [ [ s:base04, s:orange ], [ s:base03, s:base00 ] ]
let s:p.normal.right = [ [ s:base00, s:base02 ], [ s:base00, s:base01 ] ]
let s:p.inactive.right = [ [ s:base00, s:base02 ], [ s:base00, s:base02 ] ]
let s:p.normal.middle = [ [ s:base03, s:base00 ] ]
let s:p.inactive.middle = [ [ s:base00, s:base02 ] ]
function! s:flatten(p)
  for k in values(a:p)
    for l in values(k)
      for m in range(len(l))
        let l[m] = [l[m][0][0], l[m][1][0], l[m][0][1], l[m][1][1]]
      endfor
    endfor
  endfor
  return a:p
endfunction
let g:lightline#colorscheme#hogehoge#palette = s:flatten(s:p)

let g:lightline = {
      \ 'colorscheme': 'hogehoge',
      \ 'active': {
      \   'left': [ [ 'paste', 'readonly', 'modified' ],
      \             [ 'filename' ], [ 'ale', 'cocstatus' ] ],
      \   'right': [ [ 'percent' ],
      \              [ 'lineinfo' ],
      \              [ 'fugitive', 'fileencoding', 'fileformat', 'filetype' ] ]
      \ },
      \ 'inactive': {
      \   'left': [ [ 'readonly', 'modified', 'relativepath' ] ],
      \   'right': [ [ 'percent' ],
      \              [ 'lineinfo' ],
      \              [ 'fugitive', 'fileencoding', 'fileformat', 'filetype' ] ]
      \ },
      \ 'component': {
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'component_visible_condition': {
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
      \   'ale': 'ALEStatus'
      \ },
      \ }


function! ALEStatus()
  if empty(globpath(&rtp, 'autoload/ale.vim'))
    return ''
  endif

  let l:counts = ale#statusline#Count(bufnr(''))

  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors

  return l:counts.total == 0 ? '' : printf(
        \   '%dW %dE',
        \   all_non_errors,
        \   all_errors
        \)
endfunction

