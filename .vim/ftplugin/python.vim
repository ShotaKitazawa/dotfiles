" Autopep8
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! Preserve(command)
    " Save the last search.
    let search = @/
    " Save the current cursor position.
    let cursor_position = getpos('.')
    " Save the current window position.
    normal! H
    let window_position = getpos('.')
    call setpos('.', cursor_position)
    " Execute the command.
    execute a:command
    " Restore the last search.
    let @/ = search
    " Restore the previous window position.
    call setpos('.', window_position)
    normal! zt
    " Restore the previous cursor position.
    call setpos('.', cursor_position)
endfunction

function! Autopep8()
    "--ignote=E501: $B0l9T$ND9$5$NJd@5$rL5;k(B"
    call Preserve(':silent %!autopep8 --ignore=E501 -')
endfunction
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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

" syntastic
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:syntastic_python_checkers = ['python', 'flake8', 'mypy']
let g:syntastic_python_checkers = ['python', 'flake8']
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_python_flake8_args = "--ignore=E501"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" vim-flake8
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"autocmd BufWritePost *.py call Flake8()
"autocmd FileType python map <buffer> tt :call Autopep8()<CR>:call Flake8()<CR>
nnoremap tt :call<Space>Autopep8()<CR>:call<Space>Flake8()<CR>
let g:flake8_ignore = 'E501'
let g:flake8_show_quickfix=0
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
