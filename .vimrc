""""""""""""""""""""""""""""""
" Plugin's setting
""""""""""""""""""""""""""""""
function! Plugin()
	NeoBundle 'scrooloose/nerdtree'
	NeoBundle 'w0ng/vim-hybrid'
	NeoBundle 'nanotech/jellybeans.vim'
	NeoBundle 'thinca/vim-quickrun'
	NeoBundle 'kien/ctrlp.vim'
	" http://qiita.com/MoriKen/items/24d1dde0c40e59a61edf
	NeoBundle 'Shougo/neocomplete.vim'
	NeoBundle 'Shougo/vimproc.vim', {
	            \ 'build' : {
	            \ 'windows' : 'make -f make_mingw32.mak',
	            \ 'cygwin' : 'make -f make_cygwin.mak',
	            \ 'mac' : 'make -f make_mac.mak',
	            \ 'unix' : 'make -f make_unix.mak',
	            \ },
	            \ }
	NeoBundle 'justmao945/vim-clang'
	NeoBundle 'Shougo/neoinclude.vim'
	NeoBundle 'deton/jasegment.vim'
	NeoBundle 'kana/vim-operator-user'
	NeoBundle 'rhysd/vim-clang-format'
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
" http://qiita.com/MoriKen/items/24d1dde0c40e59a61edf
"""""""""""""""""""""""""""""
let g:neocomplete#enable_at_startup = 1
if !exists('g:neocomplete#force_omni_input_patterns')
	let g:neocomplete#force_omni_input_patterns = {}
endif
	let g:neocomplete#force_overwrite_completefunc = 1
	let g:neocomplete#force_omni_input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
	let g:neocomplete#force_omni_input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

let g:clang_auto = 0
let g:clang_complete_auto = 0
let g:clang_auto_select = 0
let g:clang_use_library = 1

let g:clang_c_completeopt   = 'menuone'
let g:clang_cpp_completeopt = 'menuone'

if executable('clang-3.6')
	let g:clang_exec = 'clang-3.6'
elseif executable('clang-3.5')
	let g:clang_exec = 'clang-3.5'
elseif executable('clang-3.4')
	let g:clang_exec = 'clang-3.4'
else
        let g:clang_exec = 'clang'
endif

if executable('clang-format-3.6')
    let g:clang_format_exec = 'clang-format-3.6'
elseif executable('clang-format-3.5')
    let g:clang_format_exec = 'clang-format-3.5'
elseif executable('clang-format-3.4')
    let g:clang_format_exec = 'clang-format-3.4'
else
    let g:clang_exec = 'clang-format'
endif

let g:clang_c_options = '-std=c11'
let g:clang_cpp_options = '-std=c++11 -stdlib=libc++'
"""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""
" Other setting
"""""""""""""""""""""""""""""
set nocompatible
set backspace=indent,eol,start
set undofile
set clipboard+=unnamed
syntax on
set background=dark
set encoding=utf-8
set fileencodings=iso-2022-jp,cp932,sjis,euc-jp,utf-8
colorscheme jellybeans
map ,x <Plug>(operator-clang-format)
inoremap <C-e> <Esc>$a
inoremap <C-a> <Esc>^i
noremap <C-e> <Esc>$a
noremap <C-a> <Esc>^i
"""""""""""""""""""""""""""""

