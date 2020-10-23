" TODO: 動作しない
"if empty(globpath(&rtp, 'tpope/vim-fugitive'))
"  finish
"endif

nnoremap :gs :Gstatus
nnoremap :ga :Gwrite
nnoremap :gr :Gread
nnoremap :gc :Gcommit
nnoremap :gb :Gblame
nnoremap :gd :Gdiff
set statusline+=%{fugitive#statusline()}


if empty(globpath(&rtp, 'hotwatermorning/auto-git-diff'))
  finish
endif

let g:auto_git_diff_disable_auto_update = 1
nmap <Leader>gd <Plug>(auto_git_diff_manual_update)
