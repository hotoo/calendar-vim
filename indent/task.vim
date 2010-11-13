"=============================================================================
" FILE: task.vim
" AUTHOR:  闲耘™(hotoo.cn[AT]gmail.com)
" Last Modified: 2010/09/01
"=============================================================================

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

setlocal expandtab
setlocal shiftwidth=4
setlocal softtabstop=4
if !exists('b:undo_indent')
    let b:undo_indent = ''
endif

setlocal indentexpr=TasksIndent()

function! TasksIndent() "{{{
    let l:line = getline('.')
    let l:prev_line = (line('.') <= 1)? '' : getline(line('.')-1)

    if l:prev_line =~ '^\s*$'
        return 0
    else
        return match(l:line, '\S')
    endif
endfunction "}}}

"let b:undo_indent .= '
    "\ | setlocal expandtab< shiftwidth< softtabstop<
    "\'
