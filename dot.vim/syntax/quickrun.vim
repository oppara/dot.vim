" VimからPHPUnitを実行する環境を整える - karakaram-blog
" https://www.karakaram.com/quickrun-phpunit/#quickrun-syntax

" QuickRun の outputter で buffer を設定した場合に使用される syntax

if exists("b:current_syntax")
  finish
endif

if !exists("main_syntax")
  let main_syntax = 'quickrun'
endif

"大文字と小文字を区別する
syntax case match

"正規表現で一致
syntax match phpUnitOk /OK.*/
syntax match phpUnitFailures /FAILURES.*/

"group-nameをハイライトの指定と関連付け
highlight phpUnitOk term=reverse ctermbg=2 guibg=DarkGreen
highlight phpUnitFailures term=reverse ctermbg=4 guibg=DarkRed

"unlet b:current_syntax
let b:current_syntax = 'quickrun'
if main_syntax == 'quickrun'
  unlet main_syntax
endif
