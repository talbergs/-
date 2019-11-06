setl nu
setl cms=\"%s
setl ts=2
setl noet
setl isk+=#
setl kp=:h
setl fdm=marker
" Wordmotion up to # char
setl isk-=#
" Set 'formatoptions' to break comment lines but not other lines,
" and insert the comment leader when hitting <CR> or using "o".
setl fo-=t fo+=croql
setl et
