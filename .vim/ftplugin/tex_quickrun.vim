let g:quickrun_config = {
\   'tex': {
\       'command': 'latexmk',
\       'exec': '%c -gg -pdfdvi %s',
\       'outputter/buffer/split': '5'
\   },
\}

" QuickRun and view compile result quickly (but don't preview pdf file)
nnoremap <silent><F5> :w<CR>:QuickRun<Space>tex<CR>:!open<Space>$(echo<Space>'%'<Space>\|<Space>sed<Space>-e<Space>'s/\.tex/.pdf/g')<CR><CR>

"autocmd BufWritePost,FileWritePost *.tex QuickRun tex
