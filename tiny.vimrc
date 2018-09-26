" encoding and color {{{1
if has('vim_starting')
    set encoding=utf-8
    scriptencoding utf-8
endif


" Vars:   "{{{1

let s:is_mac      = has('macunix') || (executable('uname') && system('uname') =~? '^darwin')
let s:is_unix     = has('unix') && !s:is_mac
let s:is_win      = has('win32') || has('win64')
let s:tidy_cmd    = ''


" global vars  "{{{2
let $MY_VIMRUNTIME = expand(s:is_win ? '~/vimfiles' : '~/.vim')

let g:oppara_email = 'oppara <oppara _at_ oppara.tv>'
let g:snips_author = g:oppara_email
let g:changelog_username = 'oppara'

let mapleader = ','
let g:mapleader = ','




" Options:   "{{{1


" encoding  "{{{2

language C

if ( s:is_mac || s:is_unix )
    set termencoding=utf-8
endif

if has('kaoriya') && has('gui_macvim')
  let did_encoding_settings = 1
endif

if !exists('did_encoding_settings') "{{{3

  if &encoding !=# 'utf-8'
    set encoding=japan
    set fileencoding=japan
  endif

  if has('iconv') "{{{4

    let s:enc_euc = 'euc-jp'
    let s:enc_jis = 'iso-2022-jp'
    " iconvがeucJP-msに対応しているかをチェック
    if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
      let s:enc_euc = 'eucjp-ms'
      let s:enc_jis = 'iso-2022-jp-3'
      " iconvがJISX0213に対応しているかをチェック
    elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
      let s:enc_euc = 'euc-jisx0213'
      let s:enc_jis = 'iso-2022-jp-3'
    endif

    " fileencodingsを構築
    if &encoding ==# 'utf-8'

      let s:fileencodings_default = &fileencodings
      let &fileencodings = s:enc_jis .','. s:enc_euc

      if s:fileencodings_default =~ 'utf-8'
        let &fileencodings = &fileencodings .','. s:fileencodings_default
        let &fileencodings = substitute(&fileencodings, "utf-8", "utf-8,cp932", "g")
      else
        let &fileencodings = &fileencodings .',cp932,'. s:fileencodings_default
      endif
      unlet s:fileencodings_default

    else
      let &fileencodings = &fileencodings .','. s:enc_jis
      set fileencodings+=utf-8,ucs-2le,ucs-2
      if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
        set fileencodings+=cp932
        set fileencodings-=euc-jp
        set fileencodings-=euc-jisx0213
        set fileencodings-=eucjp-ms
        let &encoding = s:enc_euc
        let &fileencoding = s:enc_euc
      else
        let &fileencodings = &fileencodings .','. s:enc_euc
      endif
    endif

    unlet s:enc_euc
    unlet s:enc_jis

  else "{{{4
    set fileencodings=utf-8,cp932,euc-jp,iso-2022-jp
    let &fileencodings = 'ucs-bom,iso-2022-jp-3,ucs-2le,ucs-2,' .
          \ ((&encoding ==# 'utf-8') ? 'cp932,euc-jisx0213,euc-jp' :
          \  (&encoding ==# 'cp932') ? 'utf-8,euc-jisx0213,euc-jp' :
          \                            'utf-8,cp932'                ) " 'euc-jp' 'euc-jisx0213'
  endif "}}}

  let did_encoding_settings = 1
endif
" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif


" line feed "{{{2

set fileformats=unix,dos,mac


" highlight  "{{{2


" colorscheme  "{{{2

syntax enable
set background=dark
set synmaxcol=300

if 200 < &t_Co || &term ==# 'screen-bce' || &term ==# 'screen'
    set t_Co=256
endif


" tab, indent  "{{{2

set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
set smarttab
set autoindent
set smartindent


" search  "{{{2

set magic
set hlsearch
set ignorecase
set smartcase
set incsearch
set wrapscan
set grepprg=internal


" file & buffer  "{{{2

set history=400
set nobackup
set nowritebackup
set noswapfile
set directory-=.
set viminfo='100,<100,:50,%,h,n~/.viminfo


" view  "{{{2

set viewoptions-=options viewoptions+=slash,unix


" tags "{{{3
set tags=./tags;,tags;

" buffer "{{{3
set hidden
set autoread


" input support "{{{2

set virtualedit+=block
set backspace=eol,start,indent
set formatoptions+=m
set whichwrap=b,s,h,l,<,>,[,]
set startofline
" set iminsert=0 imsearch=0
set clipboard+=unnamed


" comletion  "{{{2

setlocal completeopt=menuone,preview
setlocal complete=.,w,b,u,k,i " help cpt
" setlocal completefunc=syntaxcomplete#Complete

set wildmenu
set wildmode=list:longest,full


" display "{{{2

set nonumber
set noruler
set showmatch
set showcmd
set showmode
set lazyredraw
set ttyfast
set ambiwidth=double
set scrolloff=10000
set wrap

" list "{{{3
set list
set listchars=tab:»_,extends:»,precedes:«

" fold "{{{3
set foldenable
set foldlevel=0
set foldmethod=marker


" statusline  "{{{2

set cmdheight=2
set laststatus=2
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']['.&ft.']'}%=%l,%c%V%8P


" scroll  "{{{2
" http://d.hatena.ne.jp/hyuki/20131206/vim
set scrolloff=3




" Mapping:  "{{{1


" prefix "{{{2

" http://d.hatena.ne.jp/kuhukuhun/20090213/1234522785
nmap mapleader [Leader]
nnoremap [Leader] <Nop>

nmap t [Tag]
nnoremap [Tag] <Nop>

nmap q [Quickfix]
nnoremap [Quickfix] <Nop>


" <C-Space> "{{{2

if (s:is_mac || s:is_unix) && !has('gui_running')
  map <NUL> <C-Space>
  map! <NUL> <C-Space>
endif


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

" http://vim-users.jp/2011/04/hack214/
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

nnoremap <C-j> <esc>
vnoremap <C-j> <esc>
inoremap <c-j> <esc>
snoremap <c-j> <esc>


" save "{{{2

nnoremap <leader><leader> :<C-u>call <SID>my_update()<cr>
" noremap <leader><leader> <esc>:<C-u>call <SID>my_update()<cr>
function! s:my_update()
  normal mx
  up
  normal `x
  delmarks x
endfunction


" vimrc  "{{{2

" edit
nnoremap <leader>ev :sp $HOME/.vimrc<cr>


" update helptag  "{{{2

nnoremap <leader>ht :helptags $MY_VIMRUNTIME/doc<cr>:helptags  $MY_VIMRUNTIME/bundle/vundle/doc<cr>


" iminsert  "{{{2

" http://www.ac.cyberhome.ne.jp/~yakahaira/vimdoc/options.html#'iminsert'
" コマンド <Esc> でInsertモードを終える度に値を 0 に戻すには以下。
inoremap <silent> <esc> <esc>:set iminsert=0<cr>
inoremap <silent> <c-j> <esc>:set iminsert=0<cr>


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

inoremap <C-a> <esc>^i
inoremap <C-f> <Right>
inoremap <C-e> <esc>A
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


" tag jump "{{{2

nnoremap [Tag]t  <C-]>           " jump
nnoremap [Tag]j  :<C-u>tag<cr>   " next
nnoremap [Tag]k  :<C-u>pop<cr>   " prev
nnoremap [Tag]l  :<C-u>tags<cr>  " list


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
set notagbsearch
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

" Autocmd:  "{{{1

augroup vimrc-avoid-jis  "{{{2
  autocmd!

  " 日本語を含まない場合にJISと解釈されるのを防ぐ  "{{{3
  autocmd BufReadPost *
        \   if &modifiable && !search('[^\x00-\x7F]', 'cnw') && &filetype != 'svn'
        \ |   setlocal fileencoding=
        \ | endif
augroup END


" Automatic rename of tmux window
" if exists('$TMUX') && !exists('$NORENAME')
if exists('$TMUX')
" if &term =~ "screen"
  augroup vimrc-screen
    autocmd!
    autocmd BufEnter * call system("tmux rename-window " . "'[" . expand("%:t") . "]'")
    autocmd VimLeave * call system("tmux set-window automatic-rename on")
    autocmd BufEnter * let &titlestring = ' ' . expand("%:t")
  augroup END
end


  autocmd!
  " 最後に編集した位置へカーソルを移動
  autocmd BufReadPost
        \ * if line("'\"") && line("'\"") <= line('$')
        \ |   execute 'normal! g`"'
        \ | endif

  " 辞書設定
  autocmd FileType
        \ * if filereadable(expand('~/.vim/dict/' . &l:filetype . '.dict'))
        \ |   let &l:dict = '~/.vim/dict/' . &l:filetype . '.dict'
        \ | endif

  " ファイルタイプ再設定
  autocmd BufWritePost
        \ * if &l:filetype ==# '' || exists('b:ftdetect')
        \ |   unlet! b:ftdetect
        \ |   filetype detect
        \ | endif
augroup END




" Vim Starting:  "{{{1
if has('vim_starting')
  " http://nanasi.jp/articles/vim/matchit_vim.html
  source $VIMRUNTIME/macros/matchit.vim
endif

" Use vsplit mode
if has("vim_starting") && !has("gui_running") && has("vertsplit")
  function! EnableVsplitMode()
    " enable origin mode and left/right margins
    let &t_CS = "y"
    let &t_ti = &t_ti . "\e[?6;69h"
    let &t_te = "\e[?6;69l\e[999H" . &t_te
    let &t_CV = "\e[%i%p1%d;%p2%ds"
    call writefile([ "\e[?6;69h" ], "/dev/tty", "a")
  endfunction

  " old vim does not ignore CPR
  map <special> <Esc>[3;9R <Nop>

  " new vim can't handle CPR with direct mapping
  " map <expr> ^[[3;3R EnableVsplitMode()
  set t_F9=[3;3R
  map <expr> <t_F9> EnableVsplitMode()
  let &t_RV .= "\e[?6;69h\e[1;3s\e[3;9H\e[6n\e[0;0s\e[?6;69l"
endif
