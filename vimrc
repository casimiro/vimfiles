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
Plugin 'vim-misc' " maybe remove
Plugin 'justinmk/vim-syntax-extra'
Plugin 'chriskempson/base16-vim'
Plugin 'Raimondi/delimitMate'
Plugin 'majutsushi/tagbar'
Plugin 'sheerun/vim-polyglot'
Plugin 'airblade/vim-gitgutter'
Plugin 'zivyangll/git-blame.vim'
Plugin 'wakatime/vim-wakatime'
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plugin 'junegunn/fzf.vim'
Plugin 'Shougo/vimproc.vim', {'do' : 'make'}
Plugin 'idanarye/vim-vebugger'

" Rust
Plugin 'rust-lang/rust.vim'
Plugin 'racer-rust/vim-racer'

" C++
Plugin 'rhysd/vim-clang-format'
Plugin 'vhdirk/vim-cmake'
Plugin 'vim-jp/cpp-vim'
Plugin 'Mizuchi/STL-Syntax'
Plugin 'cstrahan/vim-capnp'

" Go
Plugin 'fatih/vim-go'

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

" Perl
Plugin 'vim-perl/vim-perl', { 'for': 'perl', 'do': 'make clean carp dancer highlight-all-pragmas moose test-more try-tiny' }



" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

set rtp+=~/.fzf

silent! nmap <silent> <Leader>p <plug>NERDTreeTabsToggle<CR>

" keeping cursor and buffer position while switching between buffers
au BufEnter * silent! normal! g`""
:set nostartofline
if v:version >= 700
  au BufLeave * let b:winview = winsaveview()
  au BufEnter * if(exists('b:winview')) | call winrestview(b:winview) | endif
endif

" FuzzyFinder
silent! nmap <silent> <Leader>g :Files<CR>

" -U makes ag not consider .gitignore but it still considers .ignore
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, '-U --column --nogroup --color', fzf#vim#with_preview(), <bang>0)
silent! noremap <leader>f  :Ag <C-r>=expand('<cword>')<CR><CR>

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

vnoremap <silent><leader>f <Esc>:Ag <C-r>=<SID>getVisualSelection()<CR><CR>

" buffer navigation usng tab key
silent! nmap <silent> <Tab> :bn<CR>
silent! nmap <silent> <S-Tab> :bp<CR>
" deleting current buffer but keeping the split:
silent! nmap <silent> <leader>d :bp\|bd #<CR>

" Syntax highlight
let python_highlight_all=1
syntax on
set number

" make "tab" insert indents instead of tabs at the beginning of a line
set smarttab

" always uses spaces instead of tab characters
set expandtab
set backspace=indent,eol,start

" Running python tests easily
autocmd FileType python nnoremap <buffer> <leader>t :exec '!py.test -v -s' shellescape(@%, 1)<cr>
autocmd FileType python nnoremap <buffer> <leader>g :exec '!py.test -v -s --pdb' shellescape(@%, 1)<cr>

set colorcolumn=80

set nofoldenable
set hidden
nnoremap <Leader>s :<C-u>call gitblame#echo()<CR>

" telling NerdTree to ignore some files
let NERDTreeIgnore=['\.o$', '\~$', '\.pyc$', '__pycache__', '^tmp', '^aux']
let NERDTreeShowHidden=1

" swap files will be stored here
set directory^=$HOME/.vim/tmp/

" resize splits with mouse inside tmux:
set mouse+=a
if &term =~ '^screen'
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
endif

" .vimrc.local to avoid recursively loading .vimrc when vim from $HOME
if filereadable(glob("./.vimrc.local"))
    source ./.vimrc.local
endif

" Loading virtualenv if it exists
if filereadable(glob("./.venv/bin/activate"))
    let old_path = $PATH
    let $PATH='$PWD/.venv/bin:' . old_path
endif

" highlight wihtout moving
nnoremap * *``
nnoremap # #``

setlocal ts=4 sts=4 sw=4
autocmd Filetype javascript setlocal ts=2 sw=2 sts=0 expandtab
autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType ruby setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType lua setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab


autocmd BufWritePost *.py call flake8#Flake8()

let base16colorspace=256

nmap <F7> :TagbarToggle<CR>

let g:airline_theme='base16_phd'
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

colorscheme base16-phd
set mouse=a

" debugging
let g:vebugger_leader='<F9>'
let g:vebugger_view_source_cmd='new'
