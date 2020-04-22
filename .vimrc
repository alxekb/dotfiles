set nocompatible              " be iMproved, required
set number
syntax enable
set shell=zsh
syntax on
filetype plugin indent on
filetype on
filetype indent on
filetype plugin on
set clipboard=unnamedplus
set clipboard^=unnamed
set mouse=r
set backspace=indent,eol,start
set laststatus=2
autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2
autocmd FileType eruby setlocal expandtab shiftwidth=2 tabstop=2
autocmd FileType javascript setlocal expandtab shiftwidth=2 tabstop=2
"Netrw show file as a mapping
map <Leader>f :let @/=expand("%:t") <Bar> execute 'Explore' expand("%:h") <Bar> normal n<CR>
" :h g:incsearch#auto_nohlsearch
set hlsearch
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)
let g:netrw_preview = 1
set ts=2
set sts=2
set et     "expand tabs to spaces
"Mode Settings

let &t_SI.="\e[5 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let &t_EI.="\e[5 q" "EI = NORMAL mode (ELSE)

"Cursor settings:

"  1 -> blinking block
"  2 -> solid block
"  3 -> blinking underscore
"  4 -> solid underscore
"  5 -> blinking vertical bar
"  6 -> solid vertical bar
" max text length
au BufRead,BufNewFile *.rb setlocal textwidth=120

" autocmd BufRead,BufNewFile *.html,*.js,*.xml call s:CompleteTags()


" get rid of trailing whitespace on :w
autocmd BufWritePre * %s/\s\+$//e

" cursor highlight
:nnoremap <Leader>c :set cursorline! <CR>

" move lines
nnoremap ˚ :m .-2<CR>==
nnoremap ∆ :m .+1<CR>==
inoremap  ˚ <Esc>:m .-2<CR>==gi
inoremap  ∆ <Esc>:m .+1<CR>==gi
vnoremap  ˚ :m '<-2<CR>gv=gv
vnoremap  ∆ :m '>+1<CR>gv=gv

" remap splitting windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" remap splits
nmap :vs :vsplit
nmap :s :split
" nnoremap <C-a> <C-w>
"Pathogen
set nocp
call pathogen#infect()

" Set SPELLCHeCK YYAH
" set spell spelllang=en_ca
" hi SpellBad cterm=underline,bold
" set highlight SpellBad      ctermfg=Red         term=Reverse        guisp=Red       gui=undercurl   ctermbg=White

" Fzf search enable
set rtp+=/usr/local/opt/fzf

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
" set ctrlP plugin
set runtimepath^=~/.vim/bundle/ctrlp.vim
" allow vim to jump through directories for ctags
set tags=tags;/
"let g:solarized_termcolors = 16
call vundle#begin()

" Set Theme
Plugin 'junegunn/seoul256.vim'
" color seoul256

" Ocean theme VS
" set t_Co=256
Plugin 'mhartington/oceanic-next'
Plugin 'ecomba/vim-ruby-refactoring'
Plugin 'https://github.com/adelarsq/vim-matchit'
" colorscheme OceanicNext
" let g:oceanic_next_terminal_bold = 1

Plugin 'geoffharcourt/vim-ruby-private-method-extract'
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'dyng/ctrlsf.vim'
Plugin 'rizzatti/dash.vim'
Plugin 'skywind3000/vim-preview'
Plugin 'dracula/vim', { 'name': 'dracula' }
Plugin 'haya14busa/incsearch.vim'
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" Scala highlights
Plugin 'prettier/vim-prettier'
" Plugin 'derekwyatt/vim-scala'
" neocomplete Plugin
Plugin 'Shougo/neocomplete.vim'
" show git diif in vim
Plugin 'airblade/vim-gitgutter'
" plugin from http://vim-scripts.org/vim/scripts.html
" Install L9 and avoid a Naming conflict if you've already
" installed a
" different version somewhere else.

Plugin 'ekalinin/Dockerfile.vim'
Plugin 'skywind3000/vim-quickui'
Plugin 'ascenator/L9', {'name': 'newL9'}
Bundle 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-ragtag'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
" Fzg plugin
Plugin 'junegunn/fzf.vim'
" remap envoke key
nnoremap <silent> <C-z> :FZF<CR>
nnoremap <silent> <C-x> :Buffers<CR>

" Ripgrep
Plugin 'jremmen/vim-ripgrep'
let g:rg_highligh = 1

"" Quick comment toggling
Plugin 'tpope/vim-commentary'
noremap ÷ :Commentary<CR>
autocmd FileType ruby setlocal commentstring=#\ %s

" Files stucture tree
" Plugin 'scrooloose/nerdtree'
"map <C-m> :NERDTreeToggle<CR>
" map - :NERDTreeToggle<CR>
" map <leader>r :NERDTreeFind<cr>
" autocmd BufWinEnter * NERDTreeFind
" map ] :NERDTreeFind<CR>

map <S-d> :tabnext<CR>
map <S-w> :tabnew<CR>

Plugin 'craigemery/vim-autotag'
Plugin 'slim-template/vim-slim.git'
" Plugin 'pangloss/vim-javascript'
Plugin 'sheerun/vim-polyglot'
" Plugin 'maxmellon/vim-jsx-pretty'
Plugin 'alvan/vim-closetag'     "Auto close (X)HTML tags

call vundle#end()            " required

" Ctrl-P configurations
" let g:ctrlp_map = '<c-p>'
" let g:ctrlp_cmd = 'CtrlP'
" Ctags with Ctrl-P
" nnoremap <leader>. :CtrlPTag<cr>

"Neocomplete configurations
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
" Move up and down in autocomplete with <c-j> and <c-k>
inoremap <expr> <c-j> ("\<C-n>")
inoremap <expr> <c-k> ("\<C-p>")

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" ALE
nmap <LEADER>af :ALEFix<CR>
Plugin 'w0rp/ale'
let g:ale_lint_on_text_changed = 1
let g:ale_lint_on_save = 1
let g:ale_set_loclist = 1

let g:ale_fixers = {
\  'ruby': [
\    'remove_trailing_lines',
\    'trim_whitespace',
\    'rubocop'
\  ]
\}
let g:ale_fixers = {'javascript': ['prettier']}
let g:ale_linters = {'python': ['pycodestyle']}
let g:ale_linters = {'ruby': ['rubocop', 'ruby']}
let g:ale_ruby_rubocop_executable = 'bin/rubocop'
let g:ruby_indent_assignment_style = 'variable'

" vim-ruby
let g:ruby_indent_access_modifier_style = 'normal'
let g:ruby_indent_assignment_style = 'variable'
let g:ruby_indent_block_style = 'do'
let g:netrw_hide = 0
set shell=/usr/local/bin/bash

