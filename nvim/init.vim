set nocompatible              " be iMproved, required

" set runtimepath+=~/.vim,~/.vim/after
" set packpath+=~/.vim
" source ~/.vimrc
set background=light
set number
set nospell
set scrolloff=9
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
set cc=80
set ttyfast
set completeopt=longest,menuone
set foldcolumn=1
set noerrorbells
set novisualbell

au BufRead,BufNewFile *.rb setlocal textwidth=120
au BufNewFile,BufRead *.es6 set filetype=javascript
au BufNewFile,BufRead *.ts set filetype=javascript
autocmd bufread,bufnewfile *.md setlocal spell
autocmd BufWritePre * %s/\s\+$//e

autocmd filetype ruby setlocal commentstring=#\ %s

augroup netrw_mapping
  autocmd!
  autocmd filetype netrw call NetrwMapping()
augroup END

filetype plugin indent on
" filetype on
" filetype indent on
" filetype plugin on

let g:netrw_banner =0
let g:netrw_keepdir =1
let g:netrw_preview   =1
let g:netrw_liststyle =3
let g:netrw_winsize   =34
let g:netrw_localcopydircmd ='cp -r'
let g:AutoPairsShortcutFastWrap ='<M-e>'
let g:AutoPairsFlyMode =1
let g:AutoPairs = {'<%':'%>', '(':')', '[':']', '{':'}',"'":"'",'"':'"', "`":"`", '```':'```', '"""':'"""', "'''":"'''"}
nnoremap <silent> <leader>c :Dispatch
nnoremap <silent> <leader>rr :Dispatch rubocop -A %<CR>
nnoremap <silent> <leader>tt :Dispatch RAILS_ENV=test rails rswag SWAGGER_DRY_RUN=0<CR>
nnoremap <silent> <leader>dd :Vexplore $PWD<CR>
nnoremap <silent> <leader>df :Vexplore %:~:h<CR>
nnoremap <silent> <leader>t  :Lexplore %:~:h<CR>
nnoremap <silent> <leader>s :vsplit <C-R>=expand("%:p:h")<CR><CR>
" nnoremap <leader>t :if expand("%:p:h") != "" \| exec "!" expand("%:p:h:S") \| endif<CR>
nnoremap <silent> <leader>f :Rg
nnoremap <silent> <Leader>ee :Lexplore<CR>
nnoremap <silent> ]q :cnext<cr>zz
nnoremap <silent> [q :cprev<cr>zz

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

map <silent> n <Plug>(incsearch-nohl-n)
map <silent> N <Plug>(incsearch-nohl-N)
map <silent> *  <Plug>(incsearch-nohl-*)
map <silent> #  <Plug>(incsearch-nohl-#)
map <silent> g* <Plug>(incsearch-nohl-g*)
map <silent> g# <Plug>(incsearch-nohl-g#)

nnoremap <silent> <M-k> :m .-2<CR>
nnoremap <silent> <M-j> :m .+1<CR>
nnoremap <silent>˚ :m .-2<CR>==
nnoremap <silent>∆ :m .+1<CR>==

inoremap <silent> ˚ <Esc>:m .-2<CR>==gi
inoremap <silent> ∆ <Esc>:m .+1<CR>==gi
vnoremap <silent> ˚ :m '<-2<CR>gv=gv
vnoremap <silent> ∆ :m '>+1<CR>gv=gv

nnoremap <silent>0 "0p
nnoremap <silent> <leader> 0 :Git log --since=midnight --pretty=format:"%s" <cr>
nnoremap <silent> <leader>1 <esc>:FZF<cr>
nnoremap <silent> <leader>2 <esc>:Git<cr>
nnoremap <silent> <leader>3 <esc>:Rg<cr>
nnoremap <silent> <leader>4 <esc>:Buffers<cr>
nnoremap <silent> <leader>5 <esc>:Commits<cr>

nmap <silent> <leader>d <Plug>DashSearch
nmap <silent> <leader>af :ALEFix<cr>
nmap <silent> <leader>n :ALENext<cr>
map <silent><space> :tabnew<cr>
map <silent><tab> :tabnext<cr>
map <silent><s-tab> :tabpr<cr>

let g:coc_global_extensions = [ 'coc-tsserver', 'coc-solargraph' ]
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.erb,*.jsx,*.js,*.tsx,*.md,*.es6'

let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_save = 1
let g:ale_set_loclist = 1
let g:ale_linters_explicit = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_list_window_size = 5


" config project root markers.
let g:gutentags_modules = ['ctags', 'gtags_cscope']
let g:gutentags_define_advanced_commands = 1
let g:gutentags_project_root = ['.root']
" let g:gutentags_auto_add_gtags_cscope = 1
let g:gutentags_add_default_project_roots = 1
let g:gutentags_project_root = ['package.json', '.git']
let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_empty_buffer = 0
let g:gutentags_cache_dir = expand('~/.cache/tags')
let g:gutentags_plus_switch = 1

let g:fzf_preview_window = ['up:60%', 'ctrl-/']
let g:fzf_buffers_jump = 1
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.85 } }

command! -bang -nargs=* Ag
      \ call fzf#vim#grep(
      \   'ag --column --numbers --noheading  --smart-case '.shellescape(<q-args>), 1,
      \   fzf#vim#with_preview('up:55%'), <bang>0)

let g:rg_highlight = 1

" change focus to quickfix window after search (optional).
" let g:ale_javascript_xo_options = "--plug=react --prettier"
" let g:ale_linter_aliases = {'jsx': ['css', 'javascript']}
" let g:ale_linters = {'jsx': ['stylelint', 'eslint']}
let g:ale_fixers = {
\  'ruby': [
\    'remove_trailing_lines',
\    'trim_whitespace',
\    'rubocop',
\  ],
\  'javascript': ['prettier'],
\  'jsx': ['stylelint', 'eslint'],
\  'css': ['prettier'],
\  'scss': ['prettier'],
\  'sass': ['prettier'],
\  'yaml': ['yamllint'],
\  'coffee': ['coffelint'],
\}

let g:ale_linters = {
\    'ruby': ['rubocop', 'rufo', 'rails_best_practices'],
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
let g:doge_doc_standard_ruby = 'YARD'

highlight! link difftext matchparen
" command -nargs=* Glg Git log --graph --pretty=format:'%h - (%ad)%d %s <%an>' --abbrev-commit --date=local <args>

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

" nmap <silent> [g <plug>(coc-diagnostic-prev)
" nmap <silent> ]g <plug>(coc-diagnostic-next)
nmap <silent> gc <plug>(coc-definition)
nmap <silent> gy <plug>(coc-type-definition)
nmap <silent> gi <plug>(coc-implementation)
nmap <silent> gr <plug>(coc-references)

"" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>re :RExtractMethod<cr>

"" Applying codeAction to the selected region.
"" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>ac  <Plug>(coc-codeaction)
nmap <leader>qf  <Plug>(coc-fix-current)
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)
"command! Gqf GitGutterQuickFix | copen
highlight link GitGutterChangeLine DiffText

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


hi CursorColumn ctermfg=gray ctermbg=none
" hi CursorColumn ctermfg=white ctermbg=none
" hi CursorColumn ctermfg=black ctermbg=none

" Add autogroup for tag generation

augroup tagAug
  autocmd!
  " If we're working in a git commit (or similar), disable tag file generation
  autocmd FileType git,gitcommit,gitrebase,gitsendemail :let g:gutentags_enabled=0
augroup end

set virtualedit=onemore
set runtimepath+=~/.vim-plugins/LanguageClient-neovim

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

call vundle#begin()

Plugin 'aklt/plantuml-syntax'
Plugin 'airblade/vim-localorie'
Plugin 'moll/vim-bbye' " optional dependency
Plugin 'aymericbeaumet/vim-symlink'
Plugin 'stefanoverna/vim-i18n'
Plugin 'airblade/vim-gitgutter'
Plugin 'kkoomen/vim-doge'
Plugin 'skywind3000/vim-preview'
Plugin 'ap/vim-css-color'
Plugin 'alvan/vim-closetag'
Plugin 'adelarsq/vim-matchit'
Plugin 'alxekb/vim-tags'
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
Plugin 'ludovicchabant/vim-gutentags'
Plugin 'skywind3000/gutentags_plus'
Plugin 'scrooloose/vim-slumlord'
Plugin 'rizzatti/dash.vim'

Plugin 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plugin 'neoclide/coc-python', {'do': 'yarn install --frozen-lockfile'}
Plugin 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}

Plugin 'weirongxu/plantuml-previewer.vim'

Plugin 'terryma/vim-multiple-cursors'
Plugin 'itchyny/vim-cursorword'
Plugin 'thoughtbot/vim-rspec'

Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-bundler'
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

Plugin 'rakr/vim-colors-rakr'
Plugin 'neovim/nvim-lspconfig'

call vundle#end()            " required
let g:localorie = {
    \ 'quickfix':  0,
    \ 'switch':    1
    \ }
nnoremap <silent> <leader>ll :call localorie#translate()<CR>
nnoremap <silent> <leader>lk :echo localorie#expand_key()<CR>