if has('macvim') || has('gui_macvim')
  "au GUIEnter * set fullscreen
  silent! colorscheme jellybeans
  set background=dark
  set fuoptions=maxvert,maxhorz
  set number
  set imdisable  " IMを無効化
  set guifont=agave\ Nerd\ Font:h16
  set transparency=10  " 透明度を指定
  set antialias
  noremap <D-v> p
  nnoremap <D-=> <D-+>
  noremap <C-v> <C-v>
  noremap <C-f> <C-f>
endif
