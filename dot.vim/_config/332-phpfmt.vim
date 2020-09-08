" beanworks/vim-phpfmt: PHP (phpcbf) auto format plugin for vim
" https://github.com/beanworks/vim-phpfmt

let g:phpfmt_command = expand('~/.composer/vendor/bin/phpcbf')
let g:phpfmt_autosave = 0
let g:phpfmt_tmp_dir = '/tmp/phpcbf'
" let g:phpfmt_standard = 'WordPress-Core'
" let g:phpfmt_options = '--standard=WordPress-Core --encoding=utf-8'
