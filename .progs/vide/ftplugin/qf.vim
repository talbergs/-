" for quickfix list
setl nu
setl signcolumn=yes

if !exists('b:stl_1')
  let b:stl_1=function('framework#epmty_fun')
en

syn match	qfFileName	"^[^|]*" nextgroup=qfSeparator

