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

" bracket 
syn cluster gjfParA contains=gjfParen,gjfParenClos,gjfParenOpen
syn match gjfParenClos contained ")"
syn match gjfParenOpen contained "("
syn match gjfParen contained "(\_[^ ]\+)" contains=gjfemp,gjfmp,gjfpopl
"syn region gifinparen contained start="(" end=")" contains=
" commas only between brackets
syn match gjfcomma contained ","
syn match gjfcommlef contained "(," contains=gjfcomma
syn match gjfcommrig contained ",)" contains=gjfcomma
syn cluster gjfgeneral contains=@gjfParA,gjfcomma,gjfcommlef,gjfcommrig

" Root section
syn region gjfRootr start=/^#/ end=/^$/ contains=@gjfMethod,gjfComment,gjfroot,@gjfgeneral,@gjfkeyopts,@gjfBS keepend
syn match gjfroot contained "^#\(P\|M\)\?\>"
" General match for keyword + options
" syn match gjfKO contained "\<\i\+\(\(=\|=(\|(\)\i\+\)\?\>" contains=@gjfkeyopts,@gjfoptions,@gjfParA,@gjfgeneral
" clusters of keeywords requiring options and options
"syn cluster gjfrtkey contains=gjfMethod,gjfmp,gjfempd
syn cluster gjfoptions contains=gjfempdoptions

" Methods
syn cluster gjfMethod contains=gjfHf,@gjfdft,gjfempalone,gjfemp,gjfmp
" HF
syn match gjfHf contained "\<\(U\|R\|RO\)\?HF\>" 
" dft keywords
syn cluster gjfdft contains=gjfHdft1,gjfHdft2,gjfHdft3,gjfPdft,gjfPsdft
" decorate dft and doublehybrid with U R and RO
"syn match gjfdftdec contained "

syn match gjfHdft1 contained /\v<(U|R|RO)?((cam-b3|b3|o3|x|mpw1)lyp|B3P86|APF(D)?|LC-w(H)?PBE|wB97(XD|X)?|MN1(1|5)|SOGGA11X)>/
syn match gjfHdft2 contained /\v<(U|R|RO)?((M)?N12SX|PW6B95(D3)?|M0(8HX|6|6HF|62x|5|52x)|(PBE1|HSEH1|OHSE2|OHSE1|PBEh1|mpw1|mpw3)PBE|B1(B95|LYP))>/
syn match gjfHdft3 contained /\v<(U|R|RO)?((mPW1|b3)PW91|B9(8|71|72)|TPSSh|tHCTHhyb|BMK|HISSbPBE|BHandH(LYP)?)>/
syn match gjfPdft contained /\v<(U|R|RO)?(lc-)?(S|XA|B|PW91|mPW|G96|PBE|O|TPSS|revTPSS|BRx|PKZB|wPBEh|PBEh)(VWN|VWN5|LYP|PL|P86|PW91|B95|PBE|TPSS|revTPSS|KCIS|BRC|PKZB|VP86|V5LYP)>/
syn match gjfPsdft contained /\v<(U|R|RO)?(VSXC|(t)?HCTH(93|147|407)?|B97D(3)?|M06L|SOGGA11|M11L|MN12L|N12|MN15L)>/
"syn keyword gjfPsdft contained VSXC HCTH HCTH93 HCTH147 HCTH407 tHCTH B97D B97D3 M06L SOGGA11 M11L MN12L N12 MN15L
" empirical dispersion
" syn match gjfemp contained "\<\i\+\(\(=\|=(\|(\)\i\+\)\?\>" contains=gjfempd,gjfempdoptions,@gjfParA,@gjfgeneral
" These options are only valid for empirical
syn match gjfemp contained "\<EmpiricalDispersion\(\(=\|=(\|(\)\(pdf\|d2\|d3\|d3bj\)[^ ]\+\)\?\>" contains=gjfempd,gjfempdoptions
syn keyword gjfempd contained EmpiricalDispersion
syn keyword gjfempdoptions contained pdf d2 d3 d3bj
"syn keyword gjfempalone contained B97D B2PLYPD mPW2PLYPD B97D3 PW6B95D3 B2PLYPD3
" double hybrid functionals
"syn keyword gjfdhybrid contained B2PLYP mPW2PLYP DSDPBEP86 PBE0DH PBEQIDH
syn match gjfempalone "\v<(U|R|RO)?(B2PLYP(D|D3)?|mPW2PLYP(D)?|DSDPBEP86|PBE0DH|PBEQIDH|B97D(3)?|PW6B95D3)>"
" MP Methods
"syn keyword gjfmp contained mp2 mp3 mp4 mp5 MP4(SDTQ) MP4(DQ) MP4(SDQ)
syn match gjfmp contained /\<\(U\|R\|RO\)\?\(mp2\|mp3\|mp4\|mp5\)\(\(=\|=(\|(\)[^ ]\+\)\?/ contains=gjfmpk,gjfmp4opt,gjfmpopt
syn match gjfmpk contained /\v<(U|R|RO)?(mp2|mp3|mp4|mp5)>/
" not working problemi with regions
syn match gjfmp4opt contained /mp4[^ ]\+\zs\<\(SDTQ\|DQ\|SDQ\)\>/
syn keyword gjfmpopt contained FC FullDirect TWInCore SemiDirect Direct InCore
"syn match gjfmp contained "\<\(U\|R\|RO\)\?\(mp2\|mp3\|mp4\|mp5\|MP4(SDTQ)\|MP4(DQ)\|MP4(SDQ)\)\>"
" BasisSets
" dunnings
syn cluster gjfBS contains=gjfdunbs,gjfgnbs,gjfpopl,gjftwastbas,gjftwastbas,gjfplusbas
syn match gjfdunbs contained /\v<((sp|d|m)?aug-|aug-|(t)?may-|(t)?june-|(t)?jul-)cc-pv(d|t|q|5|6)z>/
syn keyword gjfgnbs contained  lanl2dz lanl2mb MidiX CBSB7 MTSmall SDD[all]
" FIXME after the * needed a space 
syn match gjfpopl contained /\v<6-31(1)?(\+|\+\+)?G(\*|\*\*|\([^ ]+)?/ contains=gjfpoplebs,gjfast,gjfpoppar
syn match gjfast contained "\v*"
syn match gjfpoppar contained /\v(<(2|3)?d(f)?>|,(2|3)?p(d)?>)/ contains=gjfpopinpar
syn match gjfpopinpar contained /\v(2|3|p|d|f)/
syn match gjfpoplebs contained /\v6-31(1)?(\+|\+\+)?G>/
" only +
syn match gjfplusbas contained /\v<(3-21(\+)?G|CBSB7(\+|\+\+)?|sto-3g|EPR-II|EPR-III)>/
" only one *
syn match gjfnoparbas contained /\(6-21G\|4-31G\|SHC\|SEC\|CEP-\(4\|31\|121\)G\)\>/
" two *
" FIXME handle the *
syn match gjftwastbas contained /\v<(6-21G|4-31G)(\*(\*)?[ ])?/ contains=gjfnoparbas,gjfast
syn match gjftwastbas contained /\v<(SHC|SEC|CEP-(4|31|121)G)(\*[ ])?/ contains=gjfnoparbas,gjfast

"Last line must be empty
syn match gjfLast /^.\+\%$/

"Let there be colour
let b:current_syntax = "gjf"
hi def link gjfTodo      Todo
hi def link gjfComment   Comment
hi def link GjfBlockCmd  Statement
hi def link gjfLink0      PreProc
hi def link GjfFloat     Float
hi def link gjfroot Identifier
" Errors
hi def link gjfLast ErrorMsg
hi def link gjfParenClos ErrorMsg
hi def link gjfParenOpen ErrorMsg
hi def link gjfcomma ErrorMsg
" root section colors
hi def link gjfHdft1 gjfroot
hi def link gjfHdft2 gjfroot
hi def link gjfHdft3 gjfroot
hi def link gjfPdft gjfroot
hi def link gjfPsdft gjfroot
hi def link gjfempd gjfroot
hi def link gjfHf gjfroot
hi def link gjfmpk gjfroot
hi def link gjfdunbs gjfroot
hi def link gjfgnbs gjfroot
hi def link gjfpoplebs gjfroot
hi def link gjfnoparbas gjfroot
hi def link gjfast gjfroot
hi def link gjfpopinpar gjfroot
hi def link gjfplusbas gjfroot
" options of root section
hi def link gjfempdoptions Exception
hi def link gjfmp4opt Exception
hi def link gjfmpopt Exception
