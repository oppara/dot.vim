" lambdalisue/glyph-palette.vim: 🎨 An universal palette for Nerd Fonts
" https://github.com/lambdalisue/glyph-palette.vim

if empty(globpath(&rtp, 'autoload/glyph_palette.vim'))
  finish
endif

augroup my-glyph-palette
  autocmd! *
  autocmd FileType fern call glyph_palette#apply()
  autocmd FileType nerdtree,startify call glyph_palette#apply()
augroup END
