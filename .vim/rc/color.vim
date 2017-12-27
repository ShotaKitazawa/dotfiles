" Color
"""""""""""""""""""""""""""""
"colorscheme molokai
"colorscheme wombat
if !has('kaoriya') && !has('win32unix')
  colorscheme hybrid
  "colorscheme jellybeans
endif
" 行番号の色
autocmd ColorScheme * highlight LineNr ctermfg=30
"""""""""""""""""""""""""""""

" Terminal Color (neovim)
"""""""""""""""""""""""""""""
" http://qiita.com/reanisz/items/6a442b39e86a92b1a1d5
"""""""""""""""""""""""""""""
if has('nvim')
  let g:terminal_color_0  = "#2E3436"
  let g:terminal_color_1  = "#CC0000"
  let g:terminal_color_2  = "#4E9A06"
  let g:terminal_color_3  = "#C4A000"
  let g:terminal_color_4  = "#3465A4"
  let g:terminal_color_5  = "#75507B"
  let g:terminal_color_6  = "#93A1A1"
  let g:terminal_color_7  = "#D3D7CF"
  let g:terminal_color_8  = "#555753"
  let g:terminal_color_9  = "#EF2929"
  let g:terminal_color_10 = "#8AE234"
  let g:terminal_color_11 = "#FCE94F"
  let g:terminal_color_12 = "#729FCF"
  let g:terminal_color_13 = "#AD7FA8"
  let g:terminal_color_14 = "#34E2E2"
  let g:terminal_color_15 = "#EEEEEC"
endif
"""""""""""""""""""""""""""""
