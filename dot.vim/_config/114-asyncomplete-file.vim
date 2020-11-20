" prabirshrestha/asyncomplete-file.vim: provides file autocomplete for asyncomplete.vim
" https://github.com/prabirshrestha/asyncomplete-file.vim

if empty(globpath(&rtp, 'autoload/asyncomplete/sources/file.vim'))
  finish
endif

call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
      \ 'name': 'file',
      \ 'allowlist': ['*'],
      \ 'priority': 10,
      \ 'completor': function('asyncomplete#sources#file#completor')
      \ }))
