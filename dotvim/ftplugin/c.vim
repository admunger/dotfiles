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
"nmap <silent> <C-J> :call C:nextLine()<CR>
"nmap <silent> <C-K> :call C:prevLine()<CR>

nmap <silent> <leader>h :call C_toggleHeader()<CR>
"nmap <silent> <leader>t :call C_toggleTreeList()<CR>

inoremap {<CR> {<CR>}<Esc>ko
"inoremap [ []<Esc>i
"inoremap ( ()<Esc>i


"requires Tbone. Thanks tpope for all your magic
if exists('$TMUX')
   "send make command to last terminal (last-pane = ":.-")
   nmap <silent> <C-b> :Tmux send-keys -t :.- \"make\" Enter<CR>
   nmap <silent> <F5>  :Tmux send-keys -t :.- \"./main\" Enter<CR>
endif

"nmap <silent> <C-B> :make
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
function! C_toggleHeader()
    let v_ext = expand('%:e')
    let v_name = expand('%:t') " only the filename
    let v_noext = expand('%:t:r')
"     let v_fullname = expand('%:.')
    if v_ext != 'h'
        " locate source file 
        let v_regex = v_noext . ".h*"
        let v_newfile = v_noext . ".h"
    else
        let v_regex = v_noext . ".c[cxp]*"
        let v_newfile = v_noext . ".cxx"
    endif

    " check if we need to use tag
    if bufexists(v_newfile) == 0
"         exec 'tag ' . v_regex 
        exec 'tag ' . v_newfile
    else
        exe 'buffer ' expand(v_newfile)
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

"====== vimscript help ======
"all references -> :help eval
"function list  -> :help functions

