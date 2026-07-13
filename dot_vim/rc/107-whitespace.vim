if empty(globpath(&rtp, 'plugin/better-whitespace.vim'))
  finish
endif

noremap tw :FixWhitespace<CR>:%s/\t/    /g<CR>
