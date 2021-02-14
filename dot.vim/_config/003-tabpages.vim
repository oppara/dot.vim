" tabpage "{{{1
set showtabline=2

nmap t [Tab]
nnoremap [Tab] <Nop>
nnoremap <silent> [Tab]n :tablast <bar> tabnew<CR>
nnoremap <silent> [Tab]c :tabclose<CR>
nnoremap <silent> [Tab]] :tabnext<CR>
nnoremap <silent> [Tab][ :tabprevious<CR>
nnoremap <silent> [Tab]t g<Tab><CR>
for n in range(1, 9)
  execute 'nnoremap <silent> [Tab]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor

