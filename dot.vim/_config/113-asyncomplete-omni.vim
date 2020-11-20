" yami-beta/asyncomplete-omni.vim: Omni completion source for asyncomplete.vim
" https://github.com/yami-beta/asyncomplete-omni.vim

if empty(globpath(&rtp, 'autoload/asyncomplete/sources/omni.vim'))
  finish
endif

call asyncomplete#register_source(asyncomplete#sources#omni#get_source_options({
      \ 'name': 'omni',
      \ 'allowlist': ['*'],
      \ 'blocklist': ['c', 'cpp', 'html'],
      \ 'completor': function('asyncomplete#sources#omni#completor'),
      \ 'config': {
      \   'show_source_kind': 1,
      \ }
      \ }))

" If omnifunc change cursor position, asyncomplete-omni.vim does not work correctly.
" For example, c, cpp, HTML are blacklisted above
" because Vim's default omnifunc repositions the cursor leading to quirky behaviour.
" You can reenable if you are using a more appropriate omnifunc.
