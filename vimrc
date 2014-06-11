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
Bundle 'zeis/vim-kolor'
Bundle 'Shougo/neocomplete'

" Snippets
Bundle 'SirVer/ultisnips'
Bundle 'honza/vim-snippets'

" C++ stuff
Bundle 'rhysd/vim-clang-format'
Bundle 'vhdirk/vim-cmake'
Bundle 'vim-jp/cpp-vim'
Bundle 'Mizuchi/STL-Syntax'
Bundle 'peterhoeg/vim-qml'

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

" NerdTree
silent! nmap <silent> <Leader>p :NERDTreeToggle<CR>

" Tab navigation usng tab key
silent! nmap <silent> <Tab> :tabn<CR>
silent! nmap <silent> <S-Tab> :tabp<CR>

" Snippets
function! g:UltiSnips_Complete()
    call UltiSnips#ExpandSnippet()
    if g:ulti_expand_res == 0
        if pumvisible()
            return "\<C-n>"
        else
            call UltiSnips#JumpForwards()
            if g:ulti_jump_forwards_res == 0
               return "\<TAB>"
            endif
        endif
    endif
    return ""
endfunction

au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsListSnippets="<c-e>"

" Syntax highlight
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

" Neocomplete stuff
let g:neocomplete#enable_at_startup = 1
