" for quickfix list
setl nu
setl signcolumn=yes

if !exists('b:stl_1')
  let b:stl_1=function('framework#epmty_fun')
en

syn match       qfFileName      "^[^|]*" nextgroup=qfSeparator
syn match       qfSeparator     "|" nextgroup=qfLineNr contained
syn match       qfLineNr        "[^|]*" contained contains=qfError
syn match       qfError         "error" contained

" The default highlighting.
hi def link qfFileName  Directory
hi def link qfLineNr    LineNr
hi def link qfError     Error

" delete current QF listing by "dd" command
nnoremap <buffer> <silent> dd <Cmd>call setqflist(filter(getqflist(), {idx -> idx != line('.') - 1}), 'r') <Bar> cc<CR>
