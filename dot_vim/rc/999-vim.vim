" NOTE: rc/*.vim はファイル名の辞書順(000,001,...,100,...,999)で読み込まれるため、
" このファイルは常に最後に読み込まれる。ここでの clipboard 設定は 000-setting.vim の
" `set clipboard+=unnamedplus` を非 Neovim 環境向けに意図的に上書きするためのものであり、
" 事故ではない。
if !has('nvim')
  set clipboard=unnamed,autoselect
  " 未指定だと自動判定は xterm2(legacy)止まり(sgr への自動昇格は
  " Terminal.app/iTerm2/mintty 限定で、ghostty 等は対象外)なので明示する。
  set ttymouse=sgr
endif
