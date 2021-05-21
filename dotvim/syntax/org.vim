if exists("b:current_syntax")
    finish
endif

syn match OrgTodo       /\<TODO\>/
syn match OrgProgress   /\<PROGRESS\>/
syn match OrgDone       /\<DONE\>/
syn match OrgLevel1 /^\* .*/
syn match OrgLevel2 /^\*\* .*/
syn match OrgLevel3 /^\*\*\* .*/
            \ contains=OrgTodo,OrgProgress,OrgDone
syn match OrgLevel4 /^\*\*\*\* .*/
            \ contains=OrgTodo,OrgProgress,OrgDone
syn match OrgLevel5 /^\*\*\*\*\* .*/

syn match OrgComment /^[ ]*#[ +].*/

syn match OrgTimestamp /<[0-9].\+:[0-9]\+>.*/

syn match OrgContext /`[^`]\+`/

"folding first level
" syn region orgFoldLevel1
"     \ start="^* "
"     \ end="^* "
"     \ transparent fold
"     \ keepend extend
"     \ containedin=ALLBUT,@orgFoldLevel1

hi def link OrgComment      Comment
hi def link OrgTimestamp    Comment
hi def link OrgTODO         Todo

let b:current_syntax = "org"

