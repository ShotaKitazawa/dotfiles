"nmap <F5> :!python3 %
"nmap <F6> :!py.test --pep8 %

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" http://myenigma.hatenablog.com/entry/2015/12/28/091342
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" autopep 
" original http://stackoverflow.com/questions/12374200/using-uncrustify-with-vim/15513829#15513829

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
    "--ignote=E501: 一行の長さの補正を無視"
    call Preserve(':silent %!autopep8 --ignore=E501 -')
endfunction

" Shift + F でautopep自動修正
nnoremap <S-f> :call Autopep8()<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" http://qiita.com/tekkoc/items/923d7a7cf124e63adab5
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:syntastic_mode_map = {
            \ 'mode': 'active',
            \ 'active_filetypes': ['php', 'coffeescript', 'sh', 'vim'],
            \ 'passive_filetypes': ['html', 'haskell', 'python']
            \}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
