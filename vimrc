set nocompatible              " be iMproved
filetype off                  " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" General stuff
Bundle 'tpope/vim-fugitive'
Bundle 'scrooloose/nerdtree'
Bundle 'flazz/vim-colorschemes'
Bundle 'Valloric/YouCompleteMe'
Bundle 'zeis/vim-kolor'

" C++ stuff
Bundle 'rhysd/vim-clang-format'
Bundle 'vhdirk/vim-cmake'
Bundle 'vim-jp/cpp-vim'
Bundle 'Mizuchi/STL-Syntax'

" LaTeX stuff
Bundle 'LaTeX-Box-Team/LaTeX-Box'

" vim-scripts repos
Bundle 'L9'
Bundle 'FuzzyFinder'
" non-GitHub repos
Bundle 'git://git.wincent.com/command-t.git'
" Git repos on your local machine (i.e. when working on your own plugin)
" Bundle 'file:///Users/gmarik/path/to/plugin'
" ...

filetype plugin indent on     " required!
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install (update) bundles
" :BundleSearch(!) foo - search (or refresh cache first) for foo
" :BundleClean(!)      - confirm (or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle commands are not allowed.

" NerdTree
silent! nmap <silent> <Leader>p :NERDTreeToggle<CR>

syntax enable 
colorscheme kolor

" Tabs and spaces stuff

set ts=4

" size of a hard tabstop
set tabstop=4

" size of an "indent"
set shiftwidth=4

" a combination of spaces and tabs are used to simulate tab stops at a width
" other than the (hard)tabstop
set softtabstop=4

" make "tab" insert indents instead of tabs at the beginning of a line
set smarttab

" always uses spaces instead of tab characters
set expandtab

" Remove menubar of gvim
set guioptions-=m

" Enahncing C++ 11 highlight support
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'

" Setting font among systems
if has("gui_running")
    if has("gui_gtk2")
        set guifont=Inconsolata\ 12
    elseif has("gui_macvim")
        set guifont=Menlo\ Regular:h13
    elseif has("gui_win32")
        set guifont=Consolas:h11:cANSI
    endif
endif
