fun util#set_tabname_i()
  let l:name = input('Use % for bufname. Name this tab: ')
	if l:name != ''
		call util#set_tabname(l:name)
	en
endf

fun util#set_tabname(name)
  let t:tabname = a:name
	let &tal=&tal
endf

fun util#sudo_takeover()
" TODO:
endf

" List: Toggles buffer 'useful noise' mode
fun util#verbose_buf()
	if exists('b:verbose_buf')
		unl b:verbose_buf
		setl nolist
		if &l:nu | setl rnu | en
		setl nosc
		setl ve=
		if &l:spell | setl nospell | en
	el
		let b:verbose_buf=0
		setl list
		if &l:nu | setl nornu | en
		setl sc
		setl ve=block
		if !&l:spell | setl spell | en
	en

	let &l:stl=framework#statusline()
endf
