fun! filetree#toggle()
  if exists('t:filetree')
    cal filetree#ctrl#hide()
    unl t:filetree
  el
    cal filetree#ctrl#show()
    let t:filetree=1
  en
endf

fun! filetree#focus()
  if !exists('t:filetree')
    cal filetree#ctrl#show()
    let t:filetree=1
  en
  cal filetree#ctrl#focus()
endf

fun! filetree#toggle2()
  exe 'vnew | vert res 30'

  let bufcontent = ['line 1']

  " setlocal noshowcmd
  " setlocal noswapfile
  " setlocal buftype=nofile
  " setlocal bufhidden=wipe
  " setlocal nobuflisted
  " setlocal nomodifiable
  " setlocal nowrap
  " setlocal nonumber
  " setlocal filetype=bufferhint
  " setlocal signcolumn=no
  " setlocal modifiable

  put! = bufcontent
  " setlocal nomodifiable

endf

fun filetree#subtab()
  echom "each tab may have tree to different path"
endf
