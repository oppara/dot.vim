" Function:  "{{{1

" :SetMarkdownTrailingSpaceHighlight "{{{2
command! -range=0 SetMarkdownTrailingSpaceHighlight call s:set_markdown_trailing_space_highlight()
function! s:set_markdown_trailing_space_highlight()
  match Underlined /\s\{2}$/
  highlight Underlined ctermbg=black ctermfg=red guibg=black guifg=red
endfunction


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


" EchoSyntax  "{{{2
" カーソル位置のsyntax要素の名前を表示
command! -nargs=0 EchoSyntax echo synIDattr(synID(line("."), col("."), 1), "name")
