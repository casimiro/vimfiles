set nocompatible
set path+=**
set wildmenu

call plug#begin()

" General stuff
Plug 'preservim/nerdtree'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'ntpeters/vim-better-whitespace'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'justinmk/vim-syntax-extra'
Plug 'preservim/tagbar'
Plug 'sheerun/vim-polyglot'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'azabiong/vim-highlighter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'dense-analysis/ale'
Plug 'morhetz/gruvbox'
Plug 'wakatime/vim-wakatime'

" Rust
Plug 'rust-lang/rust.vim'

" C++
Plug 'rhysd/vim-clang-format'
Plug 'vhdirk/vim-cmake'
Plug 'vim-jp/cpp-vim'
Plug 'Mizuchi/STL-Syntax'

" Go
Plug 'fatih/vim-go'

" Python
Plug 'nvie/vim-flake8'

" JS
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

" LaTeX stuff
Plug 'LaTeX-Box-Team/LaTeX-Box'

" Lua
Plug 'tbastos/vim-lua'

" DevOPS
Plug 'towolf/vim-helm'

" Perl
Plug 'vim-perl/vim-perl', { 'for': 'perl', 'do': 'make clean carp dancer highlight-all-pragmas moose test-more try-tiny' }

call plug#end()              " required
filetype plugin indent on    " required

" ag
" -U makes ag not consider .gitignore but it still considers .ignore
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, '-U --column --hidden', fzf#vim#with_preview(), <bang>0)

" https://stackoverflow.com/a/47995254
function! s:getVisualSelection()
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)

    if len(lines) == 0
        return ""
    endif

    let lines[-1] = lines[-1][:column_end - (&selection == "inclusive" ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]

    return join(lines, "\n")
endfunction

" File navigator
nnoremap <A-F2> :NERDTreeToggle<CR>
" Fuzzy finder
nnoremap <F2> :Files<CR>
" Find files containing word under cursor
nnoremap <F3> :Ag <C-r>=expand('<cword>')<CR><CR>
vnoremap <F3> <Esc>:Ag <C-r>=<SID>getVisualSelection()<CR><CR>
" Delete current buffer keeping the split
nnoremap <F4> :bp\|bd #<CR>
nnoremap <F5> :make<CR>
" Tag navigation
nnoremap <F9> :TagbarToggle<CR>
nnoremap <F10> :ALEToggle<CR>
nnoremap <F11> :Git blame<CR>
nnoremap <F12> :source ~/.vimrc<CR>

" buffer navigation using tab key
nnoremap <Tab> :bn<CR>
nnoremap <S-Tab> :bp<CR>

" resize windows
nnoremap <Left> :vertical-resize -5<CR>
nnoremap <Right> :vertical-resize +5<CR>

" Syntax highlight
syntax on
set number relativenumber
set colorcolumn=80
set smarttab
set expandtab
set hidden
set nostartofline
set mouse=a
set directory=$HOME/.vim/tmp/
set background=light

if &term =~ '^tmux'
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
endif

setlocal ts=4 sts=4 sw=4
autocmd Filetype javascript setlocal ts=2 sw=2 sts=0 expandtab
autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType ruby setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType lua setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab

" Running python tests easily
autocmd FileType python nnoremap <buffer> <leader>t :exec '!py.test -v -s' shellescape(@%, 1)<cr>
autocmd FileType python nnoremap <buffer> <leader>g :exec '!py.test -v -s --pdb' shellescape(@%, 1)<cr>
autocmd BufWritePost *.py call flake8#Flake8()

let NERDTreeIgnore=['\.o$', '\~$', '\.pyc$', '__pycache__', '^tmp', '^aux']
let NERDTreeShowHidden=1
let g:tagbar_autoclose = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='gruvbox'
let g:gruvbox_italic=1
let python_highlight_all=1

" keeping cursor and buffer position while switching between buffers
au BufEnter * silent! normal! g`""
if v:version >= 700
  au BufLeave * let b:winview = winsaveview()
  au BufEnter * if(exists('b:winview')) | call winrestview(b:winview) | endif
endif

" .vimrc.local to avoid recursively loading .vimrc when vim from $HOME
if filereadable(glob("./.vimrc.local"))
    source ./.vimrc.local
endif

" highlight wihtout moving
nnoremap * *``
nnoremap # #``

autocmd vimenter * ++nested colorscheme gruvbox
