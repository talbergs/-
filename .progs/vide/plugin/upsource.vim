" run upwards from CWD and source first .vimrc if found
let local_vimrc = ".vimrc"
let path_parts = split(getcwd(), "/")

while len(path_parts)
  let local_path = "/" . join(path_parts, "/") . "/" . local_vimrc
  if filereadable(local_path)
      exe ":so " . local_path
      break
  endif
  call remove(path_parts, -1)
endwhile

unlet local_vimrc local_path path_parts   
