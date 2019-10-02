fun filetree#evt#subbuf(bufnr)
  cal filetree#sys#notify('subscribe-buf', a:bufnr,
    \ getcwd(-1, nvim_get_current_tabpage()))
endf


