" TODO: 動作しない
"if empty(globpath(&rtp, "strooloose/nerdtree"))
"  finish
"endif

nnoremap tr :<C-u>NERDTreeToggle<CR>
let g:NERDTreeShowHidden=1
let g:NERDTreeMapUpdir=''
let g:NERDTreeShowBookmarks=1
let g:NERDTreeMapOpenSplit='<C-j>'
let g:NERDTreeMapOpenVSplit='<C-l>'
