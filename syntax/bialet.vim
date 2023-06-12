" Keywords
syntax keyword bialetGlobalObjects Date Intl Number String Fetch Request Response Random Session Log Env Children Cache Database Json
syntax keyword bialetExceptions    Error 404 500
syntax keyword bialetBuiltins      this args

" Copied from https://github.com/pangloss/vim-javascript/
" and https://github.com/mxw/vim-jsx/

if exists('b:current_syntax')
  let s:current_syntax=b:current_syntax
  unlet b:current_syntax
endif
syn include @XMLSyntax syntax/xml.vim

if exists('b:current_syntax')
  let s:current_syntax=b:current_syntax
  unlet b:current_syntax
endif
syn include @CSS syntax/css.vim

if exists('s:current_syntax')
  let b:current_syntax=s:current_syntax
endif

syntax case ignore

syntax match   bialetNoise          /[:;]/
syntax match   bialetNoise          /,/ skipwhite skipempty nextgroup=@bialetExpression
syntax match   bialetDot            /\./ skipwhite skipempty nextgroup=bialetObjectProp,bialetFuncCall,bialetTaggedTemplate
syntax match   bialetObjectProp     contained /\<\K\k*/
syntax match   bialetFuncCall       /\<\K\k*\ze[\s\n]*(/
syntax match   bialetParensError    /[)}\]]/

" Program Keywords
syntax keyword bialetStorageClass   var skipwhite skipempty nextgroup=bialetDestructuringBlock,bialetDestructuringArray,bialetVariableDef
syntax match   bialetVariableDef    contained /\<\K\k*/ skipwhite skipempty nextgroup=bialetFlowDefinition
syntax keyword bialetOperatorKeyword delete instanceof typeof void new in skipwhite skipempty nextgroup=@bialetExpression
syntax keyword bialetOf             of skipwhite skipempty nextgroup=@bialetExpression
syntax match   bialetOperator       "[-!|&+<>=%/*~^]" skipwhite skipempty nextgroup=@bialetExpression
syntax match   bialetOperator       /::/ skipwhite skipempty nextgroup=@bialetExpression
syntax keyword bialetBooleanTrue    true
syntax keyword bialetBooleanFalse   false
syntax keyword bialetNull nil


" Modules
syntax keyword bialetImport             import skipwhite skipempty nextgroup=bialetModuleAsterisk,bialetModuleKeyword,bialetModuleGroup,bialetFlowImportType
syntax match   bialetModuleKeyword      contained /\<\K\k*/ skipwhite skipempty nextgroup=bialetModuleAs,bialetFrom,bialetModuleComma
syntax match   bialetModuleAsterisk     contained /\*/ skipwhite skipempty nextgroup=bialetModuleKeyword,bialetModuleAs,bialetFrom
syntax keyword bialetModuleAs           contained as skipwhite skipempty nextgroup=bialetModuleKeyword
syntax keyword bialetFrom               contained from skipwhite skipempty nextgroup=bialetString
syntax match   bialetModuleComma        contained /,/ skipwhite skipempty nextgroup=bialetModuleKeyword,bialetModuleAsterisk,bialetModuleGroup,bialetFlowTypeKeyword

" Strings, Templates, Numbers
syntax region  bialetString           start=+\z(["']\)+  skip=+\\\%(\z1\|$\)+  end=+\z1+ end=+$+  contains=bialetSpecial extend
syntax match   bialetNumber           "[0-9][_0-9]*\.\?[0-9]*"
syntax match   bialetSpecial            contained "\v\\%(x\x\x|u%(\x{4}|\{\x{4,5}})|c\u|.)"

" Objects
syntax match   bialetObjectShorthandProp contained /\<\k*\ze\s*/ skipwhite skipempty nextgroup=bialetObjectSeparator
syntax match   bialetObjectKey         contained /\<\k*\ze\s*/ contains=bialetFunctionKey skipwhite skipempty nextgroup=bialetObjectValue
syntax region  bialetObjectKeyString   contained start=+\z(["']\)+  skip=+\\\%(\z1\|$\)+  end=+\z1\|$+  contains=bialetSpecial skipwhite skipempty nextgroup=bialetObjectValue
syntax region  bialetObjectKeyComputed contained matchgroup=bialetBrackets start=/\[/ end=/]/ contains=@bialetExpression skipwhite skipempty nextgroup=bialetObjectValue,bialetFuncArgs extend
syntax match   bialetObjectSeparator   contained /,/
syntax region  bialetObjectValue       contained matchgroup=bialetObjectColon start=/:/ end=/[,}]\@=/ contains=@bialetExpression extend
syntax match   bialetObjectFuncName    contained /\<\K\k*\ze\_s*(/ skipwhite skipempty nextgroup=bialetFuncArgs
syntax match   bialetFunctionKey       contained /\<\K\k*\ze\s*:\s*fun\>/
syntax match   bialetObjectMethodType  contained /\<[gs]et\ze\s\+\K\k*/ skipwhite skipempty nextgroup=bialetObjectFuncName
syntax region  bialetObjectStringKey   contained start=+\z(["']\)+  skip=+\\\%(\z1\|$\)+  end=+\z1\|$+  contains=bialetSpecial extend skipwhite skipempty nextgroup=bialetFuncArgs,bialetObjectValue

" Statement Keywords
syntax match   bialetBlockLabel              /\<\K\k*\s*::\@!/    contains=bialetNoise skipwhite skipempty nextgroup=bialetBlock
syntax match   bialetBlockLabelKey contained /\<\K\k*\ze\s*\_[;]/
syntax keyword bialetStatement     contained break continue skipwhite skipempty nextgroup=bialetBlockLabelKey
syntax keyword bialetConditional if skipwhite skipempty nextgroup=bialetParenIfElse
syntax keyword bialetConditional elseif skipwhite skipempty nextgroup=bialetCommentIfElse,bialetIfElseBlock
syntax keyword bialetConditional else skipwhite skipempty nextgroup=bialetCommentIfElse,bialetIfElseBlock
syntax keyword bialetWhile       while skipwhite skipempty nextgroup=bialetParenWhile
syntax keyword bialetException   throw


" DISCUSS: Should we really be special matching on these props?
" HTML events and internal variables
syntax keyword bialetHtmlEvents     onblur onclick oncontextmenu ondblclick onfocus onkeydown onkeypress onkeyup onmousedown onmousemove onmouseout onmouseover onmouseup onresize

" Code blocks
syntax region  bialetBracket                      matchgroup=bialetBrackets            start=/\[/ end=/\]/ contains=@bialetExpression,bialetSpreadExpression extend fold
syntax region  bialetParen                        matchgroup=bialetParens              start=/(/  end=/)/  contains=@bialetExpression extend fold nextgroup=bialetFlowDefinition
syntax region  bialetParenDecorator     contained matchgroup=bialetParensDecorator     start=/(/  end=/)/  contains=@bialetExpression extend fold
syntax region  bialetFuncArgs           contained matchgroup=bialetFuncParens          start=/(/  end=/)/  contains=bialetFuncArgCommas,bialetComment,bialetFuncArgExpression,bialetDestructuringBlock,bialetDestructuringArray,bialetRestExpression,bialetFlowArgumentDef skipwhite skipempty nextgroup=bialetCommentFunction,bialetFuncBlock,bialetFlowReturn extend fold
syntax region  bialetFuncBlock          contained matchgroup=bialetFuncBraces          start=/{/  end=/}/  contains=@bialetAll extend fold
syntax region  bialetDestructuringBlock contained matchgroup=bialetDestructuringBraces start=/{/  end=/}/  contains=bialetDestructuringProperty,bialetDestructuringAssignment,bialetDestructuringNoise,bialetDestructuringPropertyComputed,bialetSpreadExpression,bialetComment nextgroup=bialetFlowDefinition extend fold
syntax region  bialetDestructuringArray contained matchgroup=bialetDestructuringBraces start=/\[/ end=/\]/ contains=bialetDestructuringPropertyValue,bialetDestructuringNoise,bialetDestructuringProperty,bialetSpreadExpression,bialetDestructuringBlock,bialetDestructuringArray,bialetComment nextgroup=bialetFlowDefinition extend fold
syntax region  bialetObject             contained matchgroup=bialetObjectBraces        start=/{/  end=/}/  contains=bialetObjectKey,bialetObjectKeyString,bialetObjectKeyComputed,bialetObjectShorthandProp,bialetObjectSeparator,bialetObjectFuncName,bialetObjectMethodType,bialetComment,bialetObjectStringKey,bialetSpreadExpression,bialetDecorator extend fold
syntax region  bialetBlock                        matchgroup=bialetBraces              start=/{/  end=/}/  contains=@bialetAll,bialetSpreadExpression extend fold
syntax region  bialetSpreadExpression   contained matchgroup=bialetSpreadOperator      start=/\.\.\./ end=/[,}\]]\@=/ contains=@bialetExpression
syntax region  bialetRestExpression     contained matchgroup=bialetRestOperator        start=/\.\.\./ end=/[,)]\@=/
syntax region  bialetTernaryIf                    matchgroup=bialetTernaryIfOperator   start=/?:\@!/  end=/\%(:\|}\@=\)/  contains=@bialetExpression extend skipwhite skipempty nextgroup=@bialetExpression
" These must occur here or they will be override by bialetTernaryIf
syntax match   bialetOperator           /?\.\ze\_D/
syntax match   bialetOperator           /??/ skipwhite skipempty nextgroup=@bialetExpression

syntax match   bialetFuncName             contained /\<\K\k*/ skipwhite skipempty nextgroup=bialetFuncArgs,bialetFlowFunctionGroup
syntax region  bialetFuncArgExpression    contained matchgroup=bialetFuncArgOperator start=/=/ end=/[,)]\@=/ contains=@bialetExpression extend
syntax match   bialetFuncArgCommas        contained ','
syntax keyword bialetArguments            contained arguments

" Destructuring
syntax match   bialetDestructuringPropertyValue     contained /\k\+/
syntax match   bialetDestructuringProperty          contained /\k\+\ze\s*=/ skipwhite skipempty nextgroup=bialetDestructuringValue
syntax match   bialetDestructuringAssignment        contained /\k\+\ze\s*:/ skipwhite skipempty nextgroup=bialetDestructuringValueAssignment
syntax region  bialetDestructuringValue             contained start=/=/ end=/[,}\]]\@=/ contains=@bialetExpression extend
syntax region  bialetDestructuringValueAssignment   contained start=/:/ end=/[,}=]\@=/ contains=bialetDestructuringPropertyValue,bialetDestructuringBlock,bialetNoise,bialetDestructuringNoise skipwhite skipempty nextgroup=bialetDestructuringValue extend
syntax match   bialetDestructuringNoise             contained /[,[\]]/
syntax region  bialetDestructuringPropertyComputed  contained matchgroup=bialetDestructuringBraces start=/\[/ end=/]/ contains=@bialetExpression skipwhite skipempty nextgroup=bialetDestructuringValue,bialetDestructuringValueAssignment,bialetDestructuringNoise extend fold

" Comments
syntax keyword bialetCommentTodo contained TODO FIXME XXX TBD NOTE
syntax match bialetComment "\v^\s*#.*$" contains=bialetCommentTodo

" Decorators
syntax match   bialetDecorator                    /^\s*@/ nextgroup=bialetDecoratorFunction
syntax match   bialetDecoratorFunction  contained /\h[a-zA-Z0-9_.]*/ nextgroup=bialetParenDecorator

syntax cluster bialetExpression  contains=bialetBracket,bialetParen,bialetObject,bialetTernaryIf,bialetTaggedTemplate,bialetString,bialetNumber,bialetOperator,bialetOperatorKeyword,bialetBooleanTrue,bialetBooleanFalse,bialetNull,bialetFunction,bialetGlobalObjects,bialetExceptions,bialetHtmlEvents,bialetFuncCall,bialetBuiltins,bialetNoise,bialetParensError,bialetComment,bialetArguments,bialetThis,bialetSuper,bialetDo,bialetStatement,bialetDot
syntax cluster bialetAll         contains=@bialetExpression,bialetStorageClass,bialetConditional,bialetWhile,bialetFor,bialetReturn,bialetException,bialetTry,bialetNoise,bialetBlockLabel,bialetBlockG

syntax keyword bialetKeyword end fun into save and or

syntax match bialetVar "\k\+" nextgroup=bialetAssignment
syntax match bialetAssignment "=" contained nextgroup=bialetValue
syntax match bialetValue ".*" contained

syntax region bialetQuery start='`' end='`'

" bialet attributes should color as bialet.  Note the trivial end pattern; we let
" bialetBlock take care of ending the region.
syn region xmlString contained start=+{+ end=++ contains=bialetBlock

" bialet comments inside XML tag should color as comment.  Note the trivial end pattern; we let
" bialetComment take care of ending the region.
syn region xmlString contained start=+//+ end=++ contains=bialetComment

" bialet child blocks behave just like bialet attributes, except that (a) they are
" syntactically distinct, and (b) they need the syn-extend argument, or else
" nested XML end-tag patterns may end the outer bialetRegion.
syn region bialetChild contained start=+{+ end=++ contains=bialetBlock
  \ extend

" Highlight bialet regions as XML; recursively match.
"
" Note that we prohibit bialet tags from having a < or word character immediately
" preceding it, to avoid conflicts with, respectively, the left shift operator
" and generic Flow type annotations (http://flowtype.org/).
syn region bialetRegion
  \ contains=@Spell,@XMLSyntax,bialetRegion,bialetChild,bialetBlock,bialetComment
  \ start=+\%(<\|\w\)\@<!<\z([a-zA-Z_][a-zA-Z0-9:\-.]*\>[:,]\@!\)\([^>]*>(\)\@!+
  \ skip=+<!--\_.\{-}-->+
  \ end=+</\z1\_\s\{-}>+
  \ end=+/>+
  \ keepend
  \ extend

" Add bialetRegion to the lowest-level bialet syntax cluster.
syn cluster bialetExpression add=bialetRegion

" Allow bialetRegion to contain reserved words.
syn cluster javascriptNoReserved add=bialetRegion

syn region bialetScript start=+<script>+ keepend end=+</script>+
syn region bialetStyle start=+<style>+ keepend end=+</style>+ contains=@CSS


hi def link bialetScript SpecialComment
hi def link bialetStyle Noise

hi def link bialetKeyword Keyword
hi def link bialetVar Identifier
hi def link bialetVarInString Type
hi def link bialetValue String
hi def link bialetString String
hi def link bialetQuery Error
hi def link bialetComment              Comment
hi def link bialetEnvComment           PreProc
hi def link bialetParensIfElse         bialetParens
hi def link bialetParensWhile          bialetParensRepeat
hi def link bialetParensFor            bialetParensRepeat
hi def link bialetParensRepeat         bialetParens
hi def link bialetParensCatch          bialetParens
hi def link bialetCommentTodo          Todo
hi def link bialetString               String
hi def link bialetObjectKeyString      String
hi def link bialetObjectStringKey      String
hi def link bialetTaggedTemplate       StorageClass
hi def link bialetTernaryIfOperator    Operator
hi def link bialetCharacter            Character
hi def link bialetConditional          Conditional
hi def link bialetBranch               Conditional
hi def link bialetLabel                Label
hi def link bialetReturn               Statement
hi def link bialetWhile                bialetRepeat
hi def link bialetFor                  bialetRepeat
hi def link bialetRepeat               Repeat
hi def link bialetDo                   Repeat
hi def link bialetStatement            Statement
hi def link bialetException            Exception
hi def link bialetTry                  Exception
hi def link bialetFinally              Exception
hi def link bialetCatch                Exception
hi def link bialetFunction             Type
hi def link bialetFuncName             Function
hi def link bialetFuncCall             Function
hi def link bialetObjectFuncName       Function
hi def link bialetArguments            Special
hi def link bialetError                Error
hi def link bialetParensError          Error
hi def link bialetOperatorKeyword      bialetOperator
hi def link bialetOperator             Operator
hi def link bialetOf                   Operator
hi def link bialetStorageClass         StorageClass
hi def link bialetExtendsKeyword       Keyword
hi def link bialetThis                 Special
hi def link bialetSuper                Constant
hi def link bialetNull                 Type
hi def link bialetNumber               Number
hi def link bialetBooleanTrue          Boolean
hi def link bialetBooleanFalse         Boolean
hi def link bialetObjectColon          bialetNoise
hi def link bialetNoise                Noise
hi def link bialetDot                  Noise
hi def link bialetBrackets             Noise
hi def link bialetParens               Noise
hi def link bialetBraces               Noise
hi def link bialetFuncBraces           Noise
hi def link bialetFuncParens           Noise
hi def link bialetIfElseBraces         Noise
hi def link bialetTryCatchBraces       Noise
hi def link bialetModuleBraces         Noise
hi def link bialetObjectBraces         Noise
hi def link bialetObjectSeparator      Noise
hi def link bialetFinallyBraces        Noise
hi def link bialetRepeatBraces         Noise
hi def link bialetSpecial              Special
hi def link bialetTemplateBraces       Noise
hi def link bialetGlobalObjects        Constant
hi def link bialetExceptions           Constant
hi def link bialetBuiltins             Constant
hi def link bialetImport               Include
hi def link bialetModuleAs             Include
hi def link bialetModuleComma          bialetNoise
hi def link bialetModuleAsterisk       Noise
hi def link bialetFrom                 Include
hi def link bialetDecorator            Special
hi def link bialetDecoratorFunction    Function
hi def link bialetParensDecorator      bialetParens
hi def link bialetFuncArgOperator      bialetFuncArgs
hi def link bialetObjectShorthandProp  bialetObjectKey
hi def link bialetSpreadOperator       Operator
hi def link bialetRestOperator         Operator
hi def link bialetRestExpression       bialetFuncArgs
hi def link bialetObjectMethodType     Type
hi def link bialetBlockLabel           Identifier
hi def link bialetBlockLabelKey        bialetBlockLabel

hi def link bialetDestructuringBraces     Noise
hi def link bialetDestructuringProperty   bialetFuncArgs
hi def link bialetDestructuringAssignment bialetObjectKey
hi def link bialetDestructuringNoise      Noise

hi def link bialetHtmlEvents           Special
hi def link bialetHtmlElemAttrs        Label
hi def link bialetHtmlElemFuncs        PreProc

hi def link bialetCssStyles            Label

let b:current_syntax = 'bialet'
