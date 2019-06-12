
imap ii <ESC>
nnoremap <SPACE> <Nop>
let mapleader = "\<space>" 

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
set backspace=indent,eol,start
set incsearch
set ignorecase
set ruler
set wildmenu
set commentstring=\ #\ %s
set foldlevel=0
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
filetype plugin indent on

let g:pathogen_disabled = []
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect() 
call pathogen#helptags()

au BufRead,BufNewFile *.Rtex set filetype=rnoweb
au BufRead,BufNewFile *.jrag set filetype=java
au BufRead,BufNewFile *.jadd set filetype=java
au BufRead,BufNewFile *.tt set filetype=java

autocmd FileType python BracelessEnable +indent +fold

set runtimepath^=~/.vim/bundle/ctrlp.vim

colorscheme monochrome

command Gist Gstatus
command Gipu Gpull
command Gips Git push
command Gica Gcommit -a

command Vrc edit ~/.vimrc
