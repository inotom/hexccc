" To convert hex color character code
"
" File: hexccc.vim
" file created in 2014/08/18 10:31:49.
" LastUpdated:2014/08/18 11:46:06.
" Author: iNo <wdf7322@yahoo.co.jp>
" Version: 1.0
" License: MIT License {{{
"   Permission is hereby granted, free of charge, to any person obtaining
"   a copy of this software and associated documentation files (the
"   "Software"), to deal in the Software without restriction, including
"   without limitation the rights to use, copy, modify, merge, publish,
"   distribute, sublicense, and/or sell copies of the Software, and to
"   permit persons to whom the Software is furnished to do so, subject to
"   the following conditions:
"
"   The above copyright notice and this permission notice shall be included
"   in all copies or substantial portions of the Software.
"
"   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
"   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
"   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
"   IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
"   CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
"   TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
"   SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
" }}}
"

if exists('g:loaded_hexccc')
  finish
endif
let g:loaded_hexccc = 1

let s:save_cpo = &cpo
set cpo&vim


function! s:setNewLine(num, text, isToUpper)
  let toCharacterCase = a:isToUpper ? 'toupper' : 'tolower'
  let newline = substitute(a:text, '\v(#(\x{6}|\x{3}))', '\=' . toCharacterCase . '(submatch(1))', 'g')
  call setline(a:num, newline)
endfunction

function! s:convertSingleLine(l1, isToUpper)
  call s:setNewLine(a:l1, getline(a:l1), a:isToUpper)
endfunction

function! s:convertMultiLines(l1, l2, isToUpper)
  let lines = getline(a:l1, a:l2)
  let i = a:l1
  while i <= a:l2
    call s:setNewLine(i, getline(i), a:isToUpper)
    let i += 1
  endwhile
endfunction

function! s:convert(l1, l2, isToUpper) range
  if a:l1 == a:l2
    call s:convertSingleLine(a:l1, a:isToUpper)
  else
    call s:convertMultiLines(a:l1, a:l2, a:isToUpper)
  endif
endfunction

command! -range Hextoupper :<line1>,<line2>call s:convert(<line1>, <line2>, 1)
command! -range Hextolower :<line1>,<line2>call s:convert(<line1>, <line2>, 0)


let &cpo = s:save_cpo
unlet s:save_cpo

" vim:fdl=0 fdm=marker:ts=2 sw=2 sts=0:
