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

" Status Line
"""""""""""""""""""""""""""""
" ファイル名表示
set statusline=%F
" 変更チェック表示
set statusline+=%m
" 読み込み専用かどうか表示
set statusline+=%r
" ヘルプページなら[HELP]と表示
set statusline+=%h
" プレビューウインドウなら[Prevew]と表示
set statusline+=%w
" これ以降は右寄せ表示
set statusline+=%=
" file encoding
set statusline+=[ENC=%{&fileencoding}]
" 現在行数/全行数
set statusline+=[LOW=%l/%L]
" ステータスラインを常に表示(0:表示しない、1:2つ以上ウィンドウがある時だけ表示)
set laststatus=2
"""""""""""""""""""""""""""""


" 窓関係
"""""""""""""""""""""""""""""
" http://nanasi.jp/articles/howto/file/expand.html
"""""""""""""""""""""""""""""
" s キーを無効化
nnoremap s <Nop>
" s[h|j|k|l] で窓移動
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
" s[H|J|K|L] で窓移動&入れ替え
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
" s[n|p] でタブ移動
nnoremap sn gt
nnoremap sp gT
"
nnoremap sr <C-w>r
nnoremap sN :<C-u>bn<CR>
nnoremap sP :<C-u>bp<CR>
" 次窓へ移動
nnoremap sw <C-w>w
" 自窓を縦に最大拡張
nnoremap so <C-w>_<C-w>|
" 各窓を均等にする
nnoremap sO <C-w>=
nnoremap s= <C-w>=
" 現在の窓をタブ化
nnoremap st :<C-u>tab split<CR>
" 新タブ作成
nnoremap sT :<C-u>tabnew<CR>
" 縦に新窓作成
nnoremap ss :<C-u>sp<CR>
" 横に新窓作成
nnoremap sv :<C-u>vs<CR>
" 1窓終了
nnoremap sq :<C-u>q<CR>
" 全窓終了
nnoremap sQ :<C-u>bd<CR>


" Other setting
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
" undofile の作成、~/.vimundo/ 以下に保存
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
" C言語用自動インデント
set cindent
" TAB をスペースにする
set expandtab
" タブを常に表示
set showtabline=2
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
" スクリーンベル無効化
set t_vb=
set novisualbell
" 対象のファイル以上の ctags ファイルを探す
set tags=./.tags;
" Leader キーを Space に
let mapleader = "\<Space>"
" Ctrl-Cをescapeに
nnoremap <C-c> <Nop>
nnoremap <C-c> <Esc>
" タグジャンプを複数選択に
nnoremap <C-]> g<C-]>
" カーソル下の単語を * で検索
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>
" 検索後にジャンプした際に検索単語を画面中央に持ってくる
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
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
noremap <C-k> <C-y>
noremap <C-j> <C-e>
" 行が折り返し表示されていた場合、行単位ではなく表示行単位でカーソルを移動する
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
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
nnoremap <C-c> <Nop>
nnoremap <C-c> <ESC>
" insert mode時フルパス入力
inoremap <C-r>path <C-R>=expand('%:p')<CR>
" 不可視文字を表示する
set list
" 不可視文字の編集
set listchars=tab:>-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲
" 入力中のコマンドを表示する
set showcmd
"" number,mouse=a -> nonumber,mouse=
"nnoremap tn :set nonumber<CR>:set mouse=<CR>:set listchars=<CR>
"" number,mouse=a <- nonumber,mouse=
"nnoremap ty :set number<CR>:set mouse=a<CR>:set listchars=tab:>-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲<CR>
" ファイルパス表示
nnoremap <C-g> 1<C-g>
" :tmp > :Template
nnoremap :tmp :Template

" 前回のカーソル位置の復元
autocmd BufReadPost * if line("'\"") > 0 && line ("'\"") <= line("$") | exe "normal! g'\"" | endif
" Syntax Highlight
autocmd Syntax * call matchadd('Todo',  '\W\zs\(TODO\|FIXME\|CHANGED\|XXX\|BUG\|HACK\)')
autocmd Syntax * call matchadd('Debug', '\W\zs\(NOTE\|INFO\|IDEA\)')

" ウィンドウ移動時ファイルパス表示
augroup EchoFilePath
  autocmd WinEnter * execute "normal! 1\<C-g>"
augroup END

" Jinja2
autocmd BufNewFile,BufRead *.jinja2,*.jinja setf jinja
