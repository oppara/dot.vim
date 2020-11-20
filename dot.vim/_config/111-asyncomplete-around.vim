" akaimo/asyncomplete-around.vim: Source of asyncomplete.vim which completes the words around the line.
" https://github.com/akaimo/asyncomplete-around.vim

if empty(globpath(&rtp, 'autoload/asyncomplete/sources/around.vim'))
  finish
endif

call asyncomplete#register_source(asyncomplete#sources#around#get_source_options({
      \ 'name': 'around',
      \ 'allowlist': ['*'],
      \ 'priority': 10,
      \ 'completor': function('asyncomplete#sources#around#completor'),
      \ }))
let g:asyncomplete_around_range = 40

