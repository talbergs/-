" This is the first file sourced by nvim (soon after init.vim).
" Custom runtime note.
" - - - - - - - - - - - - - - - - - - -
" - Cause       - Effect                       - Initiator
"   BufRead       (set ft=<>)                    @filetype.vim
"   (set ft=<>)   (set syn=<>) {so ftplugin/<>}  @ftplugin.vim
"                              {so syntax/<>}    @ftplugin.vim
"   (set syn=<>)  {so colors/<>}                 @syntax/syntax.vim <<<
" -
" : One has two options :
" ** Change only syntax highlight (set syn=js2) {meanwhile keeping ft=js).
" ** Use (set ft=js) on scrach buffer to get all js settings.
" - - - - - - - - - - - - - - - -

aug syntaxhandle
  au syntax * ru syntax/<amatch>.vim
	au syntax * ru ftcolors/<amatch>.vim
aug END
