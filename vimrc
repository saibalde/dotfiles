set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline'

call vundle#end()

filetype plugin indent on
syntax on

" indentation
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent

" split switch
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" filetype setups
augroup c
    autocmd!
    autocmd BufNewFile,BufRead *.h,*.c set filetype=c.doxygen
augroup end

augroup cpp
    autocmd!
    autocmd BufNewFile,BufRead *.hpp,*.cpp,*.tpp set filetype=cpp.doxygen
augroup end
