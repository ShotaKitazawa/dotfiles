" NOTE: rc/*.vim はファイル名の辞書順(000,001,...,100,...,999)で読み込まれるため、
" このファイルは常に最後に読み込まれる。ここでの設定は他の rc ファイル(例: 100-color.vim の
" colorscheme hybrid)を意図的に上書きするためのものであり、事故ではない。
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
