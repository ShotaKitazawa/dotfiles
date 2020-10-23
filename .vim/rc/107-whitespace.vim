" TODO: 動作しない
"if empty(globpath(&rtp, 'bronson/vim-trailing-whitespace'))
"  finish
"endif

noremap tw :FixWhitespace<CR>:%s/\t/    /g<CR>
