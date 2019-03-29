" Author:   Adriel Munger
" Version:  0.2
" Date:     16/02/2019
" Description: 
"   Add simple commenting features to Vim
"   the string "b:bufComment" is stored in filetype.vim for each specific file
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

" sets the Comment string to each filetype at load
autocmd BufReadPost,BufNewFile * let b:bufComment = FT_getComment()

" autocmd BufReadPost,BufNewFile *.* let b:bufComment = FT_getComment()

" let b:buffComm = b:bufComment
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
        " b:bufComment is defined with FT_getComment
        exe ":s@^@".b:bufComment." @g"
    else
        "specify substitute within range
        exe "'<,'>s@^@".b:bufComment." @g"
    endif
    " we add 1 to include the space width
    let a_cur[2] += strlen(b:bufComment) + 1
"     echo a_cur
    call setpos('.',a_cur)

  " for multiline support : 
  "exe ":s@$@".g:EndComment."@g"
endfunction

function! FT_UncommentLines() range
  "substitute function with '@' being the separators
  " '.' concatenate parameters of exe
  " b:bufComment is defined with FT_getComment
    let a_cur = getpos('.')
    if a:firstline == a:lastline 
        exe ":s@^".b:bufComment."@@g"
		" this allows to remove the space after comment symbol
		normal V=
    else
        "specify substitute within range
        exe ":'<,'>s@^".b:bufComment."@@g"
		" this allows to remove the space after comment symbol
		normal '<V'>=
    endif
    " we sub 1 to include the space width
    let a_cur[2] -= strlen(b:bufComment) + 1
"     echo a_cur
    call setpos('.',a_cur)
endfunction

function! FT_check_if_comment()
"    " let g:comment_length = strlen(CommentStr)
    let a:len = g:comment_length
    let a:it = 0
    while a:it < a:len
        if b:bufComment[a:it] != getline('.')[a:it]
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
"         normal a 
    endif
endfunction

" sets the variable b:bufComment specific to each buffer
function! FT_getComment()
    let a:comment = "#"
    let a:ft = &ft

    if     a:ft == 'vim'      | let a:comment = "\""
    elseif a:ft == 'c'        | let a:comment = "//"
    elseif a:ft == 'cpp'      | let a:comment = "//"
    elseif a:ft == 'lisp'     | let a:comment = ";;"
    elseif a:ft == 'matlab'   | let a:comment = "%"
    elseif a:ft == 'dosbatch' | let a:comment = "::"
    endif

    return a:comment
endfunction

