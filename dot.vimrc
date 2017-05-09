scriptencoding utf-8

" Vars:   "{{{1

let s:is_mac      = has('macunix') || (executable('uname') && system('uname') =~? '^darwin')
let s:is_unix     = has('unix') && !s:is_mac
let s:is_win      = has('win32') || has('win64')
let s:tidy_cmd    = ''
let s:dropbox_dir     = expand ('~/Dropbox')


" global vars  "{{{2

let g:oppara_email = 'oppara <oppara _at_ oppara.tv>'
let g:snips_author = g:oppara_email
let g:changelog_username = 'oppara'

let mapleader = ','
let g:mapleader = ','

" vim-plug: "{{{1
"
if has("vim_starting")
  let $MY_VIMRUNTIME = expand(s:is_win ? '~/vimfiles' : '~/.vim')
  let g:plug_dir =  $MY_VIMRUNTIME . '/plugged'
  let g:plug_repo_dir =  g:plug_dir . '/vim-plug/autoload'
  execute 'set runtimepath^=' . fnamemodify(g:plug_repo_dir, ':h')
  if !isdirectory(expand(g:plug_repo_dir))
     execute '!git clone https://github.com/junegunn/vim-plug.git' g:plug_repo_dir
  endif
endif

call plug#begin(g:plug_dir)

  Plug 'junegunn/vim-plug', {'dir': g:plug_repo_dir}

  Plug 'vim-jp/vimdoc-ja'

  Plug 'itchyny/lightline.vim'
  Plug 'Shougo/vimproc.vim', {'do': 'make'}

  Plug 'clones/vim-l9'
  Plug 'clones/vim-autocomplpop'
  Plug 'clones/vim-fuzzyfinder', {'on': ['FufFile', 'FufBuffer', 'FufMruFile', 'FufDir', 'FufBookmark', 'FufAddBookmark']}

  Plug 'Shougo/unite.vim', {'on': ['Unite', 'UniteWithBufferDir'], 'for': ['unite']}
  Plug 'Shougo/unite-help', {'on': ['Unite'] }
  Plug 'Shougo/unite-outline', {'on': ['Unite']}

  Plug 'oppara/snipmate.vim'
  Plug 'majutsushi/tagbar'

  Plug 'LeafCage/yankround.vim'
  Plug 'thinca/vim-localrc'
  Plug 'thinca/vim-qfreplace'

  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-abolish'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-fugitive'

  Plug 'scrooloose/nerdcommenter'
  Plug 'vim-scripts/sudo.vim'
  Plug 'vim-scripts/matchit.zip'
  Plug 'vim-scripts/MatchTag'

  Plug 'Yggdroot/indentLine'
  " Plug 'rhysd/migemo-search.vim'
  " if executable('cmigemo')
    " cnoremap <expr><CR> migemosearch#replace_search_word()."\<CR>"
  " endif

  Plug 'fuenor/qfixgrep'
  Plug 'nazo/pt.vim'

  Plug 'mattn/vim-maketable'

  Plug 'jiangmiao/auto-pairs'

  Plug 'kana/vim-fakeclip', {'on':  ['<Plug>(fakeclip-']}
  Plug 'kana/vim-smartchr'

  Plug 'thinca/vim-quickrun', {'on': ['QuickRun', '<Plug>(quickrun']}

  Plug 'kana/vim-textobj-user'
  Plug 'kana/vim-textobj-jabraces', {'on': ['TextobjJabracesDefaultKeyMappings']}
  Plug 'kana/vim-textobj-fold', {'on': ['TextobjFoldDefaultKeyMappings']}
  Plug 'anyakichi/vim-textobj-ifdef', {'on': ['TextobjIfdefDefaultKeyMappings']}
  Plug 'akiyan/vim-textobj-php', {'for': ['php']}
  Plug 'bps/vim-textobj-python', {'for': ['python']}
  Plug 'rhysd/vim-textobj-ruby', {'for': ['ruby']}
  Plug 'akiyan/vim-textobj-xml-attribute', {'for': ['xml']}

  Plug 'scrooloose/syntastic'
  Plug 'junegunn/vim-easy-align', {'on': ['EasyAlign']}
  Plug 'anyakichi/vim-qfutil', {'on': ['QFGrep', 'QFMake']}

  Plug 'tyru/open-browser.vim'

  Plug 'sheerun/vim-polyglot'

  Plug 'oppara/php-doc-modded', {'branch': 'develop', 'for': ['php']}

" " http://www.karakaram.com/vim/phpunit-location-list/
  Plug 'karakaram/vim-quickrun-phpunit', {'for': ['php']}
  Plug 'vim-scripts/phpfolding.vim', {'for': ['php']}
  Plug 'beanworks/vim-phpfmt', {'for': ['php']}

  Plug 'oppara/sql_iabbr.vim', {'for': ['sql']}

  Plug 'kannokanno/previm', {'for': ['markdown']}
  Plug 'rhysd/vim-gfm-syntax'

  Plug 'mattn/emmet-vim', {'for': ['html', 'xhtml', 'xml', 'css', 'less', 'sass', 'scss', 'slim', 'haml', 'jade', 'php']}

  Plug 'hokaccha/vim-html5validator', {'for': ['html']}

  Plug 'hail2u/vim-css3-syntax', {'for': ['css']}

  Plug 'tpope/vim-endwise', {'for': ['ruby']}

  Plug 'heavenshell/vim-jsdoc', {'for': ['javascript']}
  Plug 'mattn/jscomplete-vim', {'for': ['javascript']}
  Plug 'igetgames/vim-backbone-jscomplete', {'for': ['javascript']}
  Plug 'myhere/vim-nodejs-complete', {'for': ['javascript', 'node']}
  Plug 'maksimr/vim-jsbeautify', {'for': ['javascript', 'json']}
  Plug 'oppara/vim-jquery', {'for': ['javascript']}
  Plug 'pmsorhaindo/syntastic-local-eslint.vim', {'for': ['javascript']}

  Plug 'msanders/cocoa.vim', {'for': ['cocoa']}

call plug#end()



filetype plugin indent on





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

augroup vimrc-color
  autocmd!
  autocmd ColorScheme * call s:onColorScheme()
  autocmd VimEnter,WinEnter * call matchadd('ZenkakuSpace', '　')

  function! s:onColorScheme()
    if !exists('g:colors_name')
      return
    endif

    highlight ZenkakuSpace ctermbg=Red ctermfg=Red guibg=Red

    if g:colors_name !~? '^wombat'
      highlight Pmenu ctermbg=black
      highlight PmenuSel ctermfg=black ctermbg=white
      highlight PmenuSbar ctermbg=0
    endif
  endfunction
augroup END



" colorscheme  "{{{2

syntax enable
set background=dark

if 200 < &t_Co || &term ==# 'screen-bce' || &term ==# 'screen'
    set t_Co=256
    colorscheme wombat256opp
else
    colorscheme delek
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
set tags=+../../**/tags
set tags=+tags;

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
set listchars=tab:^_,extends:\

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


" tab

" shiftwidth "{{{2
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



" Autocmd:  "{{{1

augroup vimrc-rtrim  "{{{2
  autocmd!
  " 保存時に行末の空白を除去する
  autocmd BufWritePre * call s:rtrim()

  function! s:rtrim()
    let s:cursor = getpos(".")
    if stridx(&filetype, 'markdown') == 0
      %s/\s\+\(\s\{2}\)$/\1/e
      call s:set_markdown_trailing_space_highlight()
    else
      %s/\s\+$//e
    endif
    call setpos(".", s:cursor)
  endfunction

  function! s:set_markdown_trailing_space_highlight()
    match Underlined /\s\{2}$/
    highlight Underlined ctermbg=black ctermfg=red guibg=black guifg=red
  endfunction
augroup END

augroup vimrc-avoid-jis  "{{{2
  autocmd!
  " 日本語を含まない場合にJISと解釈されるのを防ぐ  "{{{3
  autocmd BufReadPost *
        \   if &modifiable && !search('[^\x00-\x7F]', 'cnw') && &filetype != 'svn'
        \ |   setlocal fileencoding=
        \ | endif
augroup END


" Automatic rename of tmux window
if exists('$TMUX') && !exists('$NORENAME')
" if &term =~ "screen"
  augroup vimrc-screen
    autocmd!
    autocmd BufEnter *
          \ if bufname("") !~ "^\[A-Za-z0-9\]*://" && bufname("") !~ "^["
          \ | silent! exe '!echo -n "k[`basename %`]\\"'
          \ | endif
    autocmd VimLeave * call system('tmux set-window automatic-rename on')
    " autocmd VimLeave *
          " \ silent! exe '!echo -n "k`dirs`\\"'
  augroup END
end

augroup vimrc-view  "{{{2
  autocmd!
  " 状態の保存と復元
  " http://vim-users.jp/2009/10/hack84/
  autocmd BufLeave * if expand('%') !=# '' && &buftype ==# '' | mkview | endif
  autocmd BufReadPost * if !exists('b:view_loaded') &&
        \  expand('%') !=# '' && &buftype ==# ''
        \  | silent! loadview
        \  | let b:view_loaded = 1
        \  | endif
  autocmd VimLeave * call map(split(glob(&viewdir . '/*'), "\n"), 'delete(v:val)')

augroup END

augroup vimrc-quicklook-fix  "{{{2
  autocmd!
  " http://d.hatena.ne.jp/uasi/20110523/1306079612
  autocmd BufWritePost * call s:set_utf8_xattr(expand("<afile>"))

  function! s:set_utf8_xattr(file)
    let isutf8 = &fileencoding == "utf-8" || ( &fileencoding == "" && &encoding == "utf-8")
    if s:is_mac && isutf8
      call system("xattr -w com.apple.TextEncoding 'utf-8;134217984' '" . a:file . "'")
    endif
  endfunction
augroup END

augroup vimrc-cursorline  "{{{2
  autocmd!
  autocmd VimEnter * setlocal cursorline
  autocmd WinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END

augroup vimrc-lcd  "{{{2
  autocmd!
  " 現在編集中のバッファのディレクトリに移動する  "{{{3
  autocmd BufReadPre,BufFilePre * unlet! b:lcd
  autocmd BufReadPost,BufFilePost,BufEnter * call s:lcd()

  function! s:lcd()
    if &l:buftype !=# '' && &l:buftype !=# 'help' ||
    \   0 <= index(['unite', 'vimfiler'], &l:filetype)
      unlet! b:lcd
      return
    endif

    if exists('b:lcd') &&
    \  (b:lcd ==# '' || getcwd() =~# '^\V' . escape(b:lcd, '\') . '\$')
      return
    endif

    let path = s:lcd_path()
    if isdirectory(path)
      lcd `=path`
      let b:lcd = getcwd()
    endif
  endfunction

  function! s:lcd_path()
    let path = ''
    let simple = expand('%:p:h')

    if &l:buftype ==# 'help'
      return simple
    endif

    let tf = tagfiles()
    if !empty(tf)
      let tagdir = fnamemodify(tf[0], ':p:h')
      if tagdir !=# '' && simple[ : len(tagdir) - 1] ==# tagdir
        return tagdir
      endif
    endif

    let base = substitute(expand('%:p'), '\\', '/', 'g')
    " for dir in ['src', 'include']
      " let pat = '/' . dir . '/'
      " if base =~# pat
        " let path = base[: strridx(base, pat) + len(dir)]
      " endif
    " endfor
    if path !=# ''
      return path
    endif

    " リポジトリのルートには移動しない
    " let base = simple
    " let dirs = ['.svn', '.git', '.bzr', '.hg']
    " if &l:filetype =~# '^\%(vim\|help\)$'
      " call add(dirs, 'doc')
    " endif
    " for d in dirs
      " let d = finddir(d, escape(base, ' ?*[]();') . ';')
      " if d !=# ''
        " let p = fnamemodify(d, ':p:h:h')
        " if strlen(path) < strlen(p)
          " let path = p
        " endif
      " endif
    " endfor
    " if path !=# ''
      " return path
    " endif

    return simple
  endfunction
augroup END

augroup vimrc-quickfix  "{{{2
  autocmd!
  " Quickfixを自動で閉じる
  " http://hail2u.net/blog/software/vim-auto-close-quickfix-window.html
  autocmd WinEnter * if (winnr('$') == 1) && (getbufvar(winbufnr(0), '&buftype')) == 'quickfix' | quit | endif

  " Quickfixを自動で開く
  " http://www.sopht.jp/blog/index.php?/archives/458-Quickfix-utility-for-Vim.html
  autocmd QuickFixCmdPost [^l]* cwindow
  autocmd QuickFixCmdPost l* lwindow

  autocmd QuickfixCmdPost grep,grepadd,vimgrep copen
  autocmd QuickfixCmdPost make call s:do_post_quickfix_cmd()

  function! s:do_post_quickfix_cmd()
    if len(getqflist()) > 0
      cw
    else
      cclose
    endif
  endfunction
augroup END

augroup vimrc-misc  "{{{2
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



" FileType:  "{{{1

augroup vimrc-ft
  autocmd!
  autocmd FileType * setlocal complete=.,w,b,u,t
  autocmd FileType * let s:tidy_cmd = ''
  autocmd FileType * inoremap <buffer> >  >

  " http://vim-users.jp/2009/11/hack96/
  autocmd FileType *
        \  if &l:omnifunc == ''
        \|   setlocal omnifunc=syntaxcomplete#Complete
        \| endif
augroup END

augroup vimrc-ft-snippet  "{{{2
  autocmd!
  autocmd BufRead,BufNew *snip :setlocal filetype=snippet
augroup END


" " git.vim  "{{{2
" " https://github.com/tpope/vim-git/blob/master/ftplugin/git.vim
" " autocmd AfterPlugin BufRead *.git/COMMIT_EDITMSG DiffGitCached -p | wincmd p
" " autocmd AfterPlugin BufRead *.git/COMMIT_EDITMSG DiffGitCached -p | wincmd L
" " autocmd vimrc BufRead *.git/COMMIT_EDITMSG DiffGitCached -p | only | split | b 1

augroup vimrc-ft-gitrebase  "{{{2
  autocmd!
  " http://sssslide.com/speakerdeck.com/rhysd/do-you-know-about-vim-runtime-files
  autocmd FileType gitrebase nnoremap <buffer>e :<C-u>Edit<CR>
  autocmd FileType gitrebase nnoremap <buffer>s :<C-u>Squash<CR>
  autocmd FileType gitrebase nnoremap <buffer>f :<C-u>Fixup<CR>
  autocmd FileType gitrebase nnoremap <buffer>r :<C-u>Reword<CR>
augroup END

augroup vimrc-ft-vim  "{{{2
  autocmd!
  " autocmd BufWritePost dot.vimrc,.vimrc nested if expand('%') !~ 'fugitive' | source % | endif
  autocmd FileType vim setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
        \| nnoremap <leader>sv :source %<CR>
        \| setlocal keywordprg=:help
augroup END

augroup vimrc-ft-php  "{{{2
  autocmd!
  " autocmd FileType php call s:set_php4_syntax_check()
  function! s:set_php4_syntax_check()
    let l:version =  system('php -v|xargs|cut -d " " -f 2|cut -d "." -f 1')
    if l:version == 4
      compiler php
      autocmd BufWritePost * silent make % | redraw!
    endif
  endfunction

  " cakephp template
  autocmd BufRead,BufNew *thtml :setlocal filetype=php
  autocmd BufRead,BufNew *ctp :setlocal filetype=php

  autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
  autocmd FileType php setlocal expandtab tabstop=4 softtabstop=4 shiftwidth=4
        \| setlocal omnifunc=phpcomplete#CompletePHP
        \| setlocal iskeyword-=-
        \| setlocal keywordprg=:help
        \| setlocal commentstring=//%s
        \| setlocal dictionary+=$MY_VIMRUNTIME/dict/php.dict
        \| setlocal complete-=i
        \| setlocal complete+=k$MY_VIMRUNTIME/dict/php.dict

  autocmd BufRead,BufNew *ctp :setlocal  expandtab tabstop=2 softtabstop=2 shiftwidth=2

  " 辞書作成
  " php -r '$f=get_defined_functions();echo join("\n",$f["internal"]);' | sort > ~/.vim/dict/php.dict

  " surround.vim
  autocmd FileType php let b:surround_{char2nr('e')} = "<?php echo \r; ?>"
        \| let b:surround_{char2nr('p')} = "<?php \r; ?>"
        \| let b:surround_{char2nr('i')} = "__('\r');"
        \| let b:surround_{char2nr('I')} = "<?php echo __('\r'); ?>"
        \| nmap g' cs'g
        \| nmap G' cs'G

  autocmd FileType php nnoremap <silent><buffer><leader>ti :PhpFmt<cr>

  autocmd FileType php nnoremap <buffer>ef :EnableFastPHPFolds<cr>

  autocmd FileType php,blade inoremap <buffer><expr> > smartchr#one_of('>', '->', '=>', '>>')
  autocmd FileType blade let b:surround_{char2nr('e')} = "{{ \r }}"
        \| let b:surround_{char2nr('p')} = "{!! \r !!}"
        \| highlight PreProc ctermfg=250  ctermbg=none

  " php-doc-modded
  autocmd FileType php nnoremap <buffer><leader>d :call PhpDocSingle()<cr>bcw
  autocmd FileType php vnoremap <buffer><leader>d :call PhpDocRange()<cr>
  autocmd FileType php let g:pdv_cfg_Author = g:oppara_email
        \| let g:pdv_cfg_autoEndFunction = 0
        \| let g:pdv_cfg_autoEndClass = 0
        \| let g:pdv_cfg_Version = ''
        \| let g:pdv_cfg_Copyright = ''
        \| let g:pdv_cfg_License = ''

  " https://github.com/StanAngeloff/php.vim
  function! PhpSyntaxOverride()
    hi! def link phpDocTags  phpDefine
    hi! def link phpDocParam phpType
  endfunction
  autocmd FileType php call PhpSyntaxOverride()

augroup END

augroup vimrc-ft-perl  "{{{2
  autocmd!
  autocmd FileType perl setlocal expandtab softtabstop=4 shiftwidth=4
  autocmd FileType perl let s:tidy_cmd = "perltidy -q -st"
  autocmd FileType perl nnoremap <silent><buffer><leader>ti :Tidy<cr>
  autocmd FileType perl vnoremap <silent><buffer><leader>ti <Nop>
  autocmd FileType perl  inoremap <buffer><expr> > smartchr#one_of('>', '->', '=>', '>>')
" autocmd FileType perl setlocal complete-=i | setlocal complete+=k~/.vim/dict/perl_functions.dict
augroup END

augroup vimrc-ft-ruby  "{{{2
  autocmd!
  autocmd FileType ruby setlocal expandtab softtabstop=2 shiftwidth=2
  autocmd FileType ruby  inoremap <buffer><expr> > smartchr#one_of('>', '->', '=>', '>>')
 " autocmd FileType ruby setlocal complete+=k~/.vim/dict/ruby.dict
augroup END

augroup vimrc-ft-slim  "{{{2
  autocmd!
  autocmd BufRead,BufNew *slim :setlocal filetype=slim
  autocmd FileType css setlocal expandtab softtabstop=2 shiftwidth=2
        \| setlocal omnifunc=htmlcomplete#CompleteTags
augroup END


augroup vimrc-ft-javascript  "{{{2
  autocmd!
  " jquery
  autocmd BufRead,BufNewFile jquery.*.js :setlocal filetype=javascript syntax=jquery

  autocmd FileType javascript setlocal expandtab softtabstop=2 shiftwidth=2
        \| setlocal foldmethod=marker
        \| setlocal omnifunc=javascriptcomplete#CompleteJS
        \| setlocal dictionary+=$MY_VIMRUNTIME/dict/javascript.dict
        \| setlocal complete+=k$MY_VIMRUNTIME/dict/javascript.dict

  autocmd FileType javascript inoremap <buffer><expr> > smartchr#one_of('>', '->', '=>', '>>')
  " tidy
  autocmd FileType javascript nnoremap <silent><buffer><leader>ti :call JsBeautify()<cr>
  " jsdoc
  autocmd FileType javascript nmap <silent> <leader>d <Plug>(jsdoc)
augroup END


augroup vimrc-ft-json  "{{{2
  autocmd!
  autocmd BufRead,BufNewFile *json :setlocal filetype=json syntax=json
  autocmd FileType json setlocal expandtab softtabstop=2 shiftwidth=2
        \| setlocal conceallevel=0
        \| setlocal foldmethod=syntax

  autocmd BufReadPost *json execute 'normal! zAgg'
  autocmd FileType json nnoremap <silent><buffer><leader>ti :call JsBeautify()<cr>
augroup END

augroup vimrc-ft-coffeescript  "{{{2
" https://github.com/kchmck/vim-coffee-script
  autocmd!
  " au BufWritePost *.coffee silent CoffeeMake! -b | cwindow | redraw!
  autocmd FileType coffee setlocal expandtab softtabstop=2 shiftwidth=2
        \| setlocal conceallevel=0
        \| setlocal foldmethod=syntax
augroup END

augroup vimrc-ft-html  "{{{2
  autocmd!
  autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  autocmd FileType html,xhtml,xml,xslt setlocal expandtab softtabstop=2 shiftwidth=2
  autocmd FileType html,xhtml :setlocal path+=$HOME.'Sites'
        \| :setlocal includeexpr=substitute(v:fname,'^\\/','','')
  autocmd FileType html,xhtml nnoremap <silent><buffer><leader>ti :call HtmlBeautify()<cr>

  " xmllintによる XMLの検証と整形
  " http://nanasi.jp/articles/others/xmllint.html
  autocmd FileType xml exe ":silent 1,$!xmllint --format --recover - 2>/dev/null"
augroup END


augroup vimrc-ft-python  "{{{2
  autocmd!
  autocmd FileType python setlocal expandtab softtabstop=2 shiftwidth=2
        \| setlocal omnifunc=pythoncomplete#Complete
        \| let python_highlight_numbers=1
        \| let python_highlight_builtins=1
        \| let python_highlight_space_errors=1
augroup ED


augroup vimrc-ft-css  "{{{2
  " http://d.hatena.ne.jp/secondlife/20060831/1157010796#20060831f1
  " http://subtech.g.hatena.ne.jp/antipop/20060831/1157024857
  autocmd!
  autocmd BufRead,BufNew *scss :setlocal filetype=css
  autocmd FileType css setlocal expandtab softtabstop=2 shiftwidth=2
        \| setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType css,scss nnoremap <silent><buffer><leader>ti :call CSSBeautify()<cr>
augroup END

augroup vimrc-ft-markdown  "{{{2
  autocmd!
  autocmd BufRead,BufNew *mkd, *.md, *markdown :setlocal filetype=markdown
  autocmd FileType markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType markdown set commentstring=<\!--\ %s\ -->
  autocmd FileType markdown nnoremap <silent><buffer><leader>r :PrevimOpen<CR>
  autocmd FileType markdown vnoremap <silent><buffer>ml :MyList -<CR>
  autocmd FileType markdown vnoremap <silent><buffer>mc :MyList - [ ]<CR>
  autocmd FileType markdown vnoremap <silent><buffer>mo :MyList 1.<CR>
  autocmd FileType markdown call s:set_markdown_trailing_space_highlight()
  " surround.vim
  autocmd FileType markdown let b:surround_{char2nr('l')} = "[](\r)"
augroup END

augroup vimrc-ft-sh  "{{{2
  autocmd!
  autocmd FileType sh setlocal expandtab softtabstop=2 shiftwidth=2
augroup END

augroup vimrc-ft-yaml  "{{{2
  autocmd!
  autocmd FileType yaml setlocal expandtab softtabstop=2 shiftwidth=2
augroup END

augroup vimrc-ft-svn  "{{{2
  autocmd!
  autocmd FileType svn setlocal fileencoding=utf-8
augroup END

augroup vimrc-ft-gitignore  "{{{2
  autocmd!
  autocmd BufRead,BufNew .gitignore :setlocal filetype=conf
augroup END



" Function:  "{{{1

" :MyList "{{{2
command! -range=% -buffer -nargs=? MyList call s:my_list(<line1>, <line2>, <q-args>)
function! s:my_list(line1, line2, arg)
  let currentLine = a:line1
  while currentLine <= a:line2
    let theLine = getline(currentLine)
    let theLine = a:arg . ' ' . theLine
    call setline(currentLine, theLine)

    let currentLine = currentLine + 1
  endwhile
endfunction


" :Scratch "{{{2

command! -nargs=0 Scratch new | setlocal bt=nofile noswf | let b:cmdex_scratch = 1
function! s:CheckScratchWritten()
  if &buftype ==# 'nofile' && expand('%').'x' !=# 'x' && exists('b:cmdex_scratch') && b:cmdex_scratch == 1
    setlocal buftype= swapfile
    unlet b:cmdex_scratch
  endif
endfunction
augroup CmdexScratch
  autocmd!
  autocmd BufWritePost * call <SID>CheckScratchWritten()
augroup END


" 選択範囲をパターンにして検索 "{{{2
" @TODO visual star
" http://d.hatena.ne.jp/ns9tks/20080717/1216310786
function! s:SetSearch(text, is_word)
  let pattern = substitute(escape(a:text, '\'), '\n', '\\n', 'g')
  if a:is_word
    let @/ = '\C\V\<' . pattern . '\>'
  else
    let @/ = '\C\V' . pattern
  endif
  call histadd('/', pattern)
  set hlsearch
endfunction
vnoremap <silent> *  :<C-u>call <SID>SetSearch(<SID>SelectedText(), 1)<cr>
vnoremap <silent> g* :<C-u>call <SID>SetSearch(<SID>SelectedText(), 0)<cr>


" filetype & syntax change "{{{2

nnoremap <silent><leader>1 :setlocal filetype=xhtml syntax=xhtml<CR>
nnoremap <silent><leader>2 :setlocal filetype=css syntax=css<CR>
nnoremap <silent><leader>3 :setlocal filetype=javascript syntax=javascript<CR>
nnoremap <silent><leader>4 :setlocal filetype=php syntax=php<CR>


"function InsertTabWrapper() "{{{2
"    if pumvisible()
"        return "\<c-n>"
"    endif
"    let col = col('.') - 1
"    if !col || getline('.')[col - 1] !~ '\k\|<\|/'
"        return "\<tab>"
"    elseif exists('&omnifunc') && &omnifunc == ''
"        return "\<c-n>"
"    else
"        return "\<c-x>\<c-o>"
"    endif
"endfunction


" 指定桁のセパレータコメントを挿入 "{{{2

" http://d.hatena.ne.jp/ns9tks/20081127/1227757541
function! <SID>GetSeparatorLineString(pre, char, post, col_len)
  let chars_len =  a:col_len - (virtcol(".") - 1) - strlen(a:pre) - strlen(a:post)
  if chars_len < 0 || strlen(a:char) == 0
    return ''
  endif
  return  a:pre . repeat(a:char, chars_len / strlen(a:char)) . a:post
endfunction
inoremap <expr> <C-\>   <Nop>
inoremap <expr> <C-\>// <SID>GetSeparatorLineString('//', '/', ''        , 78)
inoremap <expr> <C-\>/- <SID>GetSeparatorLineString('//', '-', ''        , 78)
inoremap <expr> <C-\>/. <SID>GetSeparatorLineString('//', '.', ''        , 78)
inoremap <expr> <C-\>/* <SID>GetSeparatorLineString('/*', '*', '*/'      , 78)
inoremap <expr> <C-\>"" <SID>GetSeparatorLineString('"' , '"', ''        , 78)
inoremap <expr> <C-\>-- <SID>GetSeparatorLineString('-' , '-', ''        , 78)
inoremap <expr> <C-\>== <SID>GetSeparatorLineString('=' , '=', ''        , 78)
inoremap <expr> <C-\>"- <SID>GetSeparatorLineString('"' , '-', ''        , 78)
inoremap <expr> <C-\>". <SID>GetSeparatorLineString('"' , '.', ''        , 78)
inoremap <expr> <C-\>## <SID>GetSeparatorLineString('#' , '#', ''        , 78)
inoremap <expr> <C-\>#- <SID>GetSeparatorLineString('#' , '-', ''        , 78)
inoremap <expr> <C-\>#. <SID>GetSeparatorLineString('#' , '.', ''        , 78)
inoremap <expr> <C-\>;; <SID>GetSeparatorLineString(';' , ';', ''        , 78)
inoremap <expr> <C-\>(* <SID>GetSeparatorLineString('(' , '*', ')'       , 78)
inoremap <expr> <C-\>={ <SID>GetSeparatorLineString('=' , '=', ' {{'.'{1', 78)
inoremap <expr> <C-\>=} <SID>GetSeparatorLineString('=' , '=', ' }}'.'}1', 78)
inoremap <expr> <C-\>-{ <SID>GetSeparatorLineString('-' , '-', ' {{'.'{1', 78)
inoremap <expr> <C-\>-} <SID>GetSeparatorLineString('-' , '-', ' }}'.'}1', 78)


" Tidy "{{{2

command! -range=0 Tidy call s:my_tidy(<count>, <line1>, <line2>)
function! s:my_tidy(has_range, line1, line2)
  if s:tidy_cmd == ''
    return
  endif

  execute ':up|normal mx'
  execute ':%:!' . s:tidy_cmd
  execute ':normal `x'
  " execute ':normal! ggVG='
endfunction




function! s:MyIndent() "{{{2
  let cursor_pos = getpos('.')
  let cursor_line = cursor_pos[1]

  normal! 0
  if (search('^[^{]*{', 'ce', cursor_line) == 0
  \   && search('^[^}]*}', 'ce', cursor_line) == 0)
    call setpos('.', cursor_pos)
    return
  endif

  normal! =aB
endfunction
nnoremap <silent> <Leader>e  :<C-u>call <SID>MyIndent()<Return>


" Grep  "{{{2

" http://webtech-walker.com/archive/2010/03/17093357.html
command! -complete=file -nargs=+ Grep call s:grep([<f-args>])
function! s:grep(args)
    let target = len(a:args) > 1 ? join(a:args[1:]) : '**/*'
    execute 'vimgrep' '/' . a:args[0] . '/j ' . target
    if len(getqflist()) != 0 | copen | endif
endfunction


" dash  "{{{2
" http://qiita.com/items/292e99a521a9653e75fb
function! s:dash(...)
  let ft = &filetype
  if &filetype == 'python'
    let ft = ft.'2'
  endif
  let ft = ft.':'
  let word = len(a:000) == 0 ? input('Dash search: ', ft.expand('<cword>')) : ft.join(a:000, ' ')
  call system(printf("open dash://'%s'", word))
endfunction
command! -nargs=* Dash call <SID>dash(<f-args>)


" jq  "{{{2
" http://qiita.com/items/324d736f68b0f27680b
command! -nargs=? Jq call s:Jq(<f-args>)
function! s:Jq(...)
    if 0 == a:0
        let l:arg = "."
    else
        let l:arg = a:1
    endif
    execute "%! jq \"" . l:arg . "\""
endfunction

" Plugins: "{{{1

" tagbar  "{{{2
noremap <silent> <leader>tl :TagbarOpenAutoClose<cr>
let g:tagbar_left = 1
let g:tagbar_sort = 0
let g:tagbar_compact = 1
let g:tagbar_indent = 1
let g:tagbar_iconchars = ['+', '-']

" https://github.com/majutsushi/tagbar/wiki
let g:tagbar_type_markdown = {
    \ 'ctagstype' : 'markdown',
    \ 'kinds' : [
        \ 'h:H1',
        \ 'i:H2',
        \ 'k:H3',
        \ 'l:H4'
    \ ]
\ }


"pt.vim  "{{{2
cnoreabbrev Pt Pt!
nnoremap <expr> <Space>g ':<C-u>Pt! ' . expand('<cword>')
nnoremap <expr> <Space>G ':<C-u>Pt! '



"vim-polyglot  "{{{2
let g:polyglot_disabled = ['jsx']
let g:jsx_ext_required = 1


" emmet-vim  "{{{2
let g:user_emmet_leader_key='<c-t>'
let g:user_emmet_settings = {
      \  'variables': {
      \    'lang': 'ja',
      \    'charset': 'utf-8'
      \  },
      \ 'indentation': '  '
      \}


" vim-gfm-syntax  "{{{2
let g:gfm_syntax_enable_always = 0
let g:gfm_syntax_enable_filetypes = ['markdown.gfm']
augroup vimrc-vim-gfm-syntax
  autocmd!
  autocmd BufRead,BufNew,BufNewFile README.md setlocal ft=markdown.gfm
augroup END

" previm  "{{{2
let g:previm_open_cmd = "open"




" phpfmt.vim  "{{{2
let g:phpfmt_command = expand('~/.composer/vendor/bin/phpcbf')
let g:phpfmt_autosave = 0
" let g:phpfmt_standard = 'WordPress-Core'
" let g:phpfmt_options = '--standard=WordPress-Core --encoding=utf-8'


" phpfolding.vim  "{{{2
let g:DisableAutoPHPFolding = 1

" matchparen  "{{{2
let loaded_matchparen = 1

" open-browser.vim  "{{{2
nmap <leader>w <Plug>(openbrowser-smart-search)

" NERD Commenter  "{{{2
" http://www.vim.org/scripts/script.php?script_id=1218
" http://d.hatena.ne.jp/tanakaBox/20070409/1176062438
" <leader>cc  コメント
" <leader>cu  コメント削除
" <leader>cA  行末にコメント
" <leader>c<space>  トグル
"
let g:NERDSpaceDelims = 1
let g:NERDShutUp = 1
let g:NERDCustomDelimiters = {
  \ 'html': { 'left': '<!--', 'right': '-->' }
  \ }


" quickrun.vim  "{{{2
let g:quickrun_config={'*': {'split': ''}}
let g:quickrun_no_default_key_mappings = 1
silent! map <unique> <Leader>r <Plug>(quickrun)

" " http://www.karakaram.com/vim/phpunit-location-list/
" augroup QuickRunPHPUnit
  " autocmd!
  " autocmd BufWinEnter,BufNewFile *Test.php set filetype=php.phpunit
" augroup END
" let g:quickrun_config['php.phpunit'] = {}
" let g:quickrun_config['php.phpunit']['outputter'] = 'phpunit'
" let g:quickrun_config['php.phpunit']['command'] = 'phpunit'
" let g:quickrun_config['php.phpunit']['exec'] = '%c %o %s'
" let g:quickrun_config['php.phpunit']['outputter/phpunit/height'] = 3
" let g:quickrun_config['php.phpunit']['outputter/phpunit/running_mark'] = 'running...'
" let g:quickrun_config['php.phpunit']['outputter/phpunit/auto_open'] = 1

let g:quickrun_config['objc'] = {
      \ 'command': 'cc',
      \ 'exec': ['%c %s -o %s:p:r -framework Foundation', '%s:p:r %a', 'rm -f %s:p:r'],
      \ 'tempfile': '{tempname()}.m',
      \}

" unite  "{{{2
let g:unite_source_file_mru_limit = 200
let g:unite_source_file_mru_filename_format = ''
let g:unite_data_directory = $MY_VIMRUNTIME . '/.vim/unite'

nnoremap <silent>uo :<C-u>Unite outline<CR>

" http://this.aereal.org/entry/2013/12/25/003235
let s:unite_git_files_conflict = {
      \   'name' : 'git/files/conflict',
      \ }
function! s:unite_git_files_conflict.gather_candidates(args, context)
  let output = unite#util#system('git diff-files --name-only --diff-filter=U')
  let candidates = map(split(output, "\n"), '{
        \ "word" : fnamemodify(v:val, ":p"),
        \ "source" : "git/files/conflict",
        \ "kind" : "file",
        \ "action__path" : fnamemodify(v:val, ":p"),
        \ }')
  return candidates
endfunction
" call unite#define_source(s:unite_git_files_conflict)


" snipMate.vim  "{{{2
let g:snippets_dir = $MY_VIMRUNTIME . '/snippets'



" acp.vim  "{{{2
" autocomplpop.vim : Automatically open the popup menu for completion
let g:acp_behaviorSnipmateLength = 1
let g:AutoComplPop_MappingDriven = 1
let g:acp_behaviorKeywordLength=2
let g:acp_behaviorFileLength=2
let g:acp_behaviorHtmlOmniLength=1
let g:acp_ignorecaseOption=0

" http://subtech.g.hatena.ne.jp/cho45/20071111/1194766579
" 補完候補表示したままRETおして改行できるようにする。
" inoremap <expr> <CR> pumvisible() ? "\<C-Y>\<CR>" : "\<CR>"

" 使用するか考え中
" http://d.hatena.ne.jp/cooldaemon/20071114/1195029893
" autocmd FileType * let g:AutoComplPop_CompleteOption = '.,w,b,u,t,i'
" autocmd FileType perl let g:AutoComplPop_CompleteOption = '.,w,b,u,t,k~/.vim/dict/perl_dunctions.dict'
" autocmd FileType php let g:AutoComplPop_CompleteOption = '.,w,b,u,t,k~/.vim/dict/PHP.dict'
" autocmd FileType ruby let g:AutoComplPop_CompleteOption = '.,w,b,u,t,i,k~/.vim/dict/ruby.dict'
" autocmd FileType javascript let g:AutoComplPop_CompleteOption = '.,w,b,u,t,i,k~/.vim/dict/javascript.dict'
" autocmd FileType erlang let g:AutoComplPop_CompleteOption = '.,w,b,u,t,i,k~/.vim/dict/erlang.dict'


" fuf.vim  "{{{2
" http://www.vim.org/scripts/script.php?script_id=1984

let g:fuf_modesDisable = ['mrucmd']
let g:fuf_keyNextMode = '<TAB>'
let g:fuf_keyPrevMode = '<S-TAB>'
let g:fuf_ignoreCase = 0
let g:fuf_modesDisable = ['mrucmd']
let g:fuf_mrufile_maxItem = 1000
let g:fuf_enumeratingLimit = 20
let g:fuf_mrufile_exclude = '\v\~$|\.bak$|\.swp|\.howm$|COMMIT_EDITMSG'
let g:fuf_file_exclude = '\v\~$|\.DS_Store$|\.o$|\.exe$|\.bak$|\.swp|\.howm$'
let g:fuf_dir_exclude = '\v\.svn|((^|[/\\])\.{1,2}[/\\]$)'

nnoremap <silent> fff :FufFile <C-r>=expand('%:~:.')[:-1-len(expand('%:~:.:t'))]<CR><CR>
nnoremap <silent> ffn :FufBuffer<CR>
nnoremap <silent> ffm :FufMruFile<CR>
nnoremap <silent> ffd :FufDir <C-r>=expand('%:p:~')[:-1-len(expand('%:p:~:t'))]<CR><CR>
nnoremap <silent> ffb :FufBookmark<CR>
vmap <silent> ffa :FufAddBookmark<CR>

" qfutil  "{{{2
" https://bitbucket.org/anyakichi/vim-qfutil
" http://www.sopht.jp/blog/index.php?/archives/458-Quickfix-utility-for-Vim.html
" nnoremap <silent> [Quickfix]o :<C-u>call qfutil#open()<CR>
nnoremap <silent> [Quickfix]o :<C-u>call qfutil#open()<Return>:execute "set modifiable"<cr>
nnoremap <silent> [Quickfix]c :<C-u>call qfutil#close()<CR>
nnoremap <silent> [Quickfix]j :<C-u>call qfutil#next(v:count)<CR>
nnoremap <silent> [Quickfix]k :<C-u>call qfutil#previous(v:count)<CR>
nnoremap <expr> [Quickfix]g qfutil#grep('')


" fugitive.vim  "{{{2
" https://github.com/tpope/vim-fugitive

nnoremap <leader>gs :<C-u>Gstatus<Enter>
nnoremap <leader>ga :<C-u>Gwrite<Enter>
nnoremap <leader>gc :<C-u>Gcommit<Enter>
nnoremap <leader>gb :<C-u>Gblame<Enter>
nnoremap <leader>gh :help Gstatus<Enter>


" jscomplete-vim  "{{{2
" https://github.com/teramako/jscomplete-vim
let g:jscomplete_use = ['dom', 'moz', 'es6th']



" jsdoc-vim  "{{{2
let g:jsdoc_default_mapping = 0



" indentLine  "{{{2
let g:indentLine_fileType = ['javascript', 'json', 'yaml', 'scss', 'sass', 'slim', 'haml', 'html', 'ansible']
let g:indentLine_color_term = 235


" EasyAlign  "{{{2
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)


" yankround.vim  "{{{2
nmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)

" plasticboy/vim-markdown  "{{{2
" https://github.com/plasticboy/vim-markdown
let g:vim_markdown_no_default_key_mappings = 1
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_new_list_item_indent = 2
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toc_autofit = 1
" http://mattn.kaoriya.net/software/vim/20140523124903.htm
let g:markdown_fenced_languages = ['coffee', 'css', 'php', 'perl', 'sh', 'html', 'erb=eruby', 'javascript', 'js=javascript', 'json=javascript', 'ruby', 'sass', 'xml']

" syntastic  "{{{2
" https://github.com/scrooloose/syntastic
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_save = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_loc_list_height = 6
let g:syntastic_auto_jump = 1
let g:syntastic_enable_signs=1
let g:syntastic_mode_map = { 'mode': 'active',
  \ 'active_filetypes': [],
  \ 'passive_filetypes': ['html', 'cucumber'] }

let g:syntastic_enable_perl_checker = 1
let g:syntastic_perl_checkers = ['perl', 'podchecker']

" let g:syntastic_php_checkers=['php', 'phpcs', 'phpmd']
" let g:syntastic_php_checkers = ['php', 'phpmd']
let g:syntastic_php_checkers = ['php']

" let g:syntastic_javascript_checkers = ['jsl']
" let g:syntastic_javascript_jsl_args = '-conf ' . $MY_VIMRUNTIME . '/tools/jsl.conf'
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_json_checkers = ['jsonlint']


" lightline  "{{{2
let s:base04 = [ '#fdf6e3', 230 ]
let s:base03 = [ '#002b36', 234 ]
let s:base02 = [ '#073642', 235 ]
let s:base01 = [ '#586e75', 240 ]
let s:base00 = [ '#657b83', 245  ]
let s:green = [ '#859900', 64 ]
let s:red = [ '#dc322f', 160 ]
let s:orange = [ '#cb4b16', 166 ]
let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}}
let s:p.normal.left = [ [ s:base04, s:base01 ], [ s:base03, s:base00 ] ]
let s:p.inactive.left =  [ [ s:base00, s:base02 ], [ s:base00, s:base02 ] ]
let s:p.insert.left = [ [ s:base04, s:green ], [ s:base03, s:base00 ] ]
let s:p.replace.left = [ [ s:base04, s:red ], [ s:base03, s:base00 ] ]
let s:p.visual.left = [ [ s:base04, s:orange ], [ s:base03, s:base00 ] ]
let s:p.normal.right = [ [ s:base00, s:base02 ], [ s:base00, s:base01 ] ]
let s:p.inactive.right = [ [ s:base00, s:base02 ], [ s:base00, s:base02 ] ]
let s:p.normal.middle = [ [ s:base03, s:base00 ] ]
let s:p.inactive.middle = [ [ s:base00, s:base02 ] ]
function! s:flatten(p)
  for k in values(a:p)
    for l in values(k)
      for m in range(len(l))
        let l[m] = [l[m][0][0], l[m][1][0], l[m][0][1], l[m][1][1]]
      endfor
    endfor
  endfor
  return a:p
endfunction
let g:lightline#colorscheme#hogehoge#palette = s:flatten(s:p)

let g:lightline = {
      \ 'colorscheme': 'hogehoge',
      \ 'active': {
      \   'left': [ [ 'paste', 'readonly', 'modified' ],
      \             [ 'filename' ] ],
      \   'right': [ [ 'percent' ],
      \              [ 'lineinfo' ],
      \              [ 'fugitive', 'fileencoding', 'fileformat', 'filetype' ] ]
      \ },
      \ 'inactive': {
      \   'left': [ [ 'readonly', 'modified', 'relativepath' ] ],
      \   'right': [ [ 'percent' ],
      \              [ 'lineinfo' ],
      \              [ 'fugitive', 'fileencoding', 'fileformat', 'filetype' ] ]
      \ },
      \ 'component': {
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'component_visible_condition': {
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ },
      \ }






" Vim Starting:  "{{{1
" http://d.hatena.ne.jp/thinca/20100619/1276915771
if has('vim_starting')
  " if filereadable($HOME . '/.vimrc.local')
    " source $HOME/.vimrc.local
  " endif

  " http://nanasi.jp/articles/vim/matchit_vim.html
  source $VIMRUNTIME/macros/matchit.vim
endif

