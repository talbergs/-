" This is the first file sourced by nvim (soon after init.vim).
" Custom runtime note.
" - - - - - - - - - - - - - - - - - - -
" - Cause       - Effect                       - Initiator
"   BufRead       (set ft=<>)                    @filetype.vim
"   (set ft=<>)   (set syn=<>) {so ftplugin/<>}  @ftplugin.vim <<<
"                              {so syntax/<>}    @ftplugin.vim <<<
"   (set syn=<>)  {so colors/<>}                 @syntax/syntax.vim
" -
" : One has two options :
" ** Change only syntax highlight (set syn=js2) {meanwhile keeping ft=js).
" ** Use (set ft=js) on scrach buffer to get all js settings.
" - - - - - - - - - - - - - - - -


fun s:setall(fts)
  for ft in split(a:fts, '\.')
    cal s:setone(ft)
  endfor
endf

fun s:setone(ft)
  exe 'ru ftplugin/'.a:ft.'.vim'
  let &syn=a:ft
endf

aug ftplugin
  au FileType * call s:setall(expand('<amatch>'))
aug END
