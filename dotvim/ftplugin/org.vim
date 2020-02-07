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
setlocal autoindent
" this option is overriden for some reason
set formatoptions=qrlcn
" l : long lines not broken
" c : add comment automatically
" n : continue formatted list
setlocal comments=n:-,n:#
set tabstop=2
set shiftwidth=2

" localleader is <C-x>
let maplocalleader=""

imap <buffer> <silent> <C-j> <Esc>ms:call Org_addHeader()<CR>a

" allows to change level of header
imap <buffer> <silent> <C-l> <Esc>:call Org_HeaderLevelPlus()<CR>a
imap <buffer> <silent> <C-h> <Esc>:call Org_HeaderLevelMinus()<CR>a


nmap <buffer> <localleader><C-i> :call Org_startTimestamp()<CR>
nmap <buffer> <localleader><C-o> :call Org_EndTimestamp()<CR>

nmap <buffer> <leader>d :read !date "+\%a, \%d \%B"<CR>
nmap <buffer> <tab> :call Org_cycleVisibility()<CR>

nnoremap K <NOP>

function! Org_cycleVisibility()
    let l:fold = foldclosed('.')
    if l:fold == -1
        "then fold is not closed
        normal zc
    else
        normal zo
    endif
endfunction

function! Org_HeaderLevelPlus()
    "[bufnum, lnum, col, off]
    let l:pos = getpos('.')
    let l:lvl = Org_countStar(l:pos[1])
    if l:lvl == 0
        exe ":normal 0i* "
        let l:pos[2] += 2
    else
        exe ":normal 0i*"
        let l:pos[2] += 1
    endif
    call setpos('.',l:pos)
endfunction
function! Org_HeaderLevelMinus()
    "[bufnum, lnum, col, off]
    let l:pos = getpos('.')
    let l:lvl = Org_countStar(l:pos[1])
    if l:lvl == 1
        exe ":normal 0xx"
        let l:pos[2] -= 2
    elseif l:lvl > 1
        exe ":normal 0x"
        let l:pos[2] -= 1
    endif
    call setpos('.',l:pos)
endfunction

function! Org_startTimestamp()
    ":r !date "+\%a \%B \%d, 
    read !date "+<\%d-\%m-\%Y \%H:\%M>"
    "if already a date in the line
    " let l:date = system("date +<%d-%m-%Y %H:%M>")
endfunction

"TODO : must do the time calculation and printing it at the end
function! Org_EndTimestamp()
    ":r !date "+\%a \%B \%d, 
    "if already a date in the line
    let l:starttime = getline('.')
    let l:date = system("date +'<%d-%m-%Y %H:%M>'")

    " remove trailing newline after system command
    let l:date = l:date[:-2]
    " let l:date = substitute(l:date,'\n','','')

    " print closing time
    exe ":normal A - ".l:date
    
    " calculate timestamp difference
    " start hours
    let l:start = matchstr(l:starttime,'[0-9]\{2}:[0-9]\{2}')
    let l:shour = l:start[0:1]
    let l:smin  = l:start[3:4]

    let l:end   = matchstr(l:date,'[0-9]\{2}:[0-9]\{2}')
    let l:ehour = l:end[0:1]
    let l:emin  = l:end[3:4]

    let l:diff  =  (l:emin - l:smin) + (l:ehour - l:shour)*60
    let l:hour  = l:diff / 60
    let l:min   = l:diff % 60
    exe ":normal A -> ".l:hour.":".l:min

endfunction

"if at end of line, it should start on new line
function! Org_addHeader()
    "g:cur is a vector
    let l:cur = getpos('.')
    " do not add extra star on a header
    if getline(l:cur[1]) !~? '^\*.*$'
        let l:head =  Org_getHeaderLine(l:cur[1])
        let l:lvl = Org_countStar(l:head)

        " add stars at beginning plus <space>
        normal o
        exe 'normal 0'.l:lvl.'i*'
        exe 'normal 0ea '
        " exe ":s@^@* @"
    endif
endfunction

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

" returns the line number of the header
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

