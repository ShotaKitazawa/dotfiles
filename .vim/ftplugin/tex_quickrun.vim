let g:quickrun_config.tex = {
\ 'command': 'latexmk',
\ 'outputter' : 'error',
\ 'outputter/buffer/split': '5',
\ 'outputter/error/success' : 'null',
\ 'outputter/error/error' : 'quickfix',
\ 'srcfile' : expand("%"),
\ 'cmdopt': '-pdfdvi',
\ 'hook/sweep/files' : [
\                      '%S:p:r.aux',
\                      '%S:p:r.bbl',
\                      '%S:p:r.blg',
\                      '%S:p:r.dvi',
\                      '%S:p:r.fdb_latexmk',
\                      '%S:p:r.fls',
\                      '%S:p:r.log',
\                      '%S:p:r.out'
\                      ],
\ 'exec': '%c %o %a %s',
\}

nnoremap <silent><F5> :QuickRun -type tex<CR>
"autocmd BufWritePost,FileWritePost *.tex QuickRun tex
