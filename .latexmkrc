#!/usr/bin/perl
#https://qiita.com/ssh0/items/4aea2d3849667717b36d

$latex = 'platex -interaction=nonstopmode -kanji=utf-8 -synctex=1 %O %S';
$dvipdf = 'dvipdfmx %O -o %D %S';
$bibtex = 'pbibtex';
$pdf_mode = 3;
$pdf_update_method = 2;
$max_repeat = 5;

if ($^O eq 'darwin') {
  $pdf_previewer = 'open';
} elsif ($^O eq 'linux') {
  $pdf_previewer = 'evince';
}
