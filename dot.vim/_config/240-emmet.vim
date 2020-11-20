" mattn/emmet-vim: emmet for vim: http://emmet.io/
" https://github.com/mattn/emmet-vim

if empty(globpath(&rtp, 'autoload/emmet.vim'))
  finish
endif

let g:user_emmet_leader_key='<c-e>'

let g:user_emmet_settings = {
      \  'variables': {
      \    'lang': 'ja',
      \    'charset': 'utf-8'
      \  },
      \ 'indentation': '  '
      \}







