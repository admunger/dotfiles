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
if !exists("g:comment_length")
    let g:comment_length = 1
end

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
        " this regex adds a comment after the indentation
        exe ":s@\\(^[ ]*\\)@\\1".b:bufComment." @g"
    else
        "specify substitute within range
        "for a block we don't care about indentation
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
        exe ":s@^[ ]*".b:bufComment."@@g"
		" this allows to remove the space after comment symbol
		normal V=
    else
        "specify substitute within range
        exe ":'<,'>s@^[ ]*".b:bufComment."@@g"
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
    let l:len = g:comment_length
    let l:it = 0
    while l:it < l:len
        if b:bufComment[l:it] != getline('.')[l:it]
            echo "line is not commented"
            return 0
        endif
        let l:it += 1
    endwhile
    echo "line is commented"
    return 1
endfunction

function! FT_toggleComment()
    let l:check = FT_check_if_comment()

    "no default actions, in case FT_check returns an error
    if  l:check == 1
        call FT_UncommentLines()
    elseif l:check == 0
        call FT_CommentLines()
"         normal a 
    endif
endfunction

" sets the variable b:bufComment specific to each buffer
function! FT_getComment()
    let l:comment = "#"
    let l:ft = &ft

    if     l:ft == 'vim'      | let l:comment = "\""
    elseif l:ft == 'c'        | let l:comment = "//"
    elseif l:ft == 'cpp'      | let l:comment = "//"
    elseif l:ft == 'lisp'     | let l:comment = ";;"
    elseif l:ft == 'matlab'   | let l:comment = "%"
    elseif l:ft == 'dosbatch' | let l:comment = "::"
    elseif l:ft == 'xml'      | let l:comment = "<!--"
    endif

    return l:comment
endfunction

