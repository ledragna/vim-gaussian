" Vim syntax file
" Language: Gaussian16 Input Files
" Maintainer: Marco Fuse'
" Latest Revision: 24 May 2021

if exists("b:current_syntax")
  finish
endif

" Ignore case Fortran Based
syn case ignore

" Integer with - + or nothing in front
syn match gjfNumber '\d\+'
syn match gjfNumber '[-+]\d\+'

" Floating point number with decimal no E or e
syn match gjfFloat '[-+]\d\+\.\d*'

" Floating point like number with E and no decimal point (+,-)
syn match gjfFloat '[-+]\=\d[[:digit:]]*[eE][\-+]\=\d\+'
syn match gjfFloat '\d[[:digit:]]*[eE][\-+]\=\d\+'

" Floating point like number with E and decimal point (+,-)
syn match gjfFloat '[-+]\=\d[[:digit:]]*\.\d*[eE][\-+]\=\d\+'
syn match gjfFloat '\d[[:digit:]]*\.\d*[eE][\-+]\=\d\+'

" floating point number, D or Q exponents
syn match gjfFloat  display "\<\d\+\.\d\+\([dq][-+]\=\d\+\)\=\(_\a\w*\)\=\>"


" Link 0 Commands
" syn keyword gjfLink0 %mem= %nprocshared= nextgroup=gjfNumber
" chk oldchk schk rwf oldmatrix oldraw matrix int d2e
" link0 directives can be only at the beginning of the file before #
" \ze set the pointer before #, in this way ^# can be used for start
syn region gjfL0r start=/\%1l/ end=/\ze#/ contains=@gjfL0k keepend
syn cluster gjfL0k contains=gjfL0d,gjfL0chk,gjfL0rwf,gjfL0str,gjfL0lon,gjfL0kjb,gjfL0sub
syn match gjfL0d contained "^%\(mem\|nprochared\)=\d\+\([mg]b\|[mg]w\|w\)\?\>" contains=gjfLink0
syn match gjfL0chk contained "^%\(chk\|oldchk\|schk\)=\i\+\.chk\>" contains=gjfLink0
" FIXME the gjfL0rwf not correct
syn match gjfL0rwf contained "^%rwf=\i\+\.rwf\>\(,\i\+\.rwf\>\)\?" contains=gjfLink0
syn match gjfL0str contained "^%\(oldmatrix\|oldraw\|matrix\|int\|d2e\)=\i\+\>" contains=gjfLink0
syn match gjfL0lon contained "^%\(save\|errorsave\)\>" contains=gjfLink0
" FIXME gjfL0kjb should be followed only by digits
syn match gjfL0kjb contained "^%KJob\sL\d\+\(\s\d\+\)\?\>" contains=gjfLink0
syn match gjfL0sub contained "^%Subst\sL\d\+\s\i\+\>" contains=gjfLink0
syn match gjfLink0 "%\(mem\|nprochared\|chk\|oldchk\|schk\|rwf\|oldmatrix\|oldrawmatrix\|OldRaw\|int\|d2e\|KJob\|save\|ErrorSave\|Subst\)" contained

" Comments
syn keyword gjfTodo containedin=gjfComment contained TODO FIXME XXX NOTE
syn match gjfComment "!.*$" contains=gjfTodo,@Spell

" Root section
syn region gjfRoot start=/^#/ end=/^$/ contains=gjfComment keepend

"Last line must be empty
syn match gjfLast /^.\+\%$/

"Let there be colour
let b:current_syntax = "gjf"
hi def link gjfTodo      Todo
hi def link gjfComment   Comment
hi def link GjfBlockCmd  Statement
hi def link gjfLink0      PreProc
hi def link GjfFloat     Float
hi def link gjfRoot Identifier
hi def link gjfLast ErrorMsg
