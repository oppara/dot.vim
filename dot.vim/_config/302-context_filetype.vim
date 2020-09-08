" Shougo/context_filetype.vim: Context filetype library for Vim script
" https://github.com/Shougo/context_filetype.vim

if empty(globpath(&rtp, 'context_filetype.vim'))
  finish
endif


let g:context_filetype#filetypes = {
  \ 'php': [
  \   {
  \    'start':
  \     '<script\%( [^>]*\)\? type="text/javascript"\%( [^>]*\)\?>',
  \    'end': '</script>', 'filetype': 'javascript',
  \   },
  \   {
  \    'start':
  \     '<script\%( [^>]*\)\? type="text/coffeescript"\%( [^>]*\)\?>',
  \    'end': '</script>', 'filetype': 'coffee',
  \   },
  \   {
  \    'start':
  \     '<script\%( [^>]*\)\?>',
  \    'end': '</script>', 'filetype': 'javascript',
  \   },
  \   {
  \    'start':
  \     '<style\%( [^>]*\)\?>',
  \    'end': '</style>', 'filetype': 'css',
  \   },
  \   {
  \    'start':
  \     '<[^>]\+ style=\([''"]\)',
  \    'end': '\1', 'filetype': 'css',
  \   },
  \ ],
\}


