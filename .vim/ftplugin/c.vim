
" swap _ and - for comfort because C has this_naming_convention
"inoremap - _
"inoremap _ -
"use `iunmap -`  and `iunmap _` to clear the mapping

set commentstring=//\ %s

map <Leader>r :Make<CR>
" conflicts with Open file binding
" map <Leader>f :YcmCompleter FixIt<CR>
let g:ycm_always_populate_location_list = 1
nnoremap <buffer> gn :lnext<CR>
nnoremap <buffer> gp :lprev<CR>

" TODO combine <leader>k and big-k into one command. make 
" big-K instead of lookup man-page, look for the function 
" definition first (assuming that the definition has a 
" header with documentation).
" TODO, if cstag reports -1 fall back on old behavior (a way to implement or, 
" maybe as a function?)
set keywordprg=:Man\ --sections=3,2,3posix,3pm,3perl,3am,5,1,n,l,8,4,9,6,7
nnoremap <silent> <Leader>k <c-w>}

" load the termdebug plugin, provides :Termdebug and :TermdebugCommand
packadd termdebug

" Rerun the currently running program
function! Rerun()
	:Stop
	:Run
endfunction


" Run to the current line
function! RunToLine()
	:Break
	:Continue
	:Clear
endfunction

nmap <f4> :Finish<CR>
nmap <f5> :Step<CR>
nmap <f6> :Over<CR>
nmap <f7> :call RunToLine()<CR>
nmap <f8> :Continue<CR>
nmap <c-b> :Break<CR>
nmap <c-k> :call Rerun()<CR>

