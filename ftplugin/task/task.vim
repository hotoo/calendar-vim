" TaskList plugin for Calendar.
" @author 闲耘™(hotoo.cn[AT]gmail.com)
" @version 1.0 2010/09/01

setlocal formatoptions+=o
"setlocal comments-=mb:*
"setlocal comments+=:*\ [.]
"setlocal comments+=:*\ [o]
"setlocal comments+=:*\ [O]
"setlocal comments+=:*\ [X]

setl comments=b:*\ [\ ],b:*,b:#,b:-
setl formatlistpat=^\\s*[*#-]\\s*

function! s:kbd_oO(cmd) "{{{
  " cmd should be 'o' or 'O'

  let beg_lnum = foldclosed('.')
  let end_lnum = foldclosedend('.')
  if end_lnum != -1 && a:cmd ==# 'o'
    let lnum = end_lnum
    let line = getline(beg_lnum)
  else
    let line = getline('.')
    let lnum = line('.')
  endif

  " let line = substitute(m, '\s*$', ' ', '').'[ ] '.li_content
  let m = matchstr(line, '^\s*[*#-]')
  let res = ''
  if line =~ '^\s*[*#-][! ~]\[.\]\s'
    let res = substitute(m, '\s*$', ' ', '').'[ ] '
  elseif &autoindent || &smartindent
    let res = matchstr(line, '^\s*')
  endif
  if a:cmd ==# 'o'
    call append(lnum, res)
    call cursor(lnum + 1, col('$'))
  else
    call append(lnum - 1, res)
    call cursor(lnum, col('$'))
  endif
endfunction "}}}
nnoremap <buffer> o :call <SID>kbd_oO('o')<CR>a
nnoremap <buffer> O :call <SID>kbd_oO('O')<CR>a

function! s:ToggleImportant()
    let line=getline(".")
    if line =~ '^\s*[*#-]!\[.\]\s'
        call setline(".", substitute(line, "!", " ", ""))
    else
        call setline(".", substitute(line, '^\(\s*[*#-]\)[~ ]', '\1!', ""))
    endif
endfunction
function! s:ToggleMinor()
    let line=getline(".")
    if line =~ '^\s*[*#-]\~\[.\]\s'
        call setline(".", substitute(line, '\~', " ", ""))
    else
        call setline(".", substitute(line, '^\(\s*[*#-]\)[! ]', '\1\~', ""))
    endif
endfunction
nnoremap <buffer> ! :call <SID>ToggleImportant()<cr>
nnoremap <buffer> ~ :call <SID>ToggleMinor()<cr>


nmap = :call TaskAddTitle()<cr>
nmap - :call TaskDelTitle()<cr>
function! TaskAddTitle()
    let line=line(".")
    let text=getline(".")
    if text !~ "^=.*=$"
        let text = " ".text." "
    endif

    call setline(line, "=".text."=")
endfunction
function! TaskDelTitle()
    let line=line(".")
    let text=getline(".")
    let len=strlen(text)
    if text =~ "^=.*=$"
        call setline(line, strpart(text,1,len-2))
    endif
endfunction
