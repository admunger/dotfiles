" Author:   Adriel Munger
" Version:  0.1
" Date:     16/02/2019
" Description: 
"   Add simple commenting features to Vim
"   the string "g:CommentStr" is stored in filetype.vim for each specific file
"   can comment, uncomment, and toggle lines in file
"
" highly inspired by : 
"   http://vim.wikia.com/wiki/Comment_Lines_according_to_a_given_filetype
"
" TODO: Still not sure if loading different filetypes will be handled correctly
""""""""""""""""""""""""""""""""""""""""""""""""""""


if exists("g:comm_plugin_loaded")
  finish
endif
let g:comm_plugin_loaded = 1

let g:comment_length = strlen(CommentStr)

nmap <silent> <leader>r :call FT_CommentLines()<CR>
vmap <silent> <leader>r :call FT_CommentLines()<CR>
nmap <silent> <leader>t :call FT_UncommentLines()<CR>
vmap <silent> <leader>t :call FT_UncommentLines()<CR>
imap <C-D> <Esc>:call FT_toggleComment()<CR>a

function! FT_CommentLines() range
    let a_cur = getpos('.')
    "check if we apply to single line or a range
    if a:firstline == a:lastline
        "substitute function with '@' being the separators
        " '.' concatenate parameters of exe
        " g:CommentStr is defined in filetype.vim
        exe ":s@^@".g:CommentStr."@g"
    else
        "specify substitute within range
        exe "'<,'>s@^@".g:CommentStr."@g"
    endif

  " for multiline support : 
  "exe ":s@$@".g:EndComment."@g"
endfunction

function! FT_UncommentLines() range
  "substitute function with '@' being the separators
  " '.' concatenate parameters of exe
  " g:CommentStr is defined in filetype.vim
    if a:firstline == a:lastline 
        exe ":s@^".g:CommentStr."@@g"
    else
        "specify substitute within range
        exe ":'<,'>s@^".g:CommentStr."@@g"
    endif
endfunction

function! FT_check_if_comment()
"    " let g:comment_length = strlen(CommentStr)
    let a:len = g:comment_length
    let a:it = 0
    while a:it < a:len
        if g:CommentStr[a:it] != getline('.')[a:it]
            echo "line is not commented"
            return 0
        endif
        let a:it += 1
    endwhile
    echo "line is commented"
    return 1
endfunction

function! FT_toggleComment()
    let a:check = FT_check_if_comment()

    "no default actions, in case FT_check returns an error
    if  a:check == 1
        call FT_UncommentLines()
    elseif a:check == 0
        call FT_CommentLines()
    endif
endfunction

