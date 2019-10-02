let s:bin = resolve(expand('<sfile>:p:h') . '/../../target/debug/ctrlp-rs')

if ! exists('s:job_id')
  let s:job_id = 0
en
au VimLeavePre * cal filetree#sys#shutdown()

fun filetree#sys#notify(method, ...)
  if !filetree#sys#init() |retu |en
  cal call('rpcnotify', [s:job_id, a:method] + a:000)
endf

fun filetree#sys#shutdown()
  if s:job_id < 1 |retu |en
  cal rpcnotify(s:job_id, 'shutdown')
  if -1 == jobwait(s:job_id, 500)
    cal jobstop(s:job_id) |en
  let s:job_id = 0
endf

fun filetree#sys#init()
  let result = s:startup()
  if -2 == result
    retu v:true
  elsei 0 == result
    echoerr "filetree: Failed to start process"
    retu v:false
  elsei -1 == result
    echoerr "filetree: Binary not executable"
    retu v:false
  el
  let s:job_id = result
  retu v:true
endf

fun s:startup()
  if s:job_id < 1
    let id = jobstart([s:bin], { 'rpc': v:true, 'on_stderr': function('s:display_error') })
    retu id
  en
  retu -2
endf

fun s:display_error(id, data, event) dict
  echom 'filetree error: ' . a:event . join(a:data, "\n")
  cal filetree#sys#shutdown()
endf
