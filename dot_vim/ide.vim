" source
source ~/.vim/vimrc

" settings
set noequalalways

" terminal
au VimEnter * split
au VimEnter * wincmd k
au VimEnter * resize 8
au VimEnter * terminal

" NERDTree
let NERDTreeMapOpenInTab='<C-o>'

" Golang
au BufNewFile,BufRead *.go let g:go_guru_scope = [getcwd()]

