" filetype=c"filetype=c
" Author:   Adriel Munger
" Version:  0.1

"header guard to avoid including this file multiple times
if exists("g:c_ftplugin_loaded")
  finish
endif
let g:c_ftplugin_loaded = 1

"jump to next line containing an executable line
nmap <silent> <C-J> :call C:nextLine()<CR>
nmap <silent> <C-K> :call C:prevLine()<CR>
"
"echo a variable during debug : 
"echo varName

"append ! to avoid multiple definitions of same functions
function! C:nextLine()
    "search for next line with pattern
    normal 0j
    " line starting with (space OR tab), one or many times, followed
    "   by a word (\w), goto end of match 'e', don't Wrap 'W'
    let v_next = search('^[ \t]*\w','eW')
    echo v_next
    call setpos('.',v_next)
endfunction

function! C:prevLine()
    "search for next line with pattern
    normal 0k
    let v_next = search('^[ \t]*\w','bW')
    echo v_next
    call setpos('.',v_next)
    normal _
endfunction
