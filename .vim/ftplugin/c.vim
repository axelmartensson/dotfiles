
" swap _ and - for comfort because C has this_naming_convention
inoremap - _
inoremap _ -

map <Leader>r :Make<CR>
map <Leader>f :YcmCompleter FixIt<CR>
let g:ycm_always_populate_location_list = 1
nnoremap gn :lnext<CR>
nnoremap gp :lprev<CR>

" make big-K instead of lookup man-page, look for the function definition 
" first (assuming that the definition has a header with documentation).
" TODO, if cstag reports -1 fall back on old behavior (a way to implement or, 
" maybe as a function?)
nnoremap K <c-w>} 

" load the termdebug plugin, provides :Termdebug and :TermdebugCommand
packadd termdebug

" load the ft-man-plugin, provides the :Man command which opens up the manpage 
" in a new split instead of running an external program. the man window also 
" supports navigation of manpages with C-] and C-T

runtime ftplugin/man.vim
