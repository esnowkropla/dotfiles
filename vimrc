" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

Plug 'altercation/vim-colors-solarized'

" Elixir
Plug 'elixir-editors/vim-elixir'

" Status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Fuzzy finding
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Linting
Plug 'dense-analysis/ale'

" Incremental searching like I'm used to in emacs
Plug 'haya14busa/incsearch.vim'

" Ruby indentation
Plug 'vim-ruby/vim-ruby'

" File tree
Plug 'preservim/nerdtree'

" Beancount
Plug 'nathangrigg/vim-beancount'

" Comment motion
Plug 'tpope/vim-commentary'

call plug#end()

" Syntax highlighting and colour
syntax on
set background=dark

"let g:solarized_termcolors=256
"let g:solarized_termtrans = 1
"let g:solarized_visibility = "high"
"let g:solarized_contrast = "high"

colorscheme solarized

highlight clear SignColumn
highlight clear LineNr

" Customize extensions
let g:airline_solarized_bg='dark'
let g:airline#extensions#ale#enabled = 1
let g:gitgutter_sign_allow_clobber = 1
let g:fzf_buffers_jump = 1

let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1
let g:ale_hover_to_preview = 1

" incsearch stuff
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

set hlsearch
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)
" end incsearch stuff

" Customize settings
set updatetime=10
set signcolumn=yes
set number
set ignorecase smartcase
filetype plugin indent on
set wildmode=longest,list
set wildmenu
set switchbuf=useopen
set shell=bash
set completeopt=menu,menuone,preview,noselect,noinsert
set cursorline
" allow unsaved background buffers
set hidden
set nocompatible
" don't clear the screen on exit
set t_ti= t_te=
set nobackup
set nowritebackup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
" Default tabs
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
" display incomplete commands
set showcmd
"
" My key mappings (many stolen form grb)
let mapleader = ","
nnoremap <leader><leader> <c-^>
nnoremap <leader>m :GFiles<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>t :call RunNearestTest()<CR>
nnoremap <leader>T :call RunTests('')<CR>
nnoremap <leader>h :ALEHover<CR>
nnoremap <leader>f :Ag<CR>

cnoremap <expr> %% expand('%:h').'/'

map <c-h> <c-w>h
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l

nnoremap gj :ALENextWrap<cr>
nnoremap gk :ALEPreviousWrap<cr>
nnoremap g1 :ALEFirst<cr>

" Test running
function! MapCR()
  nnoremap <cr> :call RunTestFile()<cr>
endfunction
call MapCR()

function! RunTestFile(...)
    if a:0
        let command_suffix = a:1
    else
        let command_suffix = ""
    endif

    let in_test_file = match(expand("%"), '\(_spec.rb\|_test.rb\|test_.*\.py\|_test.py\|.test.ts\|_test.exs\)$') != -1

    if in_test_file
        call SetTestFile(command_suffix)
    elseif !exists("t:ejsk_test_file")
        return
    end

    call RunTests(t:ejsk_test_file)
endfunction

function! RunNearestTest()
    let spec_line_number = line('.')
    call RunTestFile(":" . spec_line_number)
endfunction

function! SetTestFile(command_suffix)
    let t:ejsk_test_file=@% . a:command_suffix
endfunction

function! RunTests(filename)
    " Write the file and run the tests for the given filename
    if expand("%") != ""
        :w
    end

    if executable(a:filename)
        exec ":!./" . a:filename
    elseif filereadable("bin/test")
        exec ":!bin/test " . a:filename
    elseif filereadable("bin/rspec")
        exec ":!bin/rspec " . a:filename
    else
        exec ":!rspec " . a:filename
    end
endfunction


" nmap <silent> <C-q> <Plug>(ale_previous_wrap)
" nmap <silent> <C-w> <Plug>(ale_next_wrap)

" Elixir
let g:ale_elixir_elixir_ls_release=expand('~/work/elixir-ls/release')
let g:ale_linters = {
\ 'elixir': ['mix', 'elixir-ls'],
\ 'python': ['flake8'],
\ 'bash': ['shellcheck']
\}

let g:ale_fixers = {
\ 'elixir': ['mix_format'],
\}
