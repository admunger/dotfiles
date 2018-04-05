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
nmap <leader>r :call M:toggleComment()<CR>
vmap <silent> <leader>r :call M:wrapComment()<CR>
"jump to next section
nmap <silent> <C-j> :call search('^%% ','W',line('$'))<CR>
nmap <silent> <C-k> :call search('^%% ','bW',line('0'))<CR>
vmap <silent> <C-j> /^%%<space><CR>
vmap <silent> <C-k> ?^%%<space><CR>

"jump to next instruction line
nmap <silent> J :call search('^[ \t]*\w','W',line('$'))<CR>
nmap <silent> K :call search('^[ \t]*\w','bW',line('0'))<CR>
vmap <silent> J /^[ \t]*\w<CR>
vmap <silent> K ?^[ \t]*\w<CR>

"stores selection in a scratch file
vmap <leader>q :w! scratch_.m<CR>gv<ESC>

"simple function to auto-comment selected lines
function! M:wrapComment() range
    let a_cur = getpos('.')
    "echo "firstline ".a:firstline." lastline ".a:lastline

    "check if we apply to single line or a range
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
    call setpos('.',a_cur)
endfunction

function! M:unwrapComment()
    "get position of cursor
    let a_cur = getpos('.')
    "goto first comment
    let a_str = getline('.')[0]

    "delete comment character
    if a_str == '%'
        normal 0xV=
    else
        normal 0f%xV=
    endif
    call setpos('.',a_cur)
endfunction

function! M:toggleComment()
    let a_cur = getpos('.')
    "get first character in line
    normal ^
    let a_char = getline('.')[col('.')-1]
    call setpos('.',a_cur)

    "if first nonblank character is a comment
    if a_char == '%'
        call M:unwrapComment()
    else
        call M:wrapComment()
    end
endfunction

function! M:scratch()
    "temporary, avoid destroying current buffer during function
    write
    edit _scratch_
    normal ggdG"0p
    "normal ggdG
endfunction
