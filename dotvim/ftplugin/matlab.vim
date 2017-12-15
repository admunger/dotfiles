" Author: Adriel Munger
" Version: 0.1
" Date: 13/12/2017
" Descr: Plugin for Matlab script files

"HEADER GUARD to avoid including this file multiple times
if exists("g:m_ftplugin_loaded")
  finish
endif
let g:m_ftplugin_loaded = 1

"this map comments only the line of the cursor
nmap <silent> <leader>r :call M:wrapComment()<CR>
vmap <silent> <leader>r :call M:wrapComment()<CR>

"simple function to auto-comment selected lines
function! M:wrapComment() range
    "echo "firstline ".a:firstline." lastline ".a:lastline
    if a:firstline == a:lastline
        execute "normal 0i% "
    else
        execute "normal '<0i% "
        let a:iter = a:firstline
        while a:iter < a:lastline
            execute "normal j0i% "
            let a:iter += 1
        endwhile
        "normal v'<=
    endif
endfunction
