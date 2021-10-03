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
