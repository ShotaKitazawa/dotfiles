" http://myenigma.hatenablog.com/entry/2015/12/28/091342
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" autopep 
" original http://stackoverflow.com/questions/12374200/using-uncrustify-with-vim/15513829#15513829
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
    "--ignote=E501: $B0l9T$ND9$5$NJd@5$rL5;k(B"
    call Preserve(':silent %!autopep8 --ignore=E501 -')
endfunction

" Shift + F $B$G(Bautopep$B<+F0=$@5(B
nnoremap <S-f> :call Autopep8()<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" http://qiita.com/tekkoc/items/923d7a7cf124e63adab5
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:syntastic_mode_map = {
            \ 'mode': 'active',
            \ 'active_filetypes': ['php', 'coffeescript', 'sh', 'vim'],
            \ 'passive_filetypes': ['html', 'haskell', 'python']
            \}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" http://hachibeechan.hateblo.jp/entry/vim-customize-for-python
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if version < 600
  syntax clear
elseif exists('b:current_after_syntax')
  finish
endif

" We need nocompatible mode in order to continue lines with backslashes.
" Original setting will be restored.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

" Other Setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <F5> :!python3 %<CR>
nmap <F6> :!py.test --pep8 %<CR>
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class

IndentGuidesEnable
let g:indent_guides_auto_colors = 0
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1
hi IndentGuidesOdd  ctermbg=darkgrey
hi IndentGuidesEven ctermbg=grey
colorscheme jellybeans

let g:jedi#completions_command = "<C-N>"
