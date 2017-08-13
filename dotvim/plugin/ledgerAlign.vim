" some plugins for vim to behave like Ledger mode in Emacs

" Format aligment of money amount relatively to precedent Ledger transaction
" mapped to ,, in normal mode
function LedgerTab()
    " 1. get prefious line with $
    let current = getpos('.')
    normal {
    " search backward, returns [line,col]
    let lastDollar = search('\$','b','W')
    " 2. get column of '.'
    normal f.
    let dotcol = col('.')
    "let dotcol = match(getline('.'),'.')
    " 3. goto current line
    call setpos('.',current)
    " 4. get column of .
    normal 0f$f.
    let curdot = col('.')
    let sumspace = dotcol - curdot - 1
    " 5. inserts x spaces before $, x = col(.) - col(.)
    normal B
    execute "normal i \<Esc>" . sumspace . ".\<Esc>"
endfunction
