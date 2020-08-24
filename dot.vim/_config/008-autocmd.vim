" Autocmd:  "{{{1


augroup vimrc-rtrim  "{{{2
  autocmd!
  " 保存時に行末の空白を除去する
  autocmd BufWritePre * call s:rtrim()

  function! s:rtrim()
    let s:cursor = getpos(".")
    if stridx(&filetype, 'markdown') == 0
      %s/\s\+\(\s\{2}\)$/\1/e
      :SetMarkdownTrailingSpaceHighlight
    else
      %s/\s\+$//e
    endif
    call setpos(".", s:cursor)
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
    if g:is_mac && isutf8
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

    " " tagディレクトリにも移動しない
    " let tf = tagfiles()
    " if !empty(tf)
      " let tagdir = fnamemodify(tf[0], ':p:h')
      " if tagdir !=# '' && simple[ : len(tagdir) - 1] ==# tagdir
        " return tagdir
      " endif
    " endif

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




