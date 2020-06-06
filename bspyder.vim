" Python Spyder plugin using vim.
"
" WORK IN PROGRESS - much doesn't work yet
"
" Usage notes
" 0. open filename.py then :Spyder
" 1. :Spyder filename.py
" 2. :Spyder spyder_project
"
" Author: shortcipher3
" Copyright: BSD 3
"


if exists(':BSpyder')
  finish
endif

call term_start("bash", {"vertical": 1, "term_finish": "close", "term_name": "console"})
wincmd L
wincmd h

nnoremap g<CR> :0,.+1?^#%%?;/^#%%\\|\%$/call ConsoleSendCell("console")<CR>
vnoremap gc :call ConsoleSendSelection("console")<CR>

function! ConsoleSendSelection(bufname)
  " backup register
  let n = @n
  silent! normal gv"ny
  call term_sendkeys(a:bufname, @n . "\n")
  let @n = n
  " restores the visual selection - works on the first try, but not second?
  normal! gv
endfunction

function! ConsoleSendCell(bufname) range
  if match(getline(a:lastline), "#%%") " matched end of file
    let s:last=a:lastline
  else
    let s:last=a:lastline-1
  endif
    call term_sendkeys(a:bufname, join(getline(a:firstline+1,s:last), "\n") . "\n")
    execute a:lastline
endfunction



