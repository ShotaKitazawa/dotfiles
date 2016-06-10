"""""""""""""""""""""""""""""
" First setting
"""""""""""""""""""""""""""""
set nocompatible
set backspace=indent,eol,start
set undofile
"""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
" Full space displayed
""""""""""""""""""""""""""""""
" http://inari.hatenablog.com/entry/2014/05/05/231307
""""""""""""""""""""""""""""""
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
endfunction

if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme * call ZenkakuSpace()
        autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
    augroup END
    call ZenkakuSpace()
endif
""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""
" Plugin's setting
""""""""""""""""""""""""""""""
function! Plugin()
	NeoBundle 'scrooloose/nerdtree'
	NeoBundle 'w0ng/vim-hybrid'
	NeoBundle 'nanotech/jellybeans.vim'
	NeoBundle 'justmao945/vim-clang'
	NeoBundle 'thinca/vim-quickrun'
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

syntax on
set background=dark
colorscheme jellybeans
