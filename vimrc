set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'christoomey/vim-tmux-navigator'

Plugin 'romainl/flattened'

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

Plugin 'preservim/nerdtree'
Plugin 'preservim/tagbar'

Plugin 'tpope/vim-fugitive'

Plugin 'sheerun/vim-polyglot'
Plugin 'rhysd/vim-clang-format'
Plugin 'vim-scripts/DoxygenToolkit.vim'

call vundle#end()

filetype plugin indent on
syntax on

" colorscheme
colorscheme flattened_dark

" status line
let g:airline_theme='solarized'

" NERDTree
nnoremap <Leader>n :NERDTreeToggle<CR>

" Tagbar
let g:tagbar_autofocus=1
let g:tagbar_autoshowtag=1
nnoremap <Leader>t :TagbarToggle<CR>

" indentation
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" right margin
set colorcolumn=81

" split switch
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" filetype setups
augroup c
    autocmd!
    autocmd BufNewFile,BufFilePre,BufRead *.h,*.c set filetype=c.doxygen
augroup end

augroup cpp
    autocmd!
    autocmd BufNewFile,BufFilePre,BufRead *.hpp,*.cpp,*.tpp set filetype=cpp.doxygen
augroup end
