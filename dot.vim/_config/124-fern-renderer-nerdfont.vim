" lambdalisue/fern-renderer-nerdfont.vim: 🌿 fern.vim plugin which add file type icon through nerdfont.vim
" https://github.com/lambdalisue/fern-renderer-nerdfont.vim

if empty(globpath(&rtp, 'plugin/fern_renderer_nerdfont.vim'))
  finish
endif

let g:fern#renderer = "nerdfont"
