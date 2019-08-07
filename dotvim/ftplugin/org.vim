" Author : Adriel Munger
" Date   : august 4 2019
" Descr  : basic Emacs's org file interpreter
"
" Features : - Header folding
"            - ...

"HEADER GUARD to avoid including this file multiple times
if exists("g:org_ftplugin_loaded")
"     source ~/.vim/plugin/comments.vim
    finish
endif

let g:org_ftplugin_loaded = 1

" nnoremap <tab> :Org_toggleHeader(v:lnum)

setlocal foldmethod=expr
setlocal foldexpr=Org_getFold(v:lnum)
setlocal foldtext=Org_setText(v:foldstart)

function! Org_getFold(lnum)
    let l:level = '0'
    
    if getline(a:lnum) =~? '^\*\+ .*$'
        " allows to separate headers from each other
        let l:level1 = Org_countStar(a:lnum)
        let l:level = '>' . l:level1
    else
        let l:curr =  Org_getHeaderLine(a:lnum)
        " count the number of '*' from the previous header
        let l:level = Org_countStar(l:curr)
    endif

    " echo 'now at level ' . l:level
    return l:level
endfunction

function! Org_countStar(lnum)
    let l:str = getline(a:lnum)
    let l:max = strlen(l:str)
    if l:max > 5
        let l:max = 5
    endif

    let l:count = 0
    let l:i = 0
    
    "iterate in line until last '*'
    while l:str[l:count] ==# '*'
        let l:count += 1
    endwhile
    return l:count
endfunction

function! Org_getHeaderLine(lnum)
    let l:curr = a:lnum

    while l:curr >= 1
        "if match, regex, case insensitive

        if getline(l:curr) =~? '^\*\+ .*$'
            break
        endif
        "update iterator
        let l:curr -= 1
    endwhile
    return l:curr
endfunction

" really simple for the moment
function! Org_setText(lnum)
    " let l:str = getline(a:lnum)
    return getline(a:lnum)
endfunction

