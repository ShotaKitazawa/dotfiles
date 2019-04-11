set noexpandtab
set tabstop=4
set shiftwidth=4
nnoremap :im :GoImport
nnoremap tt :GoFmt<CR>:GoImports<CR>
let g:auto_save = 0
autocmd FileType go :highlight goErr cterm=bold ctermfg=214
autocmd FileType go :match goErr /\<err\>/

" http://qiita.com/izumin5210/items/1f3c312edd7f0075b09c
"""""""""""""""""""""""""""""
" scrooloose/syntastic
"""""""""""""""""""""""""""""
let g:syntastic_mode_map = { 'mode': 'passive',
    \ 'active_filetypes': ['go'] }
let g:syntastic_go_checkers = ['go', 'golint']
"""""""""""""""""""""""""""""

" http://qiita.com/koara-local/items/6c886eccfb459159c431
"""""""""""""""""""""""""""""
" fatih/vim-go
"""""""""""""""""""""""""""""
let g:go_addtags_transform = "snakecase"
let g:go_auto_sameids = 1
let g:go_auto_type_info = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators= 1
let g:go_highlight_spellcheck = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_template_autocreate = 0
"""""""""""""""""""""""""""""

" deoplete-plugins/deoplete-go
"""""""""""""""""""""""""""""
g:deoplete#sources#go#gocode_binary = .globpath($GOPATH, "bin/gocode")
let g:deoplete#sources#go#package_dot = 1
"""""""""""""""""""""""""""""

