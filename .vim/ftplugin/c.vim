
" swap _ and - for comfort because C has this_naming_convention
"inoremap - _
"inoremap _ -
"use `iunmap -`  and `iunmap _` to clear the mapping

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
nnoremap <silent> K :Man --sections=3,2,3posix,3pm,3perl,3am,5,1,n,l,8,4,9,6,7  <c-r><c-w><cr>
nnoremap <silent> <Leader>k <c-w>}

" load the termdebug plugin, provides :Termdebug and :TermdebugCommand
packadd termdebug

" load the ft-man-plugin, provides the :Man command which opens up the manpage 
" in a new split instead of running an external program. the man window also 
" supports navigation of manpages with C-] and C-T

runtime ftplugin/man.vim
