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
syn region gjfRootr start=/^#/ end=/^$/ contains=@gjfdft,gjfComment,gjfroot keepend
syn match gjfroot contained "^#\(P\|M\)\?\>"
" dft keywords
syn cluster gjfdft contains=gjfHdft,gjfPdft,gjfPsdft
syn keyword gjfHdft contained b3lyp B3P86 O3LYP APFD wB97XD LC-wHPBE LC-wPBE CAM-B3LYP wB97XD
                            \ wB97 wB97X MN15 M11 SOGGA11X N12SX MN12SX PW6B95 PW6B95D3
                            \ M08HX M06 M06HF M062X M05 M052X PBE1PBE HSEH1PBE OHSE2PBE OHSE1PBE PBEh1PBE
                            \ B1B95 B1LYP mPW1PW91 mPW1LYP mPW1PBE mPW3PBE B98 B971 B972 TPSSh tHCTHhyb
                            \ BMK HISSbPBE X3LYP BHandH BHandHLYP
syn match gjfPdft contained "\<\(lc-\)\?\(S\|XA\|B\|PW91\|mPW\|G96\|PBE\|O\|TPSS\|revTPSS\|BRx\|PKZB\|wPBEh\|PBEh\)\(VWN\|VWN5\|LYP\|PL\|P86\|PW91\|B95\|PBE\|TPSS\|revTPSS\|KCIS\|BRC\|PKZB\|VP86\|V5LYP\)\>"
syn keyword gjfPsdft contained VSXC HCTH HCTH93 HCTH147 HCTH407 tHCTH B97D B97D3 M06L SOGGA11 M11L MN12L N12 MN15L

"Last line must be empty
syn match gjfLast /^.\+\%$/

"Let there be colour
let b:current_syntax = "gjf"
hi def link gjfTodo      Todo
hi def link gjfComment   Comment
hi def link GjfBlockCmd  Statement
hi def link gjfLink0      PreProc
hi def link GjfFloat     Float
hi def link gjfPsdft Identifier
hi def link gjfroot Identifier
"hi def link gjfRoot Identifier
hi def link gjfLast ErrorMsg
" root section colors
hi def link gjfHdft gjfroot
hi def link gjfPdft gjfroot
hi def link gjfPsdft gjfroot
hi def link gjfhash gjfroot
