set nocompatible
syntax enable

set laststatus=2

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set autoindent
set smartindent

augroup gitcommit
    autocmd!
    autocmd FileType gitcommit setlocal textwidth=72 spell
augroup end
