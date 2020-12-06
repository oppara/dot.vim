" vim-test/vim-test: Run your tests at the speed of thought
" https://github.com/vim-test/vim-test

if empty(globpath(&rtp, 'autoload/test.vim'))
  finish
endif

let test#strategy = 'vimterminal'

nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>
