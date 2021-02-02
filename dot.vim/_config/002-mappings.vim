" Mapping:  "{{{1

" prefix "{{{2

" http://d.hatena.ne.jp/kuhukuhun/20090213/1234522785
nmap mapleader [Leader]
nnoremap [Leader] <Nop>


nmap q [Quickfix]
nnoremap [Quickfix] <Nop>


" complete "{{{2

" 補完表示時にEnterを押しても改行せずに確定
inoremap <expr><cr>  pumvisible() ? "<c-y>" : "<cr>"
" c-n, c-p で補完候補を挿入せず、選択だけ行う
inoremap <expr><c-n> pumvisible() ? "<down>" : "<c-n>"
inoremap <expr><c-p> pumvisible() ? "<up>" : "<c-p>"


" <C-Space> "{{{2

" if (g:is_mac || g:is_unix) && !has('gui_running')
  " map <NUL> <C-Space>
  " map! <NUL> <C-Space>
" endif



" set list, number, paste toggle "{{{2

noremap <silent> sl :set list!<CR>
noremap <silent> sm :set number!<CR>
" set pastetoggle=nv
noremap sv :<C-u>call <SID>my_paste_toggle()<CR>
function! s:my_paste_toggle()
  execute ':setlocal paste!'
  if (&paste)
      echo 'paste'
  else
      echo 'nopaste'
  endif
endfunction


" 最後に内容変更したカーソル位置へジャンプ
nnoremap gb `.zz



" 文単位モーションの(や)の使用をやめる  "{{{2

" https://vim-jp.org/vim-users-jp/2011/04/21/Hack-214.html
onoremap ) t)
onoremap ( t(
onoremap ; t;
onoremap < t<
onoremap > t>
onoremap [ t[
onoremap ] t]
vnoremap ) t)
vnoremap ( t(
vnoremap [ t[
vnoremap ] t]


" highlight ZenkakuSpace  "{{{2

nnoremap <silent> <leader>mz :highlight ZenkakuSpace ctermbg=red  ctermfg=red guibg=red  guifg=red<cr>


" to normal mode  "{{{2

nnoremap <C-j> <Esc>
vnoremap <C-j> <Esc>
inoremap <C-j> <Esc>
snoremap <C-j> <Esc>


" save "{{{2

nnoremap <leader><leader> :<C-u>call <SID>my_update()<cr>
" noremap <leader><leader> <Esc>:<C-u>call <SID>my_update()<cr>
function! s:my_update()
  normal mx
  up
  normal `x
  delmarks x
endfunction



" update helptag  "{{{2

nnoremap <leader>ht :helptags $MY_VIMRUNTIME/doc<cr>:helptags  $MY_VIMRUNTIME/bundle/vundle/doc<cr>


" iminsert  "{{{2

" http://www.ac.cyberhome.ne.jp/~yakahaira/vimdoc/options.html#'iminsert'
" コマンド <Esc> でInsertモードを終える度に値を 0 に戻すには以下。
inoremap <silent> <Esc> <Esc>:set iminsert=0<cr>
inoremap <silent> <c-j> <Esc>:set iminsert=0<cr>


" search  "{{{2

" ずっとハイライトはうざい
" nnoremap <silent> gh :let @/=''<cr>
nnoremap <silent> gh :<C-u>call <SID>my_hlsearch_toggle()<CR>
function! s:my_hlsearch_toggle()
  if (&hlsearch)
    execute ':setlocal nohlsearch'
  else
    execute ':setlocal hlsearch'
  endif
endfunction

" 検索結果をquickfixに表示
" http://subtech.g.hatena.ne.jp/secondlife/20070601/1180700503
nnoremap  q/ :exec ':vimgrep /' . getreg('/') . '/j %\|cwin'<cr>
" nnoremap <unique> q/ :exec ':vimgrep /' . getreg('/') . '/j %\|cwin'<cr>


" wrap "{{{2

nnoremap <leader>ow
\  :<C-u>setlocal wrap!
\ \|     setlocal wrap?<cr>

" nnoremap ep :set invpaste<cr>


" visual mode "{{{2

" 最後に変更されたテキストを選択する
" gvで最後にVisual modeで選択された領域を再度選択できる
nnoremap gc  `[v`]
vnoremap gc :<C-u>normal gc<CR>
onoremap gc :<C-u>normal gc<CR>

" ビジュアルモード時vで行末まで選択
vnoremap v $h

" like screen
vnoremap <space> y

" >,<実行後も選択状態を維持
vnoremap > >gv
vnoremap < <gv


" folding "{{{2

" http://d.hatena.ne.jp/ns9tks/searchdiary?word=folding
" 行頭で h を押すと折畳を閉じる。
nnoremap <expr> h col('.') == 1 && foldlevel(line('.')) > 0 ? 'zc' : 'h'
" 折畳上で l を押すと折畳を開く。
nnoremap <expr> l foldclosed(line('.')) != -1 ? 'zo0' : 'l'
" 行頭で h を押すと選択範囲に含まれる折畳を閉じる。
vnoremap <expr> h col('.') == 1 && foldlevel(line('.')) > 0 ? 'zcgv' : 'h'
" 折畳上で l を押すと選択範囲に含まれる折畳を開く。
vnoremap <expr> l foldclosed(line('.')) != -1 ? 'zogv0' : 'l'


" select mode "{{{2

smap h h
smap l l
smap v v


" registers, marks "{{{2

" レジスタ/マークの確認
nnoremap <leader>sm  :<C-u>marks<cr>
nnoremap <leader>sr  :<C-u>registers<cr>


" move "{{{2

nnoremap 0 ^
nnoremap j gj
nnoremap k gk
nnoremap <tab> %
vnoremap <tab> %
" 最後の編集位置へ戻る
noremap gb `.zz
" 編集位置を遡る
noremap <C-g> g;


" emacs like C-a C-e C-f C-b "{{{2

inoremap <C-a> <Esc>^i
inoremap <C-f> <Right>
inoremap <C-e> <Esc>A
inoremap <C-b> <Left>
inoremap <C-D>  <Del>

cnoremap <C-A>    <Home>
cnoremap <C-E>    <End>


" command mode "{{{2

" expand path
cnoremap <c-x> <c-r>=expand('%:p:h')<cr>/
" expand file (not ext)
cnoremap <c-z> <c-r>=expand('%:p:r')<cr>


" 現在使用中のバッファの表示 "{{{2

nnoremap bb :ls<cr>:buffer


" カーソル下の単語を最後にヤンクしたテキストで置き換え "{{{2

nnoremap yp wbdiw"0P


" encoding & fileformat "{{{2

" エンコーディングの切り替え
nnoremap <silent> eu :setlocal fileencoding=utf-8<cr>
nnoremap <silent> ee :setlocal fileencoding=euc-jp<cr>
nnoremap <silent> es :setlocal fileencoding=cp932<cr>
nnoremap <silent> el :setlocal fileencoding=utf-16le<cr>

" エンコーディングを指定して再オープン
nnoremap <silent> reu :e ++enc=utf-8 %<cr>
nnoremap <silent> ree :e ++enc=euc-jp %<cr>
nnoremap <silent> res :e ++enc=cp932 %<cr>
nnoremap <silent> rel :e ++enc=utf-16le %<cr>

" 改行切り替え
nnoremap <silent>ffd :setlocal fileformat=dos<cr>
nnoremap <silent>ffu :setlocal fileformat=unix<cr>
" nnoremap <silent>ffm :setlocal fileformat=mac<cr>


" tab "{{{2

" shiftwidth
nnoremap <leader>t2 :setlocal shiftwidth=2<cr>
nnoremap <leader>t4 :setlocal shiftwidth=4<cr>

" tab to space
noremap <Leader>rt :%retab!<cr>


" 日付 "{{{2

inoremap <Leader>df  <C-r>=strftime('%Y-%m-%d %H:%M:%S')<Return>
inoremap <Leader>dd  <C-r>=strftime('%Y-%m-%d')<Return>


" recording "{{{2

nnoremap Q q





"Remove the Windows ^M "{{{2

noremap <Leader>rw mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm


"Remove indenting on empty lines "{{{2

noremap <Leader>ri :%s/\s*$//g<cr>:noh<cr>''


" xterm pastes "{{{2
if &term =~ "xterm"|| &term ==# 'screen-bce' || &term ==# 'screen'
    let &t_SI .= "\e[?2004h"
    let &t_EI .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function! XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif

" tag "{{{2

nmap t [Tag]
nnoremap [Tag] <Nop>

nnoremap [Tag]t  <C-]>           " jump
nnoremap [Tag]j  :<C-u>tag<cr>   " next
nnoremap [Tag]k  :<C-u>pop<cr>   " prev
nnoremap [Tag]l  :<C-u>tags<cr>  " list

" tagsジャンプの時に複数ある時は一覧表示
nnoremap <C-]> g<C-]>
" noremap <silent> <C-]> :<C-u>Unite tag:<C-r>=expand('<cword>')<CR><CR>
" noremap <silent> <C-]> :<C-u>Unite -immediately -no-start-insert tag:<C-r>=expand('<cword>')<CR><CR>

" [tag jump] カーソルの単語の定義先にジャンプ（複数候補はリスト表示）
nnoremap tj :exe("tjump ".expand('<cword>'))<CR>

" [tag back] tag stack を戻る -> tp(tag pop)よりもtbの方がしっくりきた
nnoremap tb :pop<CR>

" [tag next] tag stack を進む
nnoremap tn :tag<CR>

" [tag vertical] 縦にウィンドウを分割してジャンプ
nnoremap tv :vsp<CR> :exe("tjump ".expand('<cword>'))<CR>

" [tag horizon] 横にウィンドウを分割してジャンプ
nnoremap th :split<CR> :exe("tjump ".expand('<cword>'))<CR>

" " [tag tab] 新しいタブでジャンプ
" nnoremap tt :tab sp<CR> :exe("tjump ".expand('<cword>'))<CR>

" [tags list] tag list を表示
nnoremap tl :ts<CR>


" sudo で保存 "{{{2
cabbr w!! w !sudo tee > /dev/null %


" vimrc 関連  "{{{2

" edit
nmap <silent> <plug>(my-edit-vimrc) :sp $MYVIMRC<cr>
nmap <leader><leader>e <plug>(my-edit-vimrc)
nmap <leader>ev <plug>(my-edit-vimrc)

" reload
nmap <silent> <plug>(my-reload-vimrc) :<c-u>call <sid>reload_vimrc()<cr>
nmap <leader>sv <plug>(my-reload-vimrc)
if has('vim_starting')
  function! s:reload_vimrc() abort
    let m = ['vimrc']
    execute printf('source %s', $MYVIMRC)
    if has('gui_running')
      execute printf('source %s', $MYGVIMRC)
      call add(m, 'gvimrc')
    endif
    redraw
    echo printf('%s has reloaded (%s).', join(m, ' & '), strftime('%c'))
  endfunctio
endif


" filetype & syntax change "{{{2
nnoremap <silent><leader>1 :setlocal filetype=html syntax=html<CR>
nnoremap <silent><leader>2 :setlocal filetype=css syntax=css<CR>
nnoremap <silent><leader>3 :setlocal filetype=javascript syntax=javascript<CR>
nnoremap <silent><leader>4 :setlocal filetype=php syntax=php<CR>


" コマンドライン履歴 "{{{2
" https://twitter.com/thinca/status/1333425555866333187
cnoremap <C-p> <Up>
