
if has("vim_starting")
  let g:plug_dir =  $MY_VIMRUNTIME . '/plugged'
  let g:plug_repo_dir =  g:plug_dir . '/vim-plug/autoload'
  execute 'set runtimepath^=' . fnamemodify(g:plug_repo_dir, ':h')
  if !isdirectory(expand(g:plug_repo_dir))
     execute '!git clone https://github.com/junegunn/vim-plug.git' g:plug_repo_dir
  endif
endif

call plug#begin(g:plug_dir)

  Plug 'junegunn/vim-plug', {'dir': g:plug_repo_dir}

  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'

  Plug 'vim-jp/vimdoc-ja'

  Plug 'lambdalisue/fern.vim'
  Plug 'lambdalisue/nerdfont.vim'
  Plug 'lambdalisue/glyph-palette.vim'
  Plug 'lambdalisue/fern-renderer-nerdfont.vim'


  Plug 'itchyny/lightline.vim'
  Plug 'Shougo/vimproc.vim', {'do': 'make'}

  Plug 'clones/vim-l9'
  Plug 'clones/vim-autocomplpop'
  " Plug 'clones/vim-fuzzyfinder', {'on': ['FufFile', 'FufBuffer', 'FufMruFile', 'FufDir', 'FufBookmark', 'FufAddBookmark']}

  Plug 'Shougo/unite.vim', {'on': ['Unite', 'UniteWithBufferDir'], 'for': ['unite']}
  Plug 'Shougo/unite-help', {'on': ['Unite'] }
  Plug 'Shougo/unite-outline', {'on': ['Unite']}
  Plug 'Shougo/context_filetype.vim'

  Plug 'oppara/wombat256opp'
  Plug 'morhetz/gruvbox'

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
  Plug 'tpope/vim-endwise', {'for': ['ruby']}

  " Plug 'scrooloose/nerdtree'
  Plug 'scrooloose/nerdcommenter'
  Plug 'vim-scripts/sudo.vim'

  Plug 'Valloric/MatchTagAlways'

  Plug 'Yggdroot/indentLine'
  " Plug 'rhysd/migemo-search.vim'
  " if executable('cmigemo')
    " cnoremap <expr><CR> migemosearch#replace_search_word()."\<CR>"
  " endif

  Plug 'fuenor/qfixgrep'

  Plug 'mattn/emmet-vim', {'for': ['html', 'xhtml', 'xml', 'css', 'less', 'sass', 'scss', 'slim', 'haml', 'jade', 'php']}
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

  Plug 'junegunn/vim-easy-align', {'on': ['EasyAlign']}
  Plug 'anyakichi/vim-qfutil'

  Plug 'tyru/open-browser.vim'

  Plug 'sheerun/vim-polyglot'
  Plug 'w0rp/ale'

  Plug 'z0mbix/vim-shfmt', { 'for': 'sh'  }

  Plug 'tobyS/vmustache'
  Plug 'tobyS/pdv', {'for': ['php']}

" " http://www.karakaram.com/vim/phpunit-location-list/
  Plug 'karakaram/vim-quickrun-phpunit', {'for': ['php']}
  Plug 'vim-scripts/phpfolding.vim', {'for': ['php']}
  Plug 'beanworks/vim-phpfmt', {'for': ['php']}
  Plug 'stephpy/vim-php-cs-fixer', {'for': ['php']}
  Plug 'StanAngeloff/php.vim'

  Plug 'oppara/sql_iabbr.vim', {'for': ['sql']}

  Plug 'kannokanno/previm', {'for': ['markdown']}
  Plug 'rhysd/vim-gfm-syntax'

  Plug 'hokaccha/vim-html5validator', {'for': ['html']}

  Plug 'hail2u/vim-css3-syntax', {'for': ['css']}

  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries'  }

  Plug 'heavenshell/vim-jsdoc', {
        \ 'for': ['javascript', 'javascript.jsx','typescript'],
        \ 'do': 'make install'
        \}
  Plug 'mattn/jscomplete-vim', {'for': ['javascript']}
  Plug 'myhere/vim-nodejs-complete', {'for': ['javascript', 'node']}
  Plug 'oppara/vim-jquery', {'for': ['javascript']}

  Plug 'hashivim/vim-terraform'

call plug#end()


filetype plugin indent on

