if exists("b:current_syntax")
    finish
endif

"KEYWORD for todo lists
syn match OrgTodo       /\<TODO\>/
syn match OrgProgress   /\<PROG\>/
syn match OrgProgress   /\<PROGRESS\>/
syn match OrgDone       /\<DONE\>/
syn match OrgCritical   /\<CRIT\>/
syn match OrgCritical   /\<CRITICAL\>/
syn match OrgWaiting    /\<WAIT\>/
syn match OrgWaiting    /\<WAITING\>/

syn match OrgLevel1 /^\* .*/
syn match OrgLevel2 /^\*\* .*/
syn match OrgLevel3 /^\*\*\* .*/
            \ contains=OrgTodo,OrgProgress,OrgDone,OrgCritical,OrgWaiting
syn match OrgLevel4 /^\*\*\*\* .*/
            \ contains=OrgTodo,OrgProgress,OrgDone,OrgCritical,OrgWaiting
syn match OrgLevel5 /^\*\*\*\*\* .*/

syn match OrgComment /^[ ]*#[ +].*/
syn match OrgDirective /^#!.*/

syn match OrgTimestamp /<[0-9].\+:[0-9]\+>.*/

"monospace inverted text highlight for path or specific code
syn match OrgContextContainer /`[^`]\+`/ contains=OrgContext
syn match OrgContext /[^`]\+/ contained

"similar to OrgContext but not inverted and subtle
"uses "bold syntax : *word* "
"spaces are specified to avoid highlight in equation
"emphasis can be on accented letters
syn match OrgEmphasis / \*\<[- A-zÀ-ÿ]\+\>\*\([ ]\|$\)/ 
    " \ containedin=OrgEmphasisContainer
    " tag can start line or following whitespace
syn match OrgUsername /\(^\| \)[@][a-z][a-z][a-z]\>/

"folding first level
" syn region orgFoldLevel1
"     \ start="^* "
"     \ end="^* "
"     \ transparent fold
"     \ keepend extend
"     \ containedin=ALLBUT,@orgFoldLevel1

hi def link OrgComment      Comment
hi def link OrgDirective    SpecialComment
hi def link OrgTimestamp    Comment
hi def link OrgTODO         Todo
hi def link OrgUsername     OrgEmphasis

let b:current_syntax = "org"

