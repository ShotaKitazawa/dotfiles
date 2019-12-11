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
    execute '!cd' s:dein_repo_dir . '; git checkout 1.0 > /dev/null 2>&1; touch' s:dein_dir . '/.using_vim74'
  endif
else
  if empty(glob(s:dein_dir . '/.using_vim8'))
    execute '!cd' s:dein_repo_dir . '; git checkout 2.0 > /dev/null 2>&1; touch' s:dein_dir . '/.using_vim8'
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

" Shougo/neosnippet
"""""""""""""""""""""""""""""
"imap <silent>L     <Plug>(neosnippet_jump_or_expand)
"smap <silent>L     <Plug>(neosnippet_jump_or_expand)
"xmap <silent>L     <Plug>(neosnippet_expand_target)

let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#enable_completed_snippet = 1
let g:neosnippet#expand_word_boundary = 1

let g:neosnippet#snippets_directory = '~/.vim/snippets'
"""""""""""""""""""""""""""""

" itchyny/lightline.vim (status line)
"""""""""""""""""""""""""""""
let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'fugitive' ] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"⭤":""}',
      \   'fugitive': '%{fugitive#statusline()}',
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \ },
      \ 'separator': { 'left': '⮀', 'right': '⮂' },
      \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
      \ }
"""""""""""""""""""""""""""""

" kana/vim-submode
"""""""""""""""""""""""""""""
" http://nanasi.jp/articles/howto/file/expand.html
"""""""""""""""""""""""""""""
" s[<|>] で窓を左右拡張
" s[+|-] で窓を上下拡張
call submode#enter_with('bufmove', 'n', '', 's>', '<C-w>>')
call submode#enter_with('bufmove', 'n', '', 's<', '<C-w><')
call submode#enter_with('bufmove', 'n', '', 's+', '<C-w>+')
call submode#enter_with('bufmove', 'n', '', 's-', '<C-w>-')
call submode#map('bufmove', 'n', '', '>', '<C-w>>')
call submode#map('bufmove', 'n', '', '<', '<C-w><')
call submode#map('bufmove', 'n', '', '+', '<C-w>+')
call submode#map('bufmove', 'n', '', '-', '<C-w>-')
"""""""""""""""""""""""""""""

""""""""""""""""""""""""""""
" plasticboy/vim-markdown + kannokanno/previm + tyru/open-browser.vim
""""""""""""""""""""""""""""""
" http://qiita.com/uedatakeshi/items/31761b87ba8ecbaf2c1e
" https://blog.wadackel.me/2017/previmg-github-style/
""""""""""""""""""""""""""""""
au BufRead,BufNewFile *.md set filetype=markdown
let g:previm_open_cmd = ''
let g:previm_disable_default_css = 1
let g:previm_custom_css_path = '~/.config/previm/markdown.css'
"nnoremap :md :PrevimOpen
nnoremap sm :PrevimOpen<CR>
""""""""""""""""""""""""""""""

" Status Line
"""""""""""""""""""""""""""""
" Git
set statusline+=%{fugitive#statusline()}
"""""""""""""""""""""""""""""

" thinca/vim-quickrun
"""""""""""""""""""""""""""""
set splitbelow

call quickrun#module#register(shabadou#make_quickrun_hook_anim(
\	"executing",
\	['|','/','-','\'],
\	12,
\), 1)

let g:quickrun_config = {
\   "_" : {
\       "hook/executing/enable" : 1,
\       "hook/executing/wait" : 20,
\       "outputter/buffer/split" : ":botright 8",
\       "runner" : "vimproc",
\       "runner/vimproc/updatetime" : 40,
\   }
\}
"""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""
" setting for nvim
"""""""""""""""""""""""""""""
if has('nvim')

" Shougo/denite.nvim
"""""""""""""""""""""""""""""
nnoremap [denite] <Nop>
nmap <C-d> [denite]

" Define mappings
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> d
  \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space>
  \ denite#do_map('toggle_select').'j'
endfunction
autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
  imap <silent><buffer> <C-o> <Plug>(denite_filter_quit)
endfunction

" grep -> ag
call denite#custom#var('file/rec', 'command', ['ag', '--follow', '-g', ''])
call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'default_opts', ['--follow', '-u'])

" 過去に開いたファイル検索
nnoremap [denite]b :<C-u>Denite buffer -buffer-name=file<CR>

" ファイル検索
nnoremap <silent> <C-p> :<C-u>Denite file/rec:. -buffer-name=search-buffer<CR><C-R><C-W>
" カーソル以下の単語をgrep
nnoremap <silent> ;cg :<C-u>DeniteCursorWord grep:. -buffer-name=search-buffer<CR><C-R><C-W>
" 普通にgrep
nnoremap <silent> ;g  :<C-u>Denite grep:. -buffer-name=search-buffer<CR>
nnoremap <silent> ;y  :<C-u>Denite neoyank<CR>

"""""""""""""""""""""""""""""

" Shougo/deoplete.nvim
"""""""""""""""""""""""""""""
" <TAB>: completion.
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ deoplete#manual_complete()
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction
" <S-TAB>: completion back.
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr><C-g>       deoplete#refresh()
inoremap <expr><C-e>       deoplete#cancel_popup()
inoremap <silent><expr><C-l>       deoplete#complete_common_string()
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function() abort
  return pumvisible() ? deoplete#close_popup()."\<CR>" : "\<CR>"
endfunction
"""""""""""""""""""""""""""""

endif
"""""""""""""""""""""""""""""
