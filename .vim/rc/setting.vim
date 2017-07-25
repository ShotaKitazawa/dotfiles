" http://inari.hatenablog.com/entry/2014/05/05/231307
""""""""""""""""""""""""""""""
" 全角スペースの表示
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

" http://d.hatena.ne.jp/rdera/20081022/1224682665
""""""""""""""""""""""""""""""
" バイナリ編集(xxd)モード（vim -b での起動、もしくは *.bin ファイルを開くと発動します）
""""""""""""""""""""""""""""""
augroup BinaryXXD
  autocmd!
  autocmd BufReadPre  *.bin let &binary =1
  "autocmd BufReadPre  *.sys let &binary =1
  autocmd BufReadPost * if &binary | silent %!xxd -g 1
  autocmd BufReadPost * set ft=xxd | endif
  autocmd BufWritePre * if &binary | %!xxd -r | endif
  autocmd BufWritePost * if &binary | silent %!xxd -g 1
  autocmd BufWritePost * set nomod | endif
augroup END
""""""""""""""""""""""""""""""

" Other setting (not plugin)
"""""""""""""""""""""""""""""
" :source $VIMRUNTIME/syntax/syntax.vim
syntax enable
" vi 互換の動作を無効
set nocompatible
" クリップボードを共有する
set clipboard+=unnamedplus
" UTF-8
set encoding=utf-8
" 検索時、小文字 > 大文字小文字にマッチ、大文字 > 大文字のみにマッチ
set ignorecase
set smartcase
" 行をまたいで BS 可能
set backspace=indent,eol,start
"" undofile の作成、~/.vimundo/ 以下に保存
set undofile
set undodir=~/.vimundo/
" スワップファイルを作らない
set noswapfile
" 背景黒
set background=dark
" 検索結果をハイライト
set hlsearch
" カーソルの位置表示を行う
set ruler
"" 行数表示
set number
" ウインドウタイトルを設定する
set title
" インクリメンタルサーチ
set incsearch
" コマンドラインモードにてTab保管を有効にする
set wildmenu wildmode=list:full
" マウスを使用できるようにする
set mouse=a
"" C言語用自動インデント
set cindent
" TAB をスペースにする
set expandtab
" インデント幅 2
set shiftwidth=2
" タブ幅 2
set tabstop=2
" カッコ対応にハイライト3秒
set showmatch
set matchpairs& matchpairs+=<:>
set matchtime=3
" 全角記号を正しく表示
set ambiwidth=double
" :w!! でrootユーザで :w しに行く
cnoremap w!! w !sudo tee > /dev/null %
" C-w でインクリメント
noremap <C-w> <C-a>
" C-a で一番前、C-e で一番後ろ
inoremap <C-e> <Esc>$a
inoremap <C-a> <Esc>^i
noremap <C-e> $
noremap <C-a> ^
" C-h で一行下、C-l で一行上
noremap <C-l> <C-y>
noremap <C-h> <C-e>
" 行が折り返し表示されていた場合、行単位ではなく表示行単位でカーソルを移動する
nnoremap j gj
nnoremap k gk
nnoremap <down> gj
nnoremap <up> gk
" PP で Visual モードでペーストする時連続コピペ可能
noremap PP "0p
" x でも字を消した時クリップボードに保存しない
noremap x "_x
" ESC*2 で nohighlight
noremap <ESC><ESC> :noh<CR>
" vimrc をすぐ開く
nnoremap <space>. :<c-u>new ~/.vim/vimrc<CR>
" C-c で ESC
noremap <C-c> <ESC>
" j*2 で ESC
inoremap jj <ESC>
" Syntax Highlight
autocmd Syntax * call matchadd('Todo',  '\W\zs\(TODO\|FIXME\|CHANGED\|XXX\|BUG\|HACK\)')
autocmd Syntax * call matchadd('Debug', '\W\zs\(NOTE\|INFO\|IDEA\)')
" 不可視文字を表示する
set list
" タブを >--- で表示
set listchars=tab:>-
" 入力中のコマンドを表示する
set showcmd
" 前回のカーソル位置の復元
autocmd BufReadPost * if line("'\"") > 0 && line ("'\"") <= line("$") | exe "normal! g'\"" | endif
" number,mouse=a --> nonumber,mouse=
nnoremap fm :set nonumber<CR>:set mouse=<CR>
" number,mouse=a <-- nonumber,mouse=
nnoremap ff :set number<CR>:set mouse=a<CR>


" TODO: irc の NOTICE にハイライト (RAT)
"""""""""""""""""""""""""""""

if has('number')
  echo "test"
endif