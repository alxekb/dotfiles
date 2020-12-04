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
set foldmethod=syntax
hi Folded ctermbg=NONE ctermfg=Black
" set laststatus=2
" set tabstop=2
" set shiftwidth=2
" set expandtab
set expandtab tabstop=2 shiftwidth=2 softtabstop=2
" autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2
" autocmd FileType eruby setlocal expandtab shiftwidth=2 tabstop=2
" autocmd FileType javascript setlocal expandtab shiftwidth=2 tabstop=2
" autocmd FileType jsx setlocal expandtab shiftwidth=2 tabstop=2
"Netrw show file as a mapping
map <Leader>f :let @/=expand("%:t") <Bar> execute 'Explore' expand("%:h") <Bar> normal n<CR>
" :h g:incsearch#auto_nohlsearch
set hlsearch
let g:netrw_winsize = 28
let g:incsearch#auto_nohlsearch = 1
let g:airline#extensions#tabline#enabled = 1
autocmd FileType gitcommit noremap <buffer> dt :GdiffInTab<CR>
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

let &t_SI.="\e[1 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)

"Cursor settings:

"  1 -> blinking block
"  2 -> solid block
"  3 -> blinking underscore
"  4 -> solid underscore
"  5 -> blinking vertical bar
"  6 -> solid vertical bar
" max text length
au BufRead,BufNewFile *.rb setlocal textwidth=120
" if executable('ag')
  " let g:ackprg = 'ag --vimgrep'
" endif
" autocmd BufRead,BufNewFile *.html,*.js,*.xml call s:CompleteTags()


" get rid of trailing whitespace on :w
autocmd BufWritePre * %s/\s\+$//e

" cursor highlight
:nnoremap <Leader>c :set cursorline! <CR>

" move lines
nnoremap ˚ :m .-2<CR>==
nnoremap ∆ :m .+1<CR>==
inoremap ˚ <Esc>:m .-2<CR>==gi
inoremap ∆ <Esc>:m .+1<CR>==gi
vnoremap ˚ :m '<-2<CR>gv=gv
vnoremap ∆ :m '>+1<CR>gv=gv

" remap splitting windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" remap splits
" nnoremap <C-a> <C-w>

nmap <C-§>s :scs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-§>g :scs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-§>c :scs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-§>t :scs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-§>e :scs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-§>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-§>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-§>d :scs find d <C-R>=expand("<cword>")<CR><CR>
"Pathogen
set nocp
call pathogen#infect()

" Set SPELLCHeCK YYAH
set complete+=kspell
set spell spelllang=en_us
" hi SpellBad cterm=underline ",bold
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

Plugin 'thoughtbot/vim-rspec'
" Plugin 'itmammoth/run-rspec.vim'
" Plugin 'skwp/vim-rspec'
" Plugin 'kana/vim-vspec'
Plugin 'vim-airline/vim-airline'
let g:airline#extensions#tabline#enabled = 1
Plugin 'vim-airline/vim-airline-themes'
Plugin 'codota/tabnine-vim'
Plugin 'godlygeek/tabular'
Plugin 'alxekb/vim-tags'
let g:vim_tags_auto_generate = 1
Plugin 'plasticboy/vim-markdown'
Plugin 'Shougo/deoplete.nvim'
Plugin 'webastien/vim-ctags'
Plugin 'dart-lang/dart-vim-plugin'
Plugin 'natebosch/vim-lsc'
Plugin 'natebosch/vim-lsc-dart'
Plugin 'neoclide/coc.nvim'
Plugin 'ecomba/vim-ruby-refactoring'
Plugin 'adelarsq/vim-matchit'
Plugin 'VundleVim/Vundle.vim'
Plugin 'dyng/ctrlsf.vim'
Plugin 'rizzatti/dash.vim'
Plugin 'skywind3000/vim-preview'
Plugin 'haya14busa/incsearch.vim'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-rhubarb'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
" Plugin 'townk/vim-autoclose'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-commentary'
noremap ÷ :Commentary<CR>
autocmd FileType ruby setlocal commentstring=#\ %s
map <S-d> :tabnext<CR>
map <S-w> :tabnew<CR>
map <S-s> :tabpr<CR>
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-ragtag'
Plugin 'tpope/vim-haml'
Plugin 'prettier/vim-prettier'
Plugin 'airblade/vim-gitgutter'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'skywind3000/vim-quickui'
Plugin 'ascenator/L9', {'name': 'newL9'}
" Bundle 'vim-ruby/vim-ruby'
Plugin 'rking/ag.vim'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'chengzeyi/fzf-preview.vim'
let g:fzf_preview_window = ['right:50%', 'ctrl-/']
" remap envoke key
nnoremap <silent> <C-z> :FZF<CR>
nnoremap <silent> <C-x> :Buffers<CR>

" Ripgrep
Plugin 'jremmen/vim-ripgrep'
let g:rg_highlight = 1

" Plugin 'craigemery/vim-autotag'
Plugin 'slim-template/vim-slim.git'
Plugin 'sheerun/vim-polyglot'
"Auto close (X)HTML tags
" Plugin 'alvan/vim-closetag'
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.erb,*.jsx,*.js'
" Plugin 'mileszs/ack.vim'
Plugin 'ludovicchabant/vim-gutentags'
Plugin 'w0rp/ale'

call vundle#end()            " required

"Neocomplete configurations
" let g:neocomplete#enable_at_startup = 1
" let g:neocomplete#enable_smart_case = 1
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
let g:ale_lint_on_text_changed = 1
let g:ale_lint_on_save = 1
let g:ale_set_loclist = 1
let g:ale_linters_explicit = 1
" let g:ale_javascript_xo_options = "--plug=react --prettier"
" let g:ale_linter_aliases = {'jsx': ['css', 'javascript']}
let g:ale_linters = {'jsx': ['stylelint', 'eslint']}
let g:ale_fixers = {
\  'ruby': [
\    'remove_trailing_lines',
\    'trim_whitespace',
\    'rubocop'
\  ],
\  'javascript': ['prettier'],
\  'jsx': ['stylelint', 'eslint'],
\  'css': ['prettier'],
\}
let g:ale_linters = {
\    'ruby': ['rubocop'],
\    'jsx': ['stylelint', 'eslint'],
\    'javascript': ['eslint'],
\}
let g:ale_ruby_rubocop_executable = 'bin/rubocop'
" vim-ruby
let g:ruby_indent_access_modifier_style = 'normal'
let g:ruby_indent_assignment_style = 'variable'
let g:ruby_indent_block_style = 'do'
let g:netrw_hide = 0
set shell=/usr/local/bin/bash
highlight! link DiffText MatchParen
command -nargs=* Glg Git! log --graph --pretty=format:'\%h - (\%ad)\%d \%s <\%an>' --abbrev-commit --date=local <args>
" source ~/.vim/plugins/cscope_maps.vim
autocmd BufRead,BufNewFile *.md setlocal spell
" let g:vim_markdown_conceal
" Preview for :Ag
" command! -bang -nargs=* Ag
" \ call fzf#vim#ag(<q-args>,
" \                 <bang>0 ? fzf#vim#with_preview('up:60%')
" \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
" \                 <bang>0)


" command! -bang -nargs=* Ag
"   \ call fzf#vim#grep(
"   \   'ag --column --numbers --noheading --color --smart-case '.shellescape(<q-args>), 1,
"   \   fzf#vim#with_preview(), <bang>0)

