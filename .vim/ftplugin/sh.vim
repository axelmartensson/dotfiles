let b:undo_ftplugin = ''

set foldenable
let b:undo_ftplugin .= 'set foldenable&'
set foldmethod=syntax
let b:undo_ftplugin .= 'set foldmethod&'
" function folding
let g:sh_fold_enabled=1
let b:undo_ftplugin .= 'unlet g:sh_fold_enabled'

" make words-with-hyphens count as one word
set iskeyword+=-

nmap <buffer> <silent> <Leader>r :call <SID>execute_cfile()<CR>
let b:undo_ftplugin .= 'nunmap <Leader>r'

let b:undo_ftplugin .= '|delf <SID>execute_cfile'
fun <SID>execute_cfile()
	if <SID>is_existing() != 0
		return
	endif
	write
	let cfile = expand('%:p:S')
	call <SID>execute(cfile)
endfun

let b:undo_ftplugin .= '|delf <SID>execute'
fun <SID>execute(cfile)
	" TODO concatenation, spaces, what happens, is 
	" interpreted as first argument, parentheses?
	execute 'Dispatch '.a:cfile

endfun

let b:undo_ftplugin .= '|delf <SID>is_existing'
fun <SID>is_existing()
	let EXISTING_FILE = 0
	let NOFILE = 1
	let NEW_FILE = 2
	if &buftype != ''
		echo "NOFILE""
		return NOFILE
	endif
	let file = expand("%:p")
	if file == ''
		echo "NEW_FILE""
		return NEW_FILE
	endif
	return EXISTING_FILE
endfun

let b:undo_ftplugin .= '|delf <SID>test_new_file()'
fun! <SID>test_new_file()
	let expected = 2
	let actual = <SID>is_existing()
	call assert_equal(expected, actual)
endfun

let b:undo_ftplugin .= '|delf <SID>test_executable_file()'
fun! <SID>test_executable_file()
	let expected = 0
	let tempfile = tempname() 
	edit `=tempfile`
	let actual = <SID>is_existing()
	call assert_equal(expected, actual)
endfun

let b:undo_ftplugin .= '|delf Test()'
fun! Test()
	call <SID>test_new_file()
	call <SID>test_executable_file()
	call <SID>show_errors()
endfun

let b:undo_ftplugin .= '|delf <SID>show_errors()'
fun! <SID>show_errors()
	if v:errors != []
		new
		set buftype=nofile
		put =v:errors
	else
		exit
	endif
endfun
