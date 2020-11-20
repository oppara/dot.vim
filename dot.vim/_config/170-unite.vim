" Shougo/unite.vim: Unite and create user interfaces
" https://github.com/Shougo/unite.vim

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
