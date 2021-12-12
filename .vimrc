set nocompatible              " be iMproved, required
set number
set spell
set scrolloff=3
set clipboard=unnamed
set backspace=indent,eol,start
set hlsearch
set cursorcolumn
set foldmethod=syntax
set nofoldenable
set expandtab tabstop=2 shiftwidth=2 softtabstop=2
set cursorline
set complete+=kspell
set rtp+=/usr/local/opt/fzf
set rtp+=~/.vim/bundle/vundle.vim
set tags=tags;/
set laststatus=2

" function! MyStatusLine()
"     let l:w = min([14,winwidth(0)/2-3])
"     return expand("%f %h%w%m%r%=%-" . l:w . ".(%l,%c%V%) %P")
" endfunction
" set statusline=%{MyStatusLine()}

au BufRead,BufNewFile *.rb setlocal textwidth=120
au BufNewFile,BufRead *.es6 set filetype=javascript

autocmd bufread,bufnewfile *.md setlocal spell

" syntax enable
" syntax on

filetype plugin indent on
filetype on
filetype indent on
filetype plugin on

let g:indentLine_char = '⦙'
let g:netrw_hide=0
let g:netrw_banner=0
let g:netrw_altv=1
let g:netrw_browse_split = 0
let g:netrw_winsize = 34
let g:netrw_liststyle = 4
let g:netrw_localcopydircmd = 'cp -r'
let g:netrw_keepdir = 1

augroup netrw_mapping
  autocmd!
  autocmd filetype netrw call NetrwMapping()
augroup END

nnoremap <leader>c :Dispatch
nnoremap <leader>rr :Dispatch rubocop -A %<CR>
nnoremap <leader>tt :Dispatch RAILS_ENV=test rails rswag SWAGGER_DRY_RUN=0<CR>
nnoremap <leader>dd :Lexplore %:p:h<CR>
nnoremap <leader>f :Rg<CR>
nnoremap <Leader>ee :Lexplore<CR>

function! NetrwMapping()
  nmap <buffer> H u
  nmap <buffer> h -^
  nmap <buffer> l <CR>
  nmap <buffer> . gh
  nmap <buffer> P <C-w>z
  nmap <buffer> L <CR>:Lexplore<CR>
  nmap <buffer> <Leader>dd :Lexplore<CR>
endfunction

hi Folded ctermbg=NONE ctermfg=DarkCyan

map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)


autocmd BufWritePre * %s/\s\+$//e

nnoremap  <M-k> :m .-2<CR>
nnoremap  <M-j> :m .+1<CR>
nnoremap ˚ :m .-2<CR>==
nnoremap ∆ :m .+1<CR>==
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
noremap <c-m> :Commentary<cr>
nnoremap <leader>0 :Git log --since=midnight --pretty=format:"%s" <cr>
nnoremap <silent> <c-z> :FZF<cr>
nnoremap <silent> <c-x> :Buffers<cr>


inoremap ˚ <Esc>:m .-2<CR>==gi
inoremap ∆ <Esc>:m .+1<CR>==gi
vnoremap ˚ :m '<-2<CR>gv=gv
vnoremap ∆ :m '>+1<CR>gv=gv

nmap <silent> <leader>d <Plug>DashSearch
nmap <leader>af :ALEFix<cr>
nmap <leader>n :ALENext<cr>
nmap = :Rex<cr>
nmap § :Vex<cr>
map <s-d> :tabnext<cr>
map <s-w> :tabnew<cr>
map <s-s> :tabpr<cr>

let g:coc_global_extensions = [ 'coc-tsserver', 'coc-solargraph' ]
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.erb,*.jsx,*.js,*.tsx,*.md,*.es6'
let g:netrw_liststyle = 4

let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_save = 1
let g:ale_completion_enabled = 1
let g:ale_set_loclist = 1
let g:ale_linters_explicit = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_list_window_size = 5

autocmd filetype ruby setlocal commentstring=#\ %s
let g:ale_lint_on_enter = 0
let g:gutentags_define_advanced_commands = 1
let g:gutentags_modules = ['ctags', 'gtags_cscope']

" config project root markers.
let g:gutentags_project_root = ['.root']
let g:gutentags_auto_add_gtags_cscope = 0
let g:gutentags_add_default_project_roots = 0
let g:gutentags_project_root = ['package.json', '.git']
let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_empty_buffer = 0
let g:gutentags_cache_dir = expand('~/.cache/tags')

let g:fzf_preview_window = ['up:60%', 'ctrl-/']
let g:fzf_buffers_jump = 1
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.85 } }

command! -bang -nargs=* Ag
      \ call fzf#vim#grep(
      \   'ag --column --numbers --noheading  --smart-case '.shellescape(<q-args>), 1,
      \   fzf#vim#with_preview('up:55%'), <bang>0)
let g:rg_highlight = 1

" change focus to quickfix window after search (optional).
let g:gutentags_plus_switch = 1
" let g:ale_javascript_xo_options = "--plug=react --prettier"
" let g:ale_linter_aliases = {'jsx': ['css', 'javascript']}
" let g:ale_linters = {'jsx': ['stylelint', 'eslint']}
let g:ale_fixers = {
\  'ruby': [
\    'remove_trailing_lines',
\    'trim_whitespace',
\    'rubocop',
\    'brakeman',
\  ],
\  'javascript': ['prettier'],
\  'jsx': ['stylelint', 'eslint'],
\  'css': ['prettier'],
\  'scss': ['prettier'],
\  'sass': ['prettier'],
\  'yaml': ['yamllint'],
\}
let g:ale_linters = {
\    'ruby': ['rubocop', 'rufo', 'brakeman', 'rails_best_practices'],
\    'jsx': ['stylelint', 'eslint'],
\    'javascript': ['eslint', 'stylelint'],
\    'typescript': ['eslint'],
\    'yaml': ['yamllint'],
\    'scss': ['prettier'],
\    'sass': ['prettier'],
\    'css': ['prettier'],
\    'es6': ['eslint', 'prettier']
\}

let g:ale_ruby_rubocop_executable =  '/users/ai/.rbenv/shims/rubocop'
let g:ruby_indent_access_modifier_style = 'normal'
let g:ruby_indent_assignment_style = 'variable'
let g:ruby_indent_block_style = 'do'

highlight! link difftext matchparen
command -nargs=* Glg Git log --graph --pretty=format:'%h - (%ad)%d %s <%an>' --abbrev-commit --date=local <args>


""Cursor settings:
""  1 -> blinking block
""  2 -> solid block
""  3 -> blinking underscore
""  4 -> solid underscore
""  5 -> blinking vertical bar
""  6 -> solid vertical bar
"" max text length


let g:gutentags_ctags_exclude = [
     \ '*.git', '*.svg', '*.hg',
     \ '*/tests/*',
     \ 'build',
     \ 'dist',
     \ '*sites/*/files/*',
     \ 'bin',
     \ 'node_modules',
     \ 'bower_components',
     \ 'cache',
     \ 'compiled',
     \ 'docs',
     \ 'example',
     \ 'bundle',
     \ 'vendor',
     \ '*.md',
     \ '*-lock.json',
     \ '*.lock',
     \ '*bundle*.js',
     \ '*build*.js',
     \ '.*rc*',
     \ '*.json',
     \ '*.min.*',
     \ '*.map',
     \ '*.bak',
     \ '*.zip',
     \ '*.pyc',
     \ '*.class',
     \ '*.sln',
     \ '*.master',
     \ '*.csproj',
     \ '*.tmp',
     \ '*.csproj.user',
     \ '*.cache',
     \ '*.pdb',
     \ 'tags*',
     \ 'cscope.*',
     \ '*.css',
     \ '*.less',
     \ '*.scss',
     \ '*.js',
     \ '*.coffee',
     \ 'jsx',
     \ '*.exe', '*.dll',
     \ '*.mp3', '*.ogg', '*.flac',
     \ '*.swp', '*.swo',
     \ '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png',
     \ '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
     \ '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx',
     \ ]

let test#strategy = "dispatch"

nmap <silent> [g <plug>(coc-diagnostic-prev)
nmap <silent> ]g <plug>(coc-diagnostic-next)
nmap <silent> gd <plug>(coc-definition)
nmap <silent> gy <plug>(coc-type-definition)
nmap <silent> gi <plug>(coc-implementation)
nmap <silent> gr <plug>(coc-references)

"" Symbol renaming.
"nmap <leader>rn <Plug>(coc-rename)

"" Applying codeAction to the selected region.
"" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

"" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
"" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)
"command! Gqf GitGutterQuickFix | copen
highlight link GitGutterChangeLine DiffText


"nnoremap <leader>s :ToggleWorkspace<CR>

"" Toggle Vexplore with Ctrl-E
"" function! ToggleVExplorer()
""   if exists("t:expl_buf_num")
""       let expl_win_num = bufwinnr(t:expl_buf_num)
""       if expl_win_num != -1
""           let cur_win_nr = winnr()
""           exec expl_win_num . 'wincmd w'
""           close
""           exec cur_win_nr . 'wincmd w'
""           unlet t:expl_buf_num
""       else
""           unlet t:expl_buf_num
""       endif
""   else
""       exec '1wincmd w'
""       Vexplore
""       let t:expl_buf_num = bufnr("%")
""   endif
"" endfunction
"" map <silent> <C-E> :call ToggleVExplorer()<CR>

" Tell the language client to use the default IP and port
" that Solargraph runs on
let g:LanguageClient_autoStop = 1
let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'javascript': ['/usr/local/bin/javascript-typescript-stdio'],
    \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
    \ 'python': ['/usr/local/bin/pyls'],
    \ 'ruby': ['~/.rbenv/shims/solargraph', 'stdio'],
    \ }
nmap <F5> <Plug>(lcn-menu)
" Or map each action separately
nmap <silent>K <Plug>(lcn-hover)

" augroup disableCocInDiff
  " autocmd!
  " autocmd DiffUpdated * let b:coc_enabled=0
" augroup END
autocmd bufread,bufnewfile *.md setlocal spell

hi CursorColumn ctermfg=gray ctermbg=none
" hi CursorColumn ctermfg=white ctermbg=none
" hi CursorColumn ctermfg=black ctermbg=none

" Add autogroup for tag generation

augroup tagAug
  autocmd!
  " If we're working in a git commit (or similar), disable tag file generation
  autocmd FileType git,gitcommit,gitrebase,gitsendemail :let g:gutentags_enabled=0
augroup end

set virtualedit=all
" set runtimepath+=~/.vim-plugins/LanguageClient-neovim
let g:coc_global_extensions = ['coc-solargraph']
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
let g:netrw_sizestyle= "h"

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

let $FZF_PREVIEW_COMMAND="COLORTERM=truecolor bat --style=numbers --color=always {}"

nnoremap ]q :cnext<cr>zz
nnoremap [q :cprev<cr>zz

noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

call vundle#begin()

Plugin 'aklt/plantuml-syntax'
Plugin 'alvan/vim-closetag'
Plugin 'adelarsq/vim-matchit'
Plugin 'alxekb/vim-tags'
Plugin 'zxqfl/tabnine-vim'
Plugin 'ecomba/vim-ruby-refactoring'
Plugin 'haya14busa/incsearch.vim'
Plugin 'fatih/vim-go'
Plugin 'yuki-yano/fzf-preview.vim', { 'branch': 'release/rpc' }
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plugin 'junegunn/fzf.vim'
Plugin 'jiangmiao/auto-pairs'
Plugin 'jparise/vim-graphql'
Plugin 'jremmen/vim-ripgrep'
Plugin 'rking/ag.vim'
Plugin 'slim-template/vim-slim.git'
Plugin 'sheerun/vim-polyglot'
Plugin 'skywind3000/gutentags_plus'
Plugin 'scrooloose/vim-slumlord'
Plugin 'rizzatti/dash.vim'

Plugin 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plugin 'neoclide/coc-python', {'do': 'yarn install --frozen-lockfile'}
Plugin 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plugin 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'}

Plugin 'weirongxu/plantuml-previewer.vim'
Plugin 'Rainbow-Parenthesis'

Plugin 'terryma/vim-multiple-cursors'
Plugin 'thoughtbot/vim-rspec'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-haml'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-commentary'

Plugin 'Vundlevim/Vundle.vim'
Plugin 'ludovicchabant/vim-gutentags'

Plugin 'vim-ruby/vim-ruby'
Plugin 'vim-test/vim-test'
Plugin 'w0rp/ale'

call vundle#end()            " required
