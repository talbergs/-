let g:rulog = []
fun! Log(msg)
  call add(g:rulog, a:msg.'|'.strftime('%H:%I:%S').'||')
endfun
command! -nargs=1 Log call Log(<f-args>)
fun! s:dlog()
  lad g:rulog
  lop
endfun
command! DLog call s:dlog()
