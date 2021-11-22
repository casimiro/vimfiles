set nocompatible              " be iMproved
filetype off                  " required!
set path+=**
set wildmenu

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.git'
Plugin 'gmarik/Vundle.vim'

" General stuff
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'mg979/vim-visual-multi', {'branch': 'master'}
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-misc'
Plugin 'justinmk/vim-syntax-extra'
Plugin 'chriskempson/base16-vim'
Plugin 'Raimondi/delimitMate'
Plugin 'majutsushi/tagbar'
Plugin 'sheerun/vim-polyglot'
Plugin 'airblade/vim-gitgutter'
Plugin 'zivyangll/git-blame.vim'
Plugin 'wakatime/vim-wakatime'

" Rust
Plugin 'rust-lang/rust.vim'
Plugin 'racer-rust/vim-racer'

" C++
Plugin 'rhysd/vim-clang-format'
Plugin 'vhdirk/vim-cmake'
Plugin 'vim-jp/cpp-vim'
Plugin 'Mizuchi/STL-Syntax'
Plugin 'cstrahan/vim-capnp'

" Python
Plugin 'nvie/vim-flake8'

" JS
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'

" LaTeX stuff
Plugin 'LaTeX-Box-Team/LaTeX-Box'

" Lua
Plugin 'tbastos/vim-lua'

" DevOPS
Plugin 'towolf/vim-helm'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

set rtp+=~/.fzf

" NerdTree
silent! nmap <silent> <Leader>p <plug>NERDTreeTabsToggle<CR>

" FuzzyFinder
silent! nmap <silent> <Leader>f :FZF<CR>

" buffer navigation usng tab key
silent! nmap <silent> <Tab> :bn<CR>
silent! nmap <silent> <S-Tab> :bp<CR>

" Syntax highlight
let python_highlight_all=1
syntax on
set number

" make "tab" insert indents instead of tabs at the beginning of a line
set smarttab

" always uses spaces instead of tab characters
set expandtab

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

set backspace=indent,eol,start

" Vim airline
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1

" airline symbols
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" Transparent background
hi Normal ctermbg=none
highlight NonText ctermbg=none

" Running python tests easily
autocmd FileType python nnoremap <buffer> <leader>t :exec '!py.test -v -s' shellescape(@%, 1)<cr>
autocmd FileType python nnoremap <buffer> <leader>g :exec '!py.test -v -s --pdb' shellescape(@%, 1)<cr>

set colorcolumn=100

set nofoldenable
set hidden
nnoremap <Leader>s :<C-u>call gitblame#echo()<CR>

" telling NerdTree to ignore some files
let NERDTreeIgnore=['\.o$', '\~$', '\.pyc$', '__pycache__', '^tmp', '^aux']
let NERDTreeShowHidden=1

" Loading local vimrc files (thanks, @philss)
if filereadable(glob("./.vimrc.local"))
    source ./.vimrc.local
endif

" Loading virtualenv if it exists
if filereadable(glob("./.venv/bin/activate"))
    let old_path = $PATH
    let $PATH='$PWD/.venv/bin:' . old_path
endif

setlocal ts=4 sts=4 sw=4
autocmd Filetype javascript setlocal ts=2 sw=2 sts=0 expandtab
autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType ruby setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType lua setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab


autocmd BufWritePost *.py call flake8#Flake8()


set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*


let base16colorspace=256
" set termguicolors
colorscheme base16-ashes

nmap <F8> :TagbarToggle<CR>

" disables opaque background
hi Normal ctermbg=none
hi NonText ctermbg=none
