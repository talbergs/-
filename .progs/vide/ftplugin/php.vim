setl ts=4 nu rnu fdm=indent fo+=r cc=120 scl=yes
setl includeexpr=substitute(v:fname,'/','./','')
setl include=\\\(require\\\|include\\\)\\\(_once\\\)\\\?

let b:coc_current_function=''
fun! s:stl_11()
	if b:coc_current_function == ''
    return ''
  en
	return b:coc_current_function. ' '
endf
let b:stl_1=function('s:stl_11')

nn <silent><buffer> gr :call CocAction('jumpReferences')<cr>
nn <silent><buffer> K :call CocAction('doHover')<cr>
nn <silent><buffer> gh :call CocAction('highlight')<cr>
