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
  if empty(glob(s:dein_dir . '/cache_vim74'))
    execute '!cd' s:dein_repo_dir . '; git checkout 1.0 > /dev/null 2>&1; touch' s:dein_dir . '/cache_vim74'
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
""""""""""""""""""""""""""""""

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

" scrooloose/nerdtree
"""""""""""""""""""""""""""""
nnoremap :tree :NERDTreeToggle
"""""""""""""""""""""""""""""

" kana/vim-submode
"""""""""""""""""""""""""""""
" http://nanasi.jp/articles/howto/file/expand.html
"""""""""""""""""""""""""""""
" 新Unite tab作成
nnoremap sT :<C-u>Unite tab<CR>
"
nnoremap sb :<C-u>Unite buffer_tab -buffer-name=file<CR>
nnoremap sB :<C-u>Unite buffer -buffer-name=file<CR>
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

" tyru/open-browser.vim
"""""""""""""""""""""""""""""
" カーソル下のURLをブラウザで開く
nnoremap <Leader>o <Plug>(openbrowser-open)
vnoremap <Leader>o <Plug>(openbrowser-open)
" ググる
nnoremap <Leader>g :<C-u>OpenBrowserSearch<Space><C-r><C-w><Enter>
"""""""""""""""""""""""""""""

" vim-scripts/vim-auto-save
"""""""""""""""""""""""""""""
" すかさずファイルを自動保存
let g:auto_save = 1
"""""""""""""""""""""""""""""

" bronson/vim-trailing-whitespace
" + Tab をスペース2つに変換
""""""""""""""""""""""""""""""
noremap tw :FixWhitespace<CR>:%s/\t/    /g<CR>
""""""""""""""""""""""""""""""

" tpope/vim-fugitive
""""""""""""""""""""""""""""""
nnoremap :gs :Gstatus
nnoremap :ga :Gwrite
nnoremap :gr :Gread
nnoremap :gc :Gcommit
nnoremap :gb :Gblame
nnoremap :gd :Gdiff
""""""""""""""""""""""""""""""

" hotwatermorning/auto-git-diff
"""""""""""""""""""""""""""""
let g:auto_git_diff_disable_auto_update = 1
nmap <Leader>gd <Plug>(auto_git_diff_manual_update)
"""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
" plasticboy/vim-markdown + kannokanno/previm + tyru/open-browser.vim
""""""""""""""""""""""""""""""
" http://qiita.com/uedatakeshi/items/31761b87ba8ecbaf2c1e
""""""""""""""""""""""""""""""
au BufRead,BufNewFile *.md set filetype=markdown
let g:previm_open_cmd = 'open -a Firefox'
nnoremap :md :PrevimOpen
""""""""""""""""""""""""""""""

" mattn/sonictemplate-vim
"""""""""""""""""""""""""""""
let g:sonictemplate_vim_template_dir = [
      \ '~/.cache/sonictemplate'
      \]
"""""""""""""""""""""""""""""

" haya14busa/vim-poweryank
"""""""""""""""""""""""""""""
map <Leader>y <Plug>(operator-poweryank-osc52)
"""""""""""""""""""""""""""""

" Status Line
"""""""""""""""""""""""""""""
" Git
set statusline+=%{fugitive#statusline()}

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


" glidenote/memolist.vim
"""""""""""""""""""""""""""""
let g:memolist_memo_suffix = "md"

"""""""""""""""""""""""""""""
" setting for nvim
"""""""""""""""""""""""""""""
if has('nvim')

" Shougo/denite.nvim
"""""""""""""""""""""""""""""
    call denite#custom#var('file_rec', 'command', ['ag', '--follow', '-g', ''])
    call denite#custom#var('grep', 'command', ['ag'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'pattern_opt', [])
    call denite#custom#var('grep', 'default_opts', ['--follow'])
    call denite#custom#map('insert', "<C-j>", '<denite:move_to_next_line>')
    call denite#custom#map('insert', "<C-k>", '<denite:move_to_previous_line>')
    call denite#custom#map('insert', "<C-t>", '<denite:do_action:tabopen>')
    call denite#custom#map('insert', "<C-v>", '<denite:do_action:vsplit>')
    call denite#custom#map('normal', "v", '<denite:do_action:vsplit>')

nnoremap <silent> <C-p> :<C-u>Denite file:. -buffer-name=search-buffer<CR><C-R><C-W>
" カーソル以下の単語をgrep
nnoremap <silent> ;cg :<C-u>DeniteCursorWord grep:. -buffer-name=search-buffer<CR><C-R><C-W>
" 普通にgrep
nnoremap <silent> ;g  :<C-u>Denite grep:. -buffer-name=search-buffer<CR>
nnoremap <silent> ;y  :<C-u>Denite neoyank<CR>

" Shougo/deoplete.vim
"""""""""""""""""""""""""""""
" https://github.com/Shougo/shougo-s-github/blob/master/vim/rc/plugins/deoplete.rc.vim
"
" <TAB>: completion.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ deoplete#manual_complete()
function! s:check_back_space() abort "{{{
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

" <S-TAB>: completion back.
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<C-h>"

" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> deoplete#smart_close_popup()."\<C-h>"

" inoremap <expr><C-g> deoplete#undo_completion()
" <C-l>: redraw candidates
inoremap <expr><C-g>       deoplete#refresh()
inoremap <silent><expr><C-l>       deoplete#complete_common_string()

" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function() abort
  return deoplete#cancel_popup() . "\<CR>"
endfunction

inoremap <expr> '  pumvisible() ? deoplete#close_popup() : "'"

" call deoplete#custom#source('_', 'matchers', ['matcher_head'])
"call deoplete#custom#source('ghc', 'sorters', ['sorter_word'])
" call deoplete#custom#source('buffer', 'mark', '')
" call deoplete#custom#source('_', 'matchers', ['matcher_full_fuzzy'])
" call deoplete#custom#source('_', 'disabled_syntaxes', ['Comment', 'String'])
" call deoplete#custom#source('buffer', 'mark', '*')

" Use auto delimiter
" call deoplete#custom#source('_', 'converters',
"       \ ['converter_auto_paren',
"       \  'converter_auto_delimiter', 'remove_overlap'])
"call deoplete#custom#source('_', 'converters', [
"      \ 'converter_remove_paren',
"      \ 'converter_remove_overlap',
"      \ 'converter_truncate_abbr',
"      \ 'converter_truncate_menu',
"      \ 'converter_auto_delimiter',
"      \ ])
"
" call deoplete#custom#source('buffer', 'min_pattern_length', 9999)
"call deoplete#custom#source('clang', 'input_pattern', '\.\w*|\.->\w*|\w+::\w*')
"call deoplete#custom#source('clang', 'max_pattern_length', -1)

let g:deoplete#keyword_patterns = {}
let g:deoplete#keyword_patterns._ = '[a-zA-Z_]\k*\(?'
" let g:deoplete#keyword_patterns.tex = '\\?[a-zA-Z_]\w*'
let g:deoplete#keyword_patterns.tex = '[^\w|\s][a-zA-Z_]\w*'

let g:deoplete#omni#input_patterns = {}
let g:deoplete#omni#input_patterns.python = ''
let g:deoplete#omni#functions = {}

" inoremap <silent><expr> <C-t> deoplete#manual_complete('file')

let g:deoplete#enable_refresh_always = 0
let g:deoplete#enable_camel_case = 1
" let g:deoplete#auto_complete_delay = 50
" let g:deoplete#auto_complete_start_length = 3

let g:deoplete#skip_chars = ['(', ')']

" let g:deoplete#enable_profile = 1
" call deoplete#enable_logging('DEBUG', 'deoplete.log')
" call deoplete#custom#source('clang', 'debug_enabled', 1)
"""""""""""""""""""""""""""""

endif
