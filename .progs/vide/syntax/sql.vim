" Credit: https://github.com/purpleP/sql.vim/blob/master/syntax/sql.vim

if exists("b:current_syntax")
    finish
endif

syn case ignore

syn keyword sqlKeyword add
syn keyword sqlKeyword after
syn keyword sqlKeyword all
syn keyword sqlKeyword alter
syn keyword sqlKeyword and
syn keyword sqlKeyword as
syn keyword sqlKeyword asc
syn keyword sqlKeyword before
syn keyword sqlKeyword between
syn keyword sqlKeyword by
syn keyword sqlKeyword case
syn keyword sqlKeyword column
syn keyword sqlKeyword constraint
syn keyword sqlKeyword create
syn keyword sqlKeyword delete
syn keyword sqlKeyword desc
syn keyword sqlKeyword distinct
syn keyword sqlKeyword drop
syn keyword sqlKeyword else
syn keyword sqlKeyword end
syn keyword sqlKeyword exists
syn keyword sqlKeyword foreign
syn keyword sqlKeyword from
syn keyword sqlKeyword full
syn keyword sqlKeyword group
syn keyword sqlKeyword having
syn keyword sqlKeyword if
syn keyword sqlKeyword in
syn keyword sqlKeyword insert
syn keyword sqlKeyword instead
syn keyword sqlKeyword into
syn keyword sqlKeyword is
syn keyword sqlKeyword join
syn keyword sqlKeyword key
syn keyword sqlKeyword left
syn keyword sqlKeyword limit
syn keyword sqlKeyword merge
syn keyword sqlKeyword not
syn keyword sqlKeyword of
syn keyword sqlKeyword offset
syn keyword sqlKeyword on
syn keyword sqlKeyword or
syn keyword sqlKeyword order
syn keyword sqlKeyword outer
syn keyword sqlKeyword over
syn keyword sqlKeyword overlaps
syn keyword sqlKeyword partition
syn keyword sqlKeyword primary
syn keyword sqlKeyword replace
syn keyword sqlKeyword right
syn keyword sqlKeyword select
syn keyword sqlKeyword set
syn keyword sqlKeyword table
syn keyword sqlKeyword then
syn keyword sqlKeyword trigger
syn keyword sqlKeyword union
syn keyword sqlKeyword unique
syn keyword sqlKeyword update
syn keyword sqlKeyword using
syn keyword sqlKeyword values
syn keyword sqlKeyword view
syn keyword sqlKeyword when
syn keyword sqlKeyword where
syn keyword sqlKeyword window
syn keyword sqlKeyword with

syn keyword sqlConstant true
syn keyword sqlConstant false
syn keyword sqlConstant null

syn match sqlNumber "\<\d\+"

syn region sqlComment start="/\*" end="\*/"
syn match sqlComment "--\_s.*"

syn region sqlSingleQuotedString start=+'+ skip=+\\'+ excludenl end=+'+ end=+$+ keepend
syn region sqlDoubleQuotedString start=+"+ skip=+\\"+ excludenl end=+"+ end=+$+ keepend
syn region sqlBacktickString start=+`+ skip=+\\`+ excludenl end=+`+ end=+$+ keepend

hi def link sqlKeyword Keyword
hi def link sqlSingleQuotedString String
hi def link sqlDoubleQuotedString String
hi def link sqlBacktickString String
hi def link sqlComment Comment
hi def link sqlConstant Constant
hi def link sqlNumber Number

let b:current_syntax = "sql"
