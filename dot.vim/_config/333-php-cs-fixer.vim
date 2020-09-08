" stephpy/vim-php-cs-fixer: Use FriendsOfPHP/PHP-CS-Fixer
" https://github.com/stephpy/vim-php-cs-fixer

let g:php_cs_fixer_config_file = expand('~/.config/php/php_cs.dist')
let g:php_cs_fixer_enable_default_mapping = 0
let g:php_cs_fixer_dry_run = 0
let g:php_cs_fixer_verbose = 0
let g:php_cs_fixer_command = '--using-cache=no'
