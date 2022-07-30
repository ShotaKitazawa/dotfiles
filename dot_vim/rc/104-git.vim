" TODO: 動作しない
"if empty(globpath(&rtp, 'tpope/vim-fugitive'))
"  finish
"endif

nnoremap :gs :Git status
nnoremap :ga :Git write
nnoremap :gr :Git read
nnoremap :gc :Git commit
nnoremap :gb :Git blame
nnoremap :gd :Git diff
set statusline+=%{fugitive#statusline()}


if empty(globpath(&rtp, 'hotwatermorning/auto-git-diff'))
  finish
endif

let g:auto_git_diff_disable_auto_update = 1
nmap <Leader>gd <Plug>(auto_git_diff_manual_update)
