" filetype=c"filetype=c
" Author:   Adriel Munger
" Version:  0.1
" Date:     24/08/2017

"HEADER GUARD to avoid including this file multiple times
if exists("g:c_ftplugin_loaded")
  finish
endif
let g:c_ftplugin_loaded = 1

"KEY MAPPINGS
"jump to next line containing an executable line
nmap <silent> <C-J> :call C:nextLine()<CR>
nmap <silent> <C-K> :call C:prevLine()<CR>

nmap <silent> <leader>h :call C:toggleHeader()<CR>
nmap <silent> <leader>t :call C:toggleTreeList()<CR>
vmap <silent> <leader>r :call C:wrapComment()<CR>
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

"Descr : when in a C file, toggle to the header equivalent and vice-versa
"one liners that toggle from header to source : 
":e %:r.cpp
":e %<.cpp
function! C:toggleHeader()
    let v_ext = expand('%:e')
    let v_fullname = expand('%:.') "relative to home path
    if v_ext == 'c'
        "allows to use header in same folder as source
        if  !empty(globpath('.','src/*.h'))
            "substitute({expr}, {pat}, {sub}, {flags})
            let v_newfile = substitute(v_fullname,'.c$','.h',"")
        else
            let v_newfile = substitute(v_fullname,'Src','Inc',"")
            let v_newfile = substitute(v_newfile,'.c$','.h',"")
        endif
    elseif v_ext == 'h'
        "substitute({expr}, {pat}, {sub}, {flags})
        let v_newfile = substitute(v_fullname,'Inc','Src',"")
        let v_newfile = substitute(v_newfile,'.h$','.c',"")
    endif
    if bufexists(v_newfile) == 0
        if filereadable(v_newfile) == 1
            exe 'edit' v_newfile
        else
            echo "File " . v_newfile . " does not exist!"
        endif
    else
        exe 'buffer' expand(v_newfile)
    endif
endfunction

"function that enables to have file tree and function list in a convenient split
function! C:toggleTreeList()
    if g:Tlist_Use_Split_Window == 0
        let g:Tlist_Use_Split_Window = 1
        let g:Tlist_WinWidth=20
        NERDTree | TlistOpen
        "autocmd VimEnter * NerdTree | TlistOpen
    else
        let g:Tlist_Use_Split_Window = 0
        NERDTreeClose | TlistClose
    endif
endfunction

function! C:wrapComment() range
    "echo "firstline ".a:firstline." lastline ".a:lastline
    if a:firstline == a:lastline
        normal 0i//
    else
        execute "normal '<_i/* "
        let a:iter = a:firstline
        while a:iter < a:lastline
            execute "normal j_i * "
            let a:iter += 1
        endwhile
        normal '>_o*/
        normal v'<=
    endif
endfunction

"====== vimscript help ======
"all references -> :help eval
"function list  -> :help functions

