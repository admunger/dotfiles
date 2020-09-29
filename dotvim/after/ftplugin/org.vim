" Author : Adriel Munger
" Date   : august 4 2019
" Descr  : basic Emacs's org file interpreter
"
" Features : - Header folding
"            - ...

" HELPER/SHORTCUTS IN PLUGIN
"-----------------------------------------
" [z : goto parent header of lower level
" ]z : goto end of current header section
" zo : open fold
" zO : open recursively fold under header
"
" C-x C-i : clock-in timestamp
" C-x C-o : clock-out timestamp

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
setlocal foldlevel=0
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

nmap <buffer> <silent> <C-j> :call Org_gotoSameLevel(1)<CR>
nmap <buffer> <silent> <C-k> :call Org_gotoSameLevel(-1)<CR>
imap <buffer> <silent> <C-j> <Esc>ms:call Org_addHeader()<CR>a

" allows to change level of header
imap <buffer> <silent> <C-l> <Esc>:call Org_HeaderLevelPlus()<CR>a
imap <buffer> <silent> <C-h> <Esc>:call Org_HeaderLevelMinus()<CR>a


nmap <buffer> <localleader><C-i> :call Org_startTimestamp()<CR>
nmap <buffer> <localleader><C-o> :call Org_EndTimestamp()<CR>

" LANG=fr_CA.UTF-8
" prints date in french
nmap <buffer> <leader>d :call Org_printDate()<CR>

" folding remappings
nmap <buffer> <tab> za
" nmap <buffer> <tab> :call Org_cycleVisibility()<CR>
"open recursively even if partially open

" opening folds in visual is actually easier
nnoremap zO zoV]zzO
" nnoremap zO zCzO
" nnoremap zO :call Org_foldOpenRecursive()<CR>
nnoremap zC :call Org_foldCloseRecursive()<CR>

nnoremap K <NOP>

" variables local to script
let s:maxLevel = 5

" nnoremap <buffer> j j:echo foldlevel('.')<CR>
" nnoremap <buffer> k k:echo foldlevel('.')<CR>


function! Org_gotoSameLevel(dir)
    let l:line = line('.')
    let l:lvl = foldlevel(l:line)
    if a:dir == 1
        call search('^\*\{'.l:lvl.'} ','W')
    else
        call search('^\*\{'.l:lvl.'} ','bW')
    endif
endfunction

" replaced by builtin "za"
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
    "getpos = [bufnum, lnum, col, off]
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

function! Org_printDate()
    " :read !LANG=fr_CA.UTF-8;date "+\%a. \%d \%B"<CR>
    " uncomment /etc/locale.gen
    " sudo locale-gen

    ":r !date "+\%a \%B \%d, 
    " read !date "+<\%d-\%m-\%Y \%H:\%M>"
    let l:date = system("LANG=fr_CA.UTF-8;date '+\%a. \%d \%B'")
    let l:date = l:date[:-2]
    " call setline('.',l:date)
    exe ":normal A".l:date
endfunction

"TODO : always put timestamp under ** header
function! Org_startTimestamp()
    ":r !date "+\%a \%B \%d, 
    " read !date "+<\%d-\%m-\%Y \%H:\%M>"
    let l:date = system("date +'<%d-%m-%Y %H:%M>'")
    let l:date = l:date[:-2]
    " call setline('.',l:date)
    exe ":normal A".l:date
    normal >>$
endfunction

"TODO : must do the time calculation and printing it at the end
function! Org_EndTimestamp()
    ":r !date "+\%a \%B \%d, 

    "get line with specific header to stop backward search
    let l:header_line = search('^\* ','bn')

    " search for previous timestamp between cursor and header
    let l:head = search('[ ]*<[0-9]\{2}-[0-9]\{2}-[0-9]\{4}','b',l:header_line)

    "if already a date in the line
    let l:starttime = getline('.')
    let l:date = system("date +'<%d-%m-%Y %H:%M>'")

    " remove trailing newline after system command
    let l:date = l:date[:-2]
    " let l:date = substitute(l:date,'\n','','')

    " print closing time
    exe ":normal A - ".l:date
    
    " calculate timestamp difference

    "this sections handle when work is done overnight
    let l:date0 = matchstr(l:starttime,'[0-9]\{2}-[0-9]\{2}-[0-9]\{4}')
    let l:d0 = l:date0[0:1]
    "end day
    let l:date1 = matchstr(l:date,'[0-9]\{2}-[0-9]\{2}-[0-9]\{4}')
    let l:d1 = l:date1[0:1]
    if l:d1 > l:d0
        let l:add = (l:d1 - l:d0)*24
    else
        let l:add = 0
    endif

    " start hours
    let l:start = matchstr(l:starttime,'[0-9]\{2}:[0-9]\{2}')
    let l:shour = l:start[0:1]
    let l:smin  = l:start[3:4]

    "end hour
    let l:end   = matchstr(l:date,'[0-9]\{2}:[0-9]\{2}')
    let l:ehour = l:end[0:1] + l:add
    let l:emin  = l:end[3:4]

    let l:diff  =  (l:emin - l:smin) + (l:ehour - l:shour)*60
    let l:hour  = l:diff / 60
    let l:min   = l:diff % 60
    if len(l:min) == 1
        let l:min = '0'.l:min
    endif
    exe ":normal A -> ".l:hour.":".l:min

endfunction

"if at end of line, it should start on new line
function! Org_addHeader()
    "g:cur is a vector
    let l:cur = line('.')
    " do not add extra star on a header
    if getline(l:cur) !~? '^\*.*$'
        let l:head =  Org_getHeaderLine(l:cur)
        let l:lvl = Org_countStar(l:head)

        " add stars at beginning plus <space>
        normal o
        exe 'normal 0'.l:lvl.'i*'
        exe 'normal 0ea '
        " exe ":s@^@* @"
    endif
endfunction

" describes to Vim how to fold lines
" returns the foldlevel, append '>' for start of folds
function! Org_getFold(lnum)
    let l:level = '0'
    
    if getline(a:lnum) =~? '^\*\+ .*$'
        " allows to separate headers from each other
        let l:level1 = Org_countStar(a:lnum)
        " this line starts the fold level
        let l:level = '>' . l:level1
    else
        let l:curr =  Org_getHeaderLine(a:lnum)
        " count the number of '*' from the previous header
        let l:level = Org_countStar(l:curr)
    endif

    " echo 'now at level ' . l:level
    return l:level
endfunction

" closes each header of higher level within section
function! Org_foldCloseRecursive()
    let l:pos = getpos('.')
    let l:line = l:pos[1]
    normal ]z
    " greater and match case 
    while line('.') ># l:line
        normal zck
    endwhile
    call setpos('.',l:pos)
endfunction

" closes each header of higher level within section
" there's a lot of stuff not working with this implementation
function! Org_foldOpenRecursive()
    let l:pos = getpos('.')
    let l:line = l:pos[1]
    normal zo]z
    while line('.') ># l:line
"         if foldclosed('.') == -1
"             normal k
"         else
"             normal zo
"         endif
        " maximum of 3 levels to open in fold
        normal zozozok
    endwhile
    call setpos('.',l:pos)
endfunction

function! Org_countStar(lnum)
    let l:str = getline(a:lnum)
    let l:max = strlen(l:str)
    if l:max > s:maxLevel
        let l:max = s:maxLevel
    endif
    let l:count = 0
    
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

