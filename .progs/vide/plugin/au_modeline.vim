" executes custom modeline when buf written
"
" "auf:" space separated and followed by script (script receives filename as argument)
" "au:" same as above, but script is just executed
"
" Example: to notify a filename on write (useless)
"
"    auf: notify-send -u critical
"
" Note: preceding ":" is not supported

aug AuModeLine
  au! BufWritePost * cal jobstart('vide-au-modeline '.expand('<afile>:p').' &')
aug END
