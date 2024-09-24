if exists("b:current_syntax")
    finish
endif

syntax keyword bialetGlobalObjects Request Response Cookie Session Json Util Config Db Http Date File
syn keyword wrenNull null
syn keyword wrenBoolean true false
syn match wrenNumber "\v<\d+(\.\d+)?>|\.\d+>"

syn match wrenEscape "\v\\0|\\\"|\\\\|\\a|\\b|\\f|\\n|\\r|\\t|\\v|\\u[[:xdigit:]]{4}|\\x[[:xdigit:]]{2}"
syn region wrenString contains=wrenEscape start=/\v"/ skip=/\v\\"/ end=/\v"/
syn region wrenSingleString contains=wrenEscape start=/\v'/ skip=/\v\\'/ end=/\v'/
syn region wrenQuery contains=wrenEscape start=/\v`/ skip=/\v\\`/ end=/\v`/

syn keyword wrenConditional else if
syn keyword wrenRepeat break for while continue
syn keyword wrenKeyword class as in is new return super this var import
syn keyword wrenConstruct construct contained containedin=wrenConstructor
syn keyword wrenStatic static contained containedin=wrenMethod,wrenForeignMethod
syn keyword wrenForeign foreign contained containedin=wrenForeignMethod

syn match wrenMethod "\v^\s*(static\s+)?\w+\=?\ze\s*(\([^)]*\))?\s*\{" contains=wrenRepeat,wrenConditional
syn match wrenConstructor "\v^\s*construct\s+\w+\ze\s*(\([^)]*\))?\s*\{"
syn match wrenForeignMethod "\v^\s*foreign\s+(static\s+)?\w+"
syn match wrenForeignClass "\v^\s*foreign\s+class"

syn match wrenOperatorDef "\V\^\s\*\(!\|~\|-\|==\?\|!=\|<=\?\|>=\?\|...\?\||\|&\|+\|-\|*\|/\|%\)\ze\s\*\((\[^)]\*)\)\?\s\*{"
syn match wrenOperator "\V!\|~\|-\|==\?\|!=\|<=\?\|>=\?\|...\?\||\|&\|+\|-\|*\|/\|%"

syn match wrenField "\v_\w+" display
syn match wrenStaticField "\v__\w+" display
syn match wrenToplevel "\v<[A-Z]\w*" display

syn keyword wrenTodo contained TODO FIXME XXX
syn match wrenComment contains=wrenTodo "\v//.*$"
syn region wrenComment contains=wrenTodo,wrenComment start=#\v/\*# end=#\*/#
syn match wrenComment "\%^#!.*"

syn keyword wrenMisplacedKeyword static

syn region htmlString	contained start=+"+ end=+"+ contains=wrenHandlebars
syn region htmlString	contained start=+'+ end=+'+ contains=wrenHandlebars
syn match htmlValue	contained "="

syn region htmlTag start=+<[^/]+ end=+>+ fold contains=htmlTagN,htmlString,htmlArg,htmlValue
syn region htmlEndTag start=+</+ end=+>+ contains=htmlTagN
syn match htmlTagN contained +<\[-a-zA-Z0-9]\++hs=s+1 contains=htmlTagName
syn match htmlTagN contained +</[-a-zA-Z0-9]\++hs=s+2 contains=htmlTagName

syn keyword htmlTagName contained address applet area a base basefont
syn keyword htmlTagName contained big blockquote br caption center
syn keyword htmlTagName contained cite code dd dfn dir div dl dt font
syn keyword htmlTagName contained form hr html img
syn keyword htmlTagName contained input isindex kbd li link map menu
syn keyword htmlTagName contained meta ol option param pre p samp span
syn keyword htmlTagName contained select small strike sub sup
syn keyword htmlTagName contained table td textarea th tr tt ul var xmp
syn match htmlTagName contained "\<\%(b\|i\|u\|h[1-6]\|em\|strong\|head\|body\|title\)\>"

syn keyword htmlTagName contained abbr acronym bdo button col colgroup
syn keyword htmlTagName contained del fieldset iframe ins label legend
syn keyword htmlTagName contained object optgroup q s tbody tfoot thead

syn keyword htmlTagName contained article aside audio bdi canvas data
syn keyword htmlTagName contained datalist details dialog embed figcaption
syn keyword htmlTagName contained figure footer header hgroup keygen main
syn keyword htmlTagName contained mark menuitem meter nav output picture
syn keyword htmlTagName contained progress rb rp rt rtc ruby search section
syn keyword htmlTagName contained slot source summary template time track
syn keyword htmlTagName contained video wbr math svg

syn region wrenHandlebars contains=wrenNull,wrenBoolean,wrenNumber,wrenString,wrenSingleString,wrenIdentifier,wrenKeyword,wrenOperatorDef,wrenOperator,htmlTag,htmlEndTag,bialetGlobalObjects start="{{" end="}}"

hi bialetGlobalObjects cterm=bold gui=bold

hi def link wrenNull Constant
hi def link wrenBoolean Boolean
hi def link wrenNumber Number
hi def link wrenString String
hi def link wrenSingleString String
hi def link wrenQuery Error
hi def link wrenEscape SpecialChar
hi def link wrenConditional Conditional
hi def link wrenRepeat Repeat
hi def link wrenKeyword Keyword
hi def link wrenConstruct Keyword
hi def link wrenStatic Keyword
hi def link wrenForeign Keyword
hi def link wrenMethod Function
hi def link wrenForeignClass Keyword
hi def link wrenConstructor Function
hi def link wrenForeignMethod Function
hi def link wrenOperatorDef Function
hi def link wrenOperator Operator
hi def link wrenIdentifier Identifier
hi def link wrenStaticField wrenIdentifier
hi def link wrenField wrenIdentifier
hi def link wrenToplevel wrenIdentifier
hi def link wrenComment Comment
hi def link wrenTodo Todo
hi def link wrenMisplacedKeyword Error

hi def link wrenHandlebars Type
hi def link htmlTag	Constant
hi def link htmlEndTag Constant
hi def link htmlArg	Constant
hi def link htmlTagName	Constant
hi def link htmlValue PreProc
hi def link htmlString PreProc

let b:current_syntax = "bialet"
