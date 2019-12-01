inoremap ii <ESC>
nnoremap <SPACE> <Nop>
let mapleader = "\<space>" 

nmap h <PageUp>
nmap l <PageDown>

let g:pandoc#formatting#mode = 'hA'


let g:monochrome_italic_comments = 1

map <Leader>o :Files<Cr>
map <Leader>g :Buffers<Cr>
set runtimepath^=~/.fzf

set nocompatible
set encoding=utf8
set expandtab
set tabstop=4
set autoindent
set autowriteall
set autoread
set backspace=indent,eol,start
set incsearch
set ignorecase
set ruler
set isfname-=: " make file linenumber , e.g.: file.c:32 work with gF on windows
set wildmenu
set iskeyword+=- " make words-with-hyphens count as one word
set commentstring=\ #\ %s
set clipboard^=unnamed
set clipboard^=unnamedplus
set number
set scrolloff=4
set shell=/bin/bash
let $BASH_ENV = "~/.bash_aliases"

set shiftwidth=4 
set softtabstop=4
set bg=dark
let g:tex_flavor='latex'
let g:Tex_ViewRule_pdf='zathura'
let g:Tex_DefaultTargetFormat='pdf'

let g:pathogen_disabled = []
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect() 
call pathogen#helptags()

filetype plugin indent on
syntax on

au BufRead,BufNewFile *.Rtex set filetype=rnoweb
au BufRead,BufNewFile *.jrag set filetype=java
au BufRead,BufNewFile *.jadd set filetype=java
au BufRead,BufNewFile *.tt set filetype=java

autocmd FileType python BracelessEnable +indent +fold

" autosave when buffer is modified
autocmd TextChanged,TextChangedI <buffer> silent write

" UltiSnips triggering. from https://github.com/ycm-core/YouCompleteMe/issues/2032
let g:UltiSnipsExpandTrigger = '<C-j>'
let g:UltiSnipsJumpForwardTrigger = '<C-j>'
let g:UltiSnipsJumpBackwardTrigger = '<C-k>'

set runtimepath^=~/.vim/bundle/ctrlp.vim

colorscheme monochrome

command Gist Gstatus
command Gipu Gpull
command Gips Git push
command Gica Gcommit -a

command Vrc edit ~/.vimrc


" execute current line by piping to bash
nmap <Leader>x !!bash<CR>
" execute current selection by piping to bash
vmap <Leader>x !bash<CR>
