" tyru/open-browser.vim: Open URI with your favorite browser from your most favorite editor
" https://github.com/tyru/open-browser.vim

if empty(globpath(&rtp, 'autoload/openbrowser.vim'))
  finish
endif

nmap <leader>w <plug>(openbrowser-smart-search)
