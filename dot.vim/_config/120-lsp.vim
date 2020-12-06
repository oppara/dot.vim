if empty(globpath(&rtp, 'autoload/lsp.vim'))
  finish
endif

function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  nmap <buffer> <f2> <plug>(lsp-rename)
  nmap <buffer> sp <plug>(lsp-peek-definition)
  nmap <buffer> <silent> sh :split \| :LspDefinition <CR>

  inoremap <expr> <cr> pumvisible() ? "\<c-y>\<cr>" : "\<cr>"
  inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
  inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
endfunction

augroup lsp_install
  au!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
command! LspDebug let lsp_log_verbose=1 | let lsp_log_file = expand('~/lsp.log')

let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:asyncomplete_auto_popup = 1
let g:asyncomplete_auto_completeopt = 0
let g:asyncomplete_popup_delay = 200
let g:lsp_text_edit_enabled = 1

let g:lsp_signs_enabled = 1
let g:lsp_signs_error = {'text': 'X'}
let g:lsp_signs_warning = {'text': '!'}
let g:lsp_signs_information = {'text': '?'}

let g:lsp_settings = {
      \  'yaml-language-server': {
      \    'workspace_config': {
      \      'yaml': {
      \        'schemas': {
      \           'https://s3.amazonaws.com/cfn-resource-specifications-us-east-1-prod/schemas/2.15.0/all-spec.json': [
      \               '*.cf.yaml',
      \               '*.cf.yml',
      \               'cfn/*.yaml',
      \               'cfn/*.yml',
      \               'cloudformation/*.yaml',
      \               'cloudformation/*.yml',
      \               '*-cloudformation/*.yaml',
      \               '*-cloudformation/*.yml'
      \           ]
      \        },
      \        'customTags': [
      \          '!And scalar',
      \          '!And mapping',
      \          '!And sequence',
      \          '!If scalar',
      \          '!If mapping',
      \          '!If sequence',
      \          '!Not scalar',
      \          '!Not mapping',
      \          '!Not sequence',
      \          '!Equals scalar',
      \          '!Equals mapping',
      \          '!Equals sequence',
      \          '!Or scalar',
      \          '!Or mapping',
      \          '!Or sequence',
      \          '!FindInMap scalar',
      \          '!FindInMap mappping',
      \          '!FindInMap sequence',
      \          '!Base64 scalar',
      \          '!Base64 mapping',
      \          '!Base64 sequence',
      \          '!Cidr scalar',
      \          '!Cidr mapping',
      \          '!Cidr sequence',
      \          '!Ref scalar',
      \          '!Ref mapping',
      \          '!Ref sequence',
      \          '!Sub scalar',
      \          '!Sub mapping',
      \          '!Sub sequence',
      \          '!GetAtt scalar',
      \          '!GetAtt mapping',
      \          '!GetAtt sequence',
      \          '!GetAZs scalar',
      \          '!GetAZs mapping',
      \          '!GetAZs sequence',
      \          '!ImportValue scalar',
      \          '!ImportValue mapping',
      \          '!ImportValue sequence',
      \          '!Select scalar',
      \          '!Select mapping',
      \          '!Select sequence',
      \          '!Split scalar',
      \          '!Split mapping',
      \          '!Split sequence',
      \          '!Join scalar',
      \          '!Join mapping',
      \          '!Join sequence',
      \          '!And',
      \          '!If',
      \          '!Not',
      \          '!Equals',
      \          '!Or',
      \          '!FindInMap',
      \          '!Base64',
      \          '!Join',
      \          '!Cidr',
      \          '!Ref',
      \          '!Sub',
      \          '!GetAtt',
      \          '!GetAZs',
      \          '!ImportValue',
      \          '!Select',
      \          '!Split'
      \        ],
      \        'completion': v:true,
      \        'hover': v:true,
      \        'validate': v:true,
      \        'format.enable': v:true
      \      }
      \    }
      \  },
      \}
