" This is the first file sourced by nvim (soon after init.vim).
" Custom runtime note.
" - - - - - - - - - - - - - - - - - - -
" - Cause       - Effect                       - Initiator
"   BufRead       (set ft=<>)                    @filetype.vim <<<
"   (set ft=<>)   (set syn=<>) {so ftplugin/<>}  @ftplugin.vim
"                              {so syntax/<>}    @ftplugin.vim
"   (set syn=<>)  {so colors/<>}                 @syntax/syntax.vim
" -
" : One has two options :
" ** Change only syntax highlight (set syn=js2) {meanwhile keeping ft=js).
" ** Use (set ft=js) on scrach buffer to get all js settings.
" - - - - - - - - - - - - - - - -


aug ftdetect

  au BufNewFile,BufRead *.js     setf javascript
  au BufNewFile,BufRead *.js.php setf javascript.php
  au BufNewFile,BufRead *.md     setf md
  au BufNewFile,BufRead *.php    setf php
  au BufNewFile,BufRead *.rust   setf rust
  au BufNewFile,BufRead *.sql    setf sql
  au BufNewFile,BufRead *.txt    setf txt
  au BufNewFile,BufRead *.vim    setf vim
  au BufNewFile,BufRead *.css    setf css
  au BufNewFile,BufRead *.scss   setf scss
  au BufNewFile,BufRead *.json   setf json
  au BufNewFile,BufRead *.html   setf html
  au BufNewFile,BufRead *.toml   setf toml
  au BufNewFile,BufRead *.sh     setf sh
  au BufNewFile,BufRead *.rs     setf rust
  au BufNewFile,BufRead *.c      setf c
  au BufNewFile,BufRead crontab  setf crontab
  au BufNewFile,BufRead .vimrc   setf vim
  au BufNewFile,BufRead COMMIT_EDITMSG   setf gitcommit
  au BufNewFile,BufRead git-rebase*   setf gitrebase

  " guess ft when reading from stdin
  au VimEnter,BufRead   *        call framework#ftguess()

aug END




