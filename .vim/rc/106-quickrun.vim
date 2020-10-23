" TODO: 動作しない
"if empty(globpath(&rtp, 'thinca/vim-quickrun'))
"  finish
"endif

"set splitbelow
call quickrun#module#register(shabadou#make_quickrun_hook_anim(
\	"executing",
\	['|','/','-','\'],
\	12,
\), 1)
let g:quickrun_config = {
\   "_" : {
\       "hook/executing/enable" : 1,
\       "hook/executing/wait" : 20,
\       "outputter/buffer/split" : ":botright 8",
\       "runner" : "vimproc",
\       "runner/vimproc/updatetime" : 40,
\   }
\}
