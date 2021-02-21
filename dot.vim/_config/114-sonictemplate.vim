" mattn/vim-sonictemplate: Easy and high speed coding method
" https://github.com/mattn/vim-sonictemplate

if empty(globpath(&rtp, 'autoload/sonictemplate.vim'))
  finish
endif

let g:sonictemplate_vim_template_dir = '$HOME/.vim/sonictemplate'
