if exists("b:current_syntax")
    finish
endif

syn match OrgLevel1 /^\* .*/
syn match OrgLevel2 /^\*\* .*/
syn match OrgLevel3 /^\*\*\* .*/
syn match OrgLevel4 /^\*\*\*\* .*/

syn match OrgComment /^#[ +].*/

syn match OrgTimestamp /<[0-9].\+:[0-9]\+>.*/

" syn match OrgTODO 


"folding first level
syn region orgFoldLevel1
    \ start="^* "
    \ end="^* "
    \ transparent fold
    \ keepend extend
    \ containedin=ALLBUT,@orgFoldLevel1


hi def link OrgComment      Comment
hi def link OrgTimestamp    Comment

let b:current_syntax = "org"
