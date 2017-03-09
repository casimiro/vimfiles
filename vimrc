set nocompatible              " be iMproved
filetype off                  " required!

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.git'
Plugin 'gmarik/Vundle.vim'

" General stuff
Plugin 'scrooloose/nerdtree'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-misc'
Plugin 'justinmk/vim-syntax-extra'
Plugin 'Shougo/deoplete.nvim'
Plugin 'morhetz/gruvbox'

" Ruby
Plugin 'thoughtbot/vim-rspec'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-rails'

" Snippets
Plugin 'honza/vim-snippets'

" C++
Plugin 'rhysd/vim-clang-format'
Plugin 'vhdirk/vim-cmake'
Plugin 'vim-jp/cpp-vim'
Plugin 'Mizuchi/STL-Syntax'
Plugin 'peterhoeg/vim-qml'

" Python
Plugin 'nvie/vim-flake8'

" JS
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'

" LaTeX stuff
Plugin 'LaTeX-Box-Team/LaTeX-Box'

" vim-scripts repos
Plugin 'L9'
Plugin 'FuzzyFinder'

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

" Syntax highlight
syntax enable
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

" Colour column to indicate 100 columns
set colorcolumn=100

" Enahncing C++ 11 highlight support
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'

" Enabling JSX highlight
let g:jsx_ext_required = 0


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

" Fixing compatibility issues with multiple cursors
" Called once right before you start selecting multiple cursors
function! Multiple_cursors_before()
    if exists(':NeoCompleteLock')==2
        exe 'NeoCompleteLock'
    endif
endfunction

" Called once only when the multiple selection is canceled (default
function! Multiple_cursors_after()
    if exists(':NeoCompleteUnlock')==2
        exe 'NeoCompleteUnlock'
    endif
endfunction

" RSpec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

let g:rspec_command = "! docker exec -it magnetis_web_1 bundle exec rspec --color {spec}"

set backspace=indent,eol,start

" Vim airline
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#branch#enabled     = 1
let g:airline#extensions#syntastic#enabled  = 1
let g:airline#extensions#tabline#enabled = 1
set guifont=Inconsolata\ 11

" Habit breaking
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Change cursor according to mode when using Konsole
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" PEP8 checking for Python files
autocmd BufWritePost *.py call Flake8()

" Transparent background
hi Normal ctermbg=none
highlight NonText ctermbg=none

" Running python tests easily
autocmd FileType python nnoremap <buffer> <leader>t :exec '!py.test -v -s' shellescape(@%, 1)<cr>
autocmd FileType python nnoremap <buffer> <leader>g :exec '!py.test -v -s --pdb' shellescape(@%, 1)<cr>

set nofoldenable

" telling NerdTree to ignore some files
let NERDTreeIgnore=['\.o$', '\~$', '\.pyc$', '__pycache__', '^tmp', '^aux']

" I don't want pymode to auto complete my stuff.
let g:pymode_rope_complete_on_dot = 0

" This way auto complete options are shown in menu rather than a new buffer
set completeopt=menu

" Loading local vimrc files (thanks, @philss)
if filereadable(glob("./.vimrc.local"))
    source ./.vimrc.local
endif

let g:deoplete#enable_at_startup = 1

" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

colorscheme gruvbox 
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set background=light   " Setting light mode
