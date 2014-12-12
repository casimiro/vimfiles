set nocompatible              " be iMproved
filetype off                  " required!

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required! 
Plugin 'gmarik/Vundle.git'
Plugin 'gmarik/Vundle.vim'

" General stuff
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'flazz/vim-colorschemes'
Plugin 'zeis/vim-kolor'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'ntpeters/vim-better-whitespace'

" Ctags (for code navigation)
Plugin 'xolox/vim-easytags'
Plugin 'vim-misc'


" Ruby
Plugin 'thoughtbot/vim-rspec'
Plugin 'vim-ruby/vim-ruby'

" Snippets
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

" C++ stuff
Plugin 'rhysd/vim-clang-format'
Plugin 'vhdirk/vim-cmake'
Plugin 'vim-jp/cpp-vim'
Plugin 'Mizuchi/STL-Syntax'
Plugin 'peterhoeg/vim-qml'

" LaTeX stuff
Plugin 'LaTeX-Box-Team/LaTeX-Box'

" vim-scripts repos
Plugin 'L9'
Plugin 'FuzzyFinder'
" non-GitHub repos
Plugin 'wincent/Command-T' 
" Git repos on your local machine (i.e. when working on your own plugin)
" Bundle 'file:///Users/gmarik/path/to/plugin'
" ...

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

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
set number

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
        set guifont=Inconsolata\ 10
    elseif has("gui_macvim")
        set guifont=Menlo\ Regular:h13
    elseif has("gui_win32")
        set guifont=Consolas:h11:cANSI
    endif
endif

" Neocomplete stuff
let g:neocomplete#enable_at_startup = 1


" RSpec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

let g:rspec_command = "bundle exec rspec --drb {spec}"
