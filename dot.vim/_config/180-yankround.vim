" LeafCage/yankround.vim: logging registers and reusing them.
" https://github.com/LeafCage/yankround.vim

if empty(globpath(&rtp, 'autoload/yankround.vim'))
  finish
endif

nmap p <plug>(yankround-p)
xmap p <plug>(yankround-p)
nmap P <plug>(yankround-P)
nmap gp <plug>(yankround-gp)
xmap gp <plug>(yankround-gp)
nmap gP <plug>(yankround-gP)
nmap <c-p> <plug>(yankround-prev)
nmap <c-n> <plug>(yankround-next)

