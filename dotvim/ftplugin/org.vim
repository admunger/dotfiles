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
if exists("b:org_ftplugin_loaded")
"     source ~/.vim/plugin/comments.vim
    finish
endif

let b:org_ftplugin_loaded = 1

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

nnoremap <buffer> <silent> <C-j> :call Org_gotoSameLevel(1)<CR>
nnoremap <buffer> <silent> <C-k> :call Org_gotoSameLevel(-1)<CR>
inoremap <buffer> <silent> <C-j> <Esc>ms:call Org_addHeader()<CR>a

" allows to change level of header
inoremap <buffer> <silent> <C-l> <Esc>:call Org_HeaderLevelPlus()<CR>a
inoremap <buffer> <silent> <C-h> <Esc>:call Org_HeaderLevelMinus()<CR>a

" timestamp
" LANG=fr_CA.UTF-8
" prints date in french
nnoremap <buffer> <leader>d :call Org_printDate()<CR>
nnoremap <buffer> <localleader><C-i> :call Org_startTimestamp()<CR>
nnoremap <buffer> <localleader><C-o> :call Org_EndTimestamp()<CR>

" check boxes
nnoremap <buffer> <localleader><C-x> :call Org_insertCheckmark()<CR>

" increment numbered list
inoremap <buffer> <localleader><CR> <C-o>:call Org_add_numbered_item()<CR>


" folding remappings
nnoremap <buffer> <tab> za
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

"quickfix remap
nnoremap ]q :cnext<CR>zO
nnoremap [q :cprevious<CR>zO
cnoreabbrev dashboard call Org_createDashboard()
cnoreabbrev dash call Org_createDashboard()

"when in buffer, try to insert checkmark
"when in quickfix, update dashboard
" nnoremap <expr> <localleader><C-x> &buftype ==# 'quickfix' ? ":call Org_updateDashboard()<CR>" : ":call Org_insertCheckmark()<CR>"

"open dashboard
nnoremap <buffer> <localleader><C-d> :call Org_updateDashboard()<CR>



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

"toggle checkmark
" if there is "[ ]" inside the line, it add X in it
" else if there is "[X]" it changes it to "[ ]"
function! Org_insertCheckmark()

    normal _
    "get character under cursor, capture single-byte simple characters
    let l:line = getline('.')

    " find if there is a checkbox "[ ]

    "check if 1st chacracter is a dash
    if(l:line =~ "\\[ ]")
        let l:newline = substitute(l:line, "\\[ ]", "[X]", "g")
        " echo l:newline
        call setline(line('.'), l:newline)
    elseif(l:line =~ "\\[X]")
        let l:newline = substitute(l:line, "\\[X]", "[ ]", "g")
        " echo l:newline
        call setline(line('.'), l:newline)
    endif

"     if(l:line[col('.')-1] =~ "[-]")
"         normal r√
"     " use matchstr to capture complex digraphs
"     elseif(matchstr(l:line, '\%' . col('.') . 'c.') == "√" )
"         normal r-
"     endif
    
endfunction

"can only be used in INSERT mode
function! Org_add_numbered_item()
    let l:line = getline('.')

    "detects that the current line is a numbered item
    if (l:line =~ " *[0-9]\\+[).-][ ]*")
        "get number starting the item
        let l:num = substitute(l:line, "\\([0-9]\\+\\).*", "\\1","g")
        "get "." or ")" or "-" following number

        "we keep only the 1st character and a space (if present) after the number
        "this removes space before the number and character after separator
        let l:separator = substitute(l:line, " *[0-9]\\+\\([).-][ ]\\?\\).*","\\1","g")

        let l:num = str2nr(l:num)
        let l:num += 1

        "fetch number
"         let l:header = substitute(l:line, "\([0-9]\+[.-]\)", "\1")
"         echo l:header
        exe ":normal o" . l:num . l:separator
    else
        normal o
    endif
endfunction

" returns the line numbers with a Org directive (#! ...)
function! Org_get_directives()
    " assuming directives are only within the first 50 lines
    " can only deal with 1 instructions

    "save cursor position

" 		    [0, lnum, col, off, curswant] ~
    let l:cur = getcurpos()


    call cursor(1,1)
    let l:num = search("^#!", "nc", 50)
    "if a match had been found
    if l:num != 0
        "check FOLDLEVEL directive
        if getline(l:num) =~# ".*FOLDLEVEL.*"
            call Org_set_foldlevel(l:num)
        endif
    endif

    call cursor(l:cur[1], l:cur[2])


endfunction

function! Org_set_foldlevel(line)
    " retrieve ORG command
    let directive = substitute(getline(a:line),"^#![ ]*","","")

    let foldlvl = substitute(getline(a:line), "#![ ]*FOLDLEVEL:\\([0-9]\\).*","\\1","")

    "echo "Org instruction : fold level = " . foldlvl

    exe ":set foldlevel=".foldlvl


endfunction

"uses the location buffer feature to display all remaining TODO in an agenda
"if the location window doesn't exist, create it
"location buffer allows to search within only one window
function Org_createDashboard()
    let g:qfix_name = bufname("%")

    " search all TODO not in a comment or in a header
    exe ":vimgrep /^[ ]*[^#*]*[ ]*TODO/ %"
    copen
    " endif
endfunction

function Org_updateDashboard()
    if !exists("g:qfix_name")
        " we're in the .org buffer
        let g:qfix_name = bufname("%")
        exe ":vimgrep /^[ ]*[^#*]*[ ]*TODO/ " .g:qfix_name

        "we jump to the first TODO item
        normal zO
        cfirst
    else
        exe ":vimgrep /^[ ]*[^#*]*[ ]*TODO/ " .g:qfix_name
    endif

"     let list = getloclist(0,
"     setloclist(0,  
 endfunction


"execute ORG directive when opening file
call Org_get_directives()


" Vim variables prefixes
" in SCRIPT : 
"       a:var (function argument)
"   let g:var_global
"   let s:var_local (to script), also available to function names
"   let l:var_local (to function)
" in VIM : 
"   let w:var_local (to window)
"   let b:var_local (to buffer)
"   let t:var_local (to tab)
