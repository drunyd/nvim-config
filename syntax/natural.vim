" syntax/natural.vim
" Egyszerű Natural nyelv szintaxiskiemelés

if exists("b:current_syntax")
  finish
endif

" Kulcsszavak
syntax keyword naturalKeyword DEFINE END-DEFINE END READ WRITE IF THEN ELSE END-IF REPEAT UNTIL FOR TO BY DECIDE ON VALUE OF NONE ESCAPE END-DECIDE CALL FUNCTION SUBROUTINE PERFORM MOVE COMPUTE ADD SUBTRACT MULTIPLY DIVIDE
highlight link naturalKeyword Keyword

" Beépített típusok
syntax keyword naturalType INTEGER FLOAT FIXED BINARY LOGICAL DATE TIME ALPHANUMERIC
highlight link naturalType Type

" Literál sztringek
syntax region naturalString start=+"+ skip=+\\"+ end=+"+
highlight link naturalString String

" Kommentezés: * a sor elején
syntax match naturalComment "^\s*\*.*"
highlight link naturalComment Comment

" Számok
syntax match naturalNumber "\<\d\+\>"
highlight link naturalNumber Number

" Függvényhívások (egyszerűbb formában)
syntax match naturalFunction "\<\w\+\s*("
highlight link naturalFunction Function

let b:current_syntax = "natural"
