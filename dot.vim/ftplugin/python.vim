if exists("b:did_ftplugin_python")
    finish
endif
let b:did_ftplugin_python = 1

setlocal expandtab softtabstop=2 shiftwidth=2
setlocal omnifunc=pythoncomplete#Complete
let python_highlight_numbers=1
let python_highlight_builtins=1
let python_highlight_space_errors=1

