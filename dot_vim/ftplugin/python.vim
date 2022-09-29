" indent guides
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"IndentGuidesEnable
let g:indent_guides_auto_colors=0
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1
hi IndentGuidesOdd  ctermbg=black
hi IndentGuidesEven ctermbg=black
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Lsp Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap tt :LspDocumentFormat<CR>
nmap <silent> <f2> :LspRename<CR>
nmap <silent> <Leader>d :LspDefinition<CR>
nmap <silent> <Leader>r :LspReferences<CR>
nmap <silent> <Leader>i :LspImplementation<CR>
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:asyncomplete_popup_delay = 200
let g:lsp_text_edit_enabled = 0
let g:lsp_settings = {
\   'pyls-all': {
\     'workspace_config': {
\       'pyls': {
\         'configurationSources': ['flake8']
\       }
\     }
\   },
\}

" Other Setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let $PATH = "~/.pyenv/shims:".$PATH
nnoremap <F5> :!python3 %<CR>
let g:auto_save = 0
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
