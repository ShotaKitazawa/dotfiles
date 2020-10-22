set noexpandtab
set tabstop=4
set shiftwidth=4
let g:auto_save = 0
autocmd FileType go :highlight goErr cterm=bold ctermfg=214
autocmd FileType go :match goErr /\<err\>/

nnoremap tt :GoImportRun<CR>
nmap <silent> <f2> :LspRename<CR>
nmap <silent> <Leader>d :LspDefinition<CR>
nmap <silent> <Leader>r :LspReferences<CR>
nmap <silent> <Leader>i :LspImplementation<CR>
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:asyncomplete_popup_delay = 200
let g:lsp_text_edit_enabled = 0
