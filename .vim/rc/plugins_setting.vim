" Shougo/dein.vim
""""""""""""""""""""""""""""""
" http://qiita.com/delphinus/items/00ff2c0ba972c6e41542
""""""""""""""""""""""""""""""
" vimrc に以下のように追記

" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

"" もしvimが7.4以前ならばdeinのバージョンを下げる
if v:version <= 704
  if empty(glob(s:dein_dir . '/.using_vim74'))
    execute '!cd' s:dein_repo_dir . '; git checkout 1.0 &> /dev/null'
    execute '!touch' s:dein_dir . '/.using_vim74; rm -f ' s:dein_dir . '/.using_vim8'
  endif
else
  if empty(glob(s:dein_dir . '/.using_vim8'))
    execute '!cd' s:dein_repo_dir . '; git checkout 2.0 &> /dev/null'
    execute '!touch' s:dein_dir . '/.using_vim8; rm -f ' s:dein_dir . '/.using_vim74'
  endif
endif

" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " TOML を読み込み、キャッシュしておく
  let s:toml_dir  = $HOME . '/.vim/rc'
  call dein#load_toml(s:toml_dir . '/dein.toml',      {'lazy': 0})
  call dein#load_toml(s:toml_dir . '/deinlazy.toml',  {'lazy': 1})

  " 設定終了
  call dein#end()
  call dein#save_state()
endif

" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif

" call dein#recache_runtimepath()

""""""""""""""""""""""""""""""
let g:python3_host_prog=$HOME.'/.pyenv/shims/python3'

call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
    \ 'name': 'buffer',
    \ 'allowlist': ['*'],
    \ 'completor': function('asyncomplete#sources#buffer#completor'),
    \ 'config': {
    \    'max_buffer_size': 5000000,
    \  },
    \ }))

