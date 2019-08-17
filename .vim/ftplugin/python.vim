" http://hachibeechan.hateblo.jp/entry/vim-customize-for-python
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if version < 600
  syntax clear
elseif exists('b:current_after_syntax')
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

syn match pythonOperator "\(+\|=\|-\|\^\|\*\)"
syn match pythonDelimiter "\(,\|\.\|:\)"
syn keyword pythonSpecialWord self

hi link pythonSpecialWord    Special
hi link pythonDelimiter      Special

let b:current_after_syntax = 'python'

let &cpo = s:cpo_save
unlet s:cpo_save
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" jedi
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set completeopt-=preview
let g:jedi#use_tabs_not_buffers = 1
let g:jedi#force_py_version=3
let g:jedi#completions_command = "<C-n>"
setlocal omnifunc=jedi#completions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" supertab
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:SuperTabDefaultCompletionType = "<c-n>"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" ale
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" https://qiita.com/lighttiger2505/items/9a36c5b4035dd469134c
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" flake8をLinterとして登録
let g:ale_linters = {
    \ 'python': ['flake8'],
    \ }

" 各ツールをFixerとして登録
let g:ale_fixers = {
    \ 'python': ['autopep8', 'black', 'isort'],
    \ }

" 各ツールの実行オプションを変更してPythonパスを固定
let g:ale_python_flake8_executable = g:python3_host_prog
let g:ale_python_flake8_options = '-m flake8'
let g:ale_python_autopep8_executable = g:python3_host_prog
let g:ale_python_autopep8_options = '-m autopep8'
let g:ale_python_isort_executable = g:python3_host_prog
let g:ale_python_isort_options = '-m isort'
let g:ale_python_black_executable = g:python3_host_prog
let g:ale_python_black_options = '-m black'

" ついでにFixを実行するマッピングしとく
nmap <silent> <Leader>x <Plug>(ale_fix)
nmap tt <Plug>(ale_fix)
" ファイル保存時に自動的にFixするオプションもあるのでお好みで
let g:ale_fix_on_save = 0
" TODO: E501の自動改行が効かないので無視する
let g:ale_python_flake8_args = '--ignore=E501'
let g:ale_python_flake8_executable = 'flake8'
let g:ale_python_flake8_options = '--ignore=E501'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" indent guides
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
IndentGuidesEnable
let g:indent_guides_auto_colors=0
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1
hi IndentGuidesOdd  ctermbg=black
hi IndentGuidesEven ctermbg=black
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Other Setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let $PATH = "~/.pyenv/shims:".$PATH
nnoremap <F5> :!python3 %<CR>
let mapleader = "\<Space>"
let g:auto_save = 0
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
