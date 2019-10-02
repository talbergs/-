fun! filetree#ctrl#hide()
  for w in nvim_tabpage_list_wins(nvim_get_current_tabpage())
    if nvim_win_get_buf(w) == t:filetree_bufnr
      let t:filetree_vert_res=nvim_win_get_width(w)
      cal nvim_win_close(w, 0)
      brea
    en
  endfor
endf

fun! filetree#ctrl#show()
  exe 'vnew filetree'.nvim_get_current_tabpage()
  if !exists('t:filetree_vert_res')
    let t:filetree_vert_res=30 |en
  exe 'vert res '.t:filetree_vert_res
  if exists('t:filetree_bufnr')
    retu |en
  setl stl=filetree
  setf filetree
  let t:filetree_bufnr=bufnr('%')
  cal filetree#evt#subbuf(t:filetree_bufnr)
  put! ='loading..'
endf

