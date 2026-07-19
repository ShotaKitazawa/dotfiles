if empty(globpath(&rtp, 'plugin/fzf.vim'))
  finish
endif

if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
endif

nnoremap <C-p> :Files<CR>
nnoremap <Leader>f :Rg<CR>
