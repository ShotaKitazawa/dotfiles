set noexpandtab
set tabstop=4
set shiftwidth=4
let g:auto_save = 0
let mapleader = "\<Space>"
autocmd FileType go :highlight goErr cterm=bold ctermfg=214
autocmd FileType go :match goErr /\<err\>/

" http://qiita.com/izumin5210/items/1f3c312edd7f0075b09c
"""""""""""""""""""""""""""""
" scrooloose/syntastic
"""""""""""""""""""""""""""""
let g:syntastic_mode_map = {
    \ 'mode': 'active',
    \ 'active_filetypes': ['go'] }
"TODO: go vet 打てない
"let g:syntastic_go_checkers = ['go', 'golint', 'go vet']
let g:syntastic_go_checkers = ['go', 'golint']
"""""""""""""""""""""""""""""

" http://qiita.com/koara-local/items/6c886eccfb459159c431
"""""""""""""""""""""""""""""
" fatih/vim-go
"""""""""""""""""""""""""""""
let g:go_addtags_transform = "snakecase"
let g:go_auto_sameids = 0
"let g:go_auto_type_info = 1
let g:go_auto_type_info = 0
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators= 1
ret g:go_highlight_spellcheck = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_template_autocreate = 0
"let g:go_def_mode='gopls'

nnoremap tt :GoImports<CR>
nnoremap t<C-]> :GoRename<CR>
nnoremap ta :GoAddTags<CR>
nnoremap <Leader>d :GoDef<CR>
nnoremap <Leader>s :split<CR>:GoDef<CR><CR>
nnoremap <Leader>v :vsplit<CR>:GoDef<CR><CR>
"nnoremap <C-O> :GoDefPop<CR>
"""""""""""""""""""""""""""""

"" golsp
""""""""""""""""""""""""""""""
"augroup LspGo
"  au!
"  autocmd User lsp_setup call lsp#register_server({
"      \ 'name': 'go-lang',
"      \ 'cmd': {server_info->['gopls']},
"      \ 'whitelist': ['go'],
"      \ })
"  autocmd FileType go setlocal omnifunc=lsp#complete
"  autocmd FileType go nmap <buffer> gd <plug>(lsp-definition)
"  "autocmd FileType go nmap <buffer> <C-]> <plug>(lsp-definition)
"  "autocmd FileType go nmap <buffer> ,n <plug>(lsp-next-error)
"  "autocmd FileType go nmap <buffer> ,p <plug>(lsp-previous-error)
"augroup END
""""""""""""""""""""""""""""""

" https://budougumi0617.github.io/2018/10/22/deug-gocode-and-vim-go-auto-completion/
""""""""""""""""""""""""""""""
let g:go_gocode_propose_source = 0
