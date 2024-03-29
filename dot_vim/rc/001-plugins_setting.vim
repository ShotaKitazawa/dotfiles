let g:plug_shallow = 0
call plug#begin('~/.cache/plugged')
" Color Schema
Plug 'w0ng/vim-hybrid'
Plug 'nanotech/jellybeans.vim'
" vim-surround
Plug 'tpope/vim-surround'
" vimproc
Plug 'Shougo/vimproc'
" status line
Plug 'itchyny/lightline.vim'
" filer
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'ryanoasis/vim-devicons'
" Fuzzy finder
Plug 'ctrlpvim/ctrlp.vim'
Plug 'rking/ag.vim'
" コンテキストによって filetype 自動切り替え
Plug 'Shougo/context_filetype.vim'
" 窓移動系
Plug 'kana/vim-operator-user'
Plug 'kana/vim-submode'
" インデント表示
Plug 'nathanaelkane/vim-indent-guides'
" 文末空白の可視化
Plug 'ntpeters/vim-better-whitespace'
" Git 操作
Plug 'tpope/vim-fugitive'
Plug 'hotwatermorning/auto-git-diff'
" OSC52
Plug 'ojroques/vim-oscyank', {'branch': 'main'}
" 日本語の w, b, e 移動補助
Plug 'deton/jasegment.vim'
" オートセーブ
Plug 'vim-scripts/vim-auto-save'
" vim からブラウザを開く
Plug 'tyru/open-browser.vim'
" QuickRun
Plug 'thinca/vim-quickrun'
Plug 'osyo-manga/shabadou.vim'
" memolist
Plug 'glidenote/memolist.vim'
" Language Server
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
" Completion
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/asyncomplete-buffer.vim'
Plug 'prabirshrestha/asyncomplete-file.vim'
Plug 'Shougo/neco-syntax'
Plug 'prabirshrestha/asyncomplete-necosyntax.vim'
" Common syntax hilight
Plug 'sheerun/vim-polyglot'
" Golang
Plug 'mattn/vim-goimports', { 'for': 'go' }
" HTML
Plug 'mattn/emmet-vim', { 'for': 'html' }
" Markdown
Plug 'godlygeek/tabular', { 'for': 'markdown' }
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'kannokanno/previm', { 'for': 'markdown' }
" Toml
Plug 'cespare/vim-toml', { 'for': 'toml' }
" Tex
Plug 'lervag/vimtex', { 'for': ['tex', 'latex'] }
" Terraform
Plug 'hashicorp/terraform', { 'for': 'tf' }
Plug 'hashivim/vim-terraform', { 'for': 'tf' }
" Dockerfile
Plug 'ekalinin/Dockerfile.vim', { 'for': 'dockerfile' }
" Jinja2
Plug 'Glench/Vim-Jinja2-Syntax', { 'for': 'jinja' }
" Jsonnet
Plug 'google/vim-jsonnet', { 'for': 'jsonnet' }
" Cue
Plug 'jjo/vim-cue', { 'for': 'cue' }
" Rego
Plug 'tsandall/vim-rego', { 'for': 'rego' }
" GraphQL
Plug 'jparise/vim-graphql'
call plug#end()

""""""""""""""""""""""""""""""
" plasticboy/vim-markdown
""""""""""""""""""""""""""""""
let g:vim_markdown_folding_disabled = 1
""""""""""""""""""""""""""""""
" ojroques/vim-oscyank
""""""""""""""""""""""""""""""
noremap <leader>y :OSCYankVisual<cr>
""""""""""""""""""""""""""""""
" tyru/open-browser.vim
""""""""""""""""""""""""""""""
" Open URL
nnoremap <Leader>o <Plug>(openbrowser-open)
vnoremap <Leader>o <Plug>(openbrowser-open)
" Search on Google
nnoremap <Leader>g :<C-u>OpenBrowserSearch<Space><C-r><C-w><Enter>
""""""""""""""""""""""""""""""
" glidenote/memolist.vim
""""""""""""""""""""""""""""""
let g:memolist_memo_suffix = "md"
if isdirectory($HOME . "/Google Drive/マイドライブ")
  let g:memolist_path = $HOME . "/Google Drive/マイドライブ/Memo"
endif
""""""""""""""""""""""""""""""
" prabirshrestha/asyncomplete.vim
""""""""""""""""""""""""""""""
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"
"inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
"inoremap <expr> <cr> pumvisible() ? asyncomplete#close_popup() . "\<cr>" : "\<cr>"
imap <c-space> <Plug>(asyncomplete_force_refresh)
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
""""""""""""""""""""""""""""""
" prabirshrestha/asyncomplete-buffer.vim
""""""""""""""""""""""""""""""
call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
    \ 'name': 'buffer',
    \ 'allowlist': ['*'],
    \ 'completor': function('asyncomplete#sources#buffer#completor'),
    \ 'config': {
    \    'max_buffer_size': 5000000,
    \  },
    \ }))
""""""""""""""""""""""""""""""
" prabirshrestha/asyncomplete-necosyntax.vim
""""""""""""""""""""""""""""""
au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#necosyntax#get_source_options({
    \ 'name': 'necosyntax',
    \ 'allowlist': ['*'],
    \ 'completor': function('asyncomplete#sources#necosyntax#completor'),
    \ }))
""""""""""""""""""""""""""""""
" prabirshrestha/asyncomplete-file.vim
""""""""""""""""""""""""""""""
au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
    \ 'name': 'file',
    \ 'allowlist': ['*'],
    \ 'priority': 10,
    \ 'completor': function('asyncomplete#sources#file#completor')
    \ }))
""""""""""""""""""""""""""""""
