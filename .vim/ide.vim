" source
source ~/.vim/vimrc

" settings
set noequalalways

" terminal
au VimEnter * split
au VimEnter * wincmd k
au VimEnter * resize 8
au VimEnter * terminal bash

" NERDTree
let NERDTreeMapOpenInTab='<C-o>'
let g:nerdtree_tabs_open_on_console_startup = 1
let g:nerdtree_tabs_open_on_new_tab = 1

" Golang
au BufNewFile,BufRead *.go let g:go_guru_scope = [getcwd()]

