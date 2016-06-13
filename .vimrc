""""""""""""""""""""""""""""""
" Plugin's setting
""""""""""""""""""""""""""""""
function! Plugin()
	NeoBundle 'scrooloose/nerdtree'
	NeoBundle 'w0ng/vim-hybrid'
	NeoBundle 'nanotech/jellybeans.vim'
	NeoBundle 'justmao945/vim-clang'
	NeoBundle 'thinca/vim-quickrun'
	NeoBundle 'kien/ctrlp.vim'
endfunction

""""""""""""""""""""""""""""""
if has('vim_starting')
  set nocompatible               " Be iMproved

  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))

call Plugin()

call neobundle#end()

filetype plugin indent on

NeoBundleCheck
""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""
" Other setting
"""""""""""""""""""""""""""""
set nocompatible
set backspace=indent,eol,start
set undofile
syntax on
set background=dark
colorscheme jellybeans
"""""""""""""""""""""""""""""
