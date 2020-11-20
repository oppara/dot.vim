" prabirshrestha/asyncomplete-buffer.vim: provides buffer autocomplete for asyncomplete.vim
" https://github.com/prabirshrestha/asyncomplete-buffer.vim

if empty(globpath(&rtp, 'autoload/asyncomplete/sources/buffer.vim'))
  finish
endif

call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
      \ 'name': 'buffer',
      \ 'allowlist': ['*'],
      \ 'blocklist': [],
      \ 'completor': function('asyncomplete#sources#buffer#completor'),
      \ 'config': {
      \    'max_buffer_size': 5000000,
      \  },
      \ }))

