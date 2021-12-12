set nocompatible              " be iMproved, required
set number
syntax enable
set spell
"set shell=zsh
syntax on
filetype plugin indent on
"" let g:coc_force_debug = 1
filetype on
filetype indent on
filetype plugin on
"nmap <leader>i :CocCommand tsserver.organizeImports<cr>
let g:indentLine_char = '⦙'
let g:netrw_banner=0
let g:netrw_hide=0
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
nnoremap <leader>f :Rg<CR>

set scrolloff=3
set clipboard=unnamed
"set mouse=r
set backspace=indent,eol,start
set foldmethod=syntax
set nofoldenable
hi Folded ctermbg=NONE ctermfg=DarkCyan
set expandtab tabstop=2 shiftwidth=2 softtabstop=2
"map <Leader>f :let @/=expand("%:t") <Bar> execute 'Explore' expand("%:h") <Bar> normal n<CR>
set hlsearch
"let g:incsearch#auto_nohlsearch = 1
"let g:snipMate = { 'snippet_version' : 1 }
"autocmd FileType gitcommit noremap <buffer> dt :GdiffInTab<CR>
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)
nmap <silent> <leader>d <Plug>DashSearch
"set ts=2
"set sts=2
"set et     "expand tabs to spaces
""Mode Settings
"let &t_SI.="\e[1 q" "SI = INSERT mode
"let &t_SR.="\e[4 q" "SR = REPLACE mode
"let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)
""Cursor settings:
""  1 -> blinking block
""  2 -> solid block
""  3 -> blinking underscore
""  4 -> solid underscore
""  5 -> blinking vertical bar
""  6 -> solid vertical bar
"" max text length
au BufRead,BufNewFile *.rb setlocal textwidth=120
"" if executable('ag')
"  " let g:ackprg = 'ag --vimgrep'
"" endif
"" autocmd BufRead,BufNewFile *.html,*.js,*.xml call s:CompleteTags()
"" get rid of trailing whitespace on :w
autocmd BufWritePre * %s/\s\+$//e
au BufNewFile,BufRead *.es6 set filetype=javascript

"" cursor highlight
"" :nnoremap <Leader>c :set cursorline! <CR>

"" move lines
nnoremap  <M-k> :m .-2<CR>
nnoremap  <M-j> :m .+1<CR>
nnoremap ˚ :m .-2<CR>==
nnoremap ∆ :m .+1<CR>==
inoremap ˚ <Esc>:m .-2<CR>==gi
inoremap ∆ <Esc>:m .+1<CR>==gi
vnoremap ˚ :m '<-2<CR>gv=gv
vnoremap ∆ :m '>+1<CR>gv=gv

"" remap splitting windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
"" remap splits
"" nnoremap <C-a> <C-w>

"" nmap <C-§>s :scs find s <C-R>=expand("<cword>")<CR><CR>
"" nmap <C-§>g :scs find g <C-R>=expand("<cword>")<CR><CR>
"" nmap <C-§>c :scs find c <C-R>=expand("<cword>")<CR><CR>
"" nmap <C-§>t :scs find t <C-R>=expand("<cword>")<CR><CR>
"" nmap <C-§>e :scs find e <C-R>=expand("<cword>")<CR><CR>
"" nmap <C-§>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
"" nmap <C-§>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
"" nmap <C-§>d :scs find d <C-R>=expand("<cword>")<CR><CR>
""Pathogen
"set nocp
"call pathogen#infect()

"" set spellcheck yyah
""set complete+=kspell
""set spell spelllang=en_us
"" set highlight spellbad      ctermfg=red         term=reverse        guisp=red       gui=undercurl   ctermbg=white

"" fzf search enable
set rtp+=/usr/local/opt/fzf
"" /usr/local/bin/FZF

"" set the runtime path to include vundle and initialize
set rtp+=~/.vim/bundle/vundle.vim
"" set ctrlp plugin
"set runtimepath^=~/.vim/bundle/ctrlp.vim
"let g:sneak#label = 1
set tags=tags;/
""let :solarized_termcolors = 16
call vundle#begin()
"Plugin 'codota/tabnine-vim'
"" Plugin 'autozimu/LanguageClient-neovim', {
""     \ 'branch': 'next',
""     \ 'do': 'bash install.sh',
""     \ }
Plugin 'borissov/fugitive-bitbucketserver'
" Plugin 'itchyny/vim-cursorword'
Plugin 'weirongxu/plantuml-previewer.vim'
"Plugin 'gregsexton/MatchTag'
"Plugin 'fannheyward/coc-react-refactor'
"Plugin 'conornewton/vim-pandoc-markdown-preview'
"Plugin 'shougo/neosnippet.vim'
"Plugin 'shougo/neosnippet-snippets'
"" plugin 'maxbrunsfeld/vim-yankstack'
"" plugin 'ervandew/supertab'
Plugin 'terryma/vim-multiple-cursors'
"Plugin 'pedrohdz/vim-yaml-folds'
"" plugin 'godlygeek/tabular'
"" Plugin 'plasticboy/vim-markdown'
Plugin 'Rainbow-Parenthesis'
Plugin 'vim-test/vim-test'
"Plugin 'mattn/vim-gist'
"Plugin 'mattn/webapi-vim'
Plugin 'aklt/plantuml-syntax'
Plugin 'scrooloose/vim-slumlord'

Plugin 'tyru/open-browser.vim'

"Plugin 'justinmk/vim-sneak'
"" map f <plug>sneak_s
"" map f <plug>sneak_s
"" Plugin 'matze/vim-move'
"" let g:move_key_modifier = 'c'

Plugin 'yuttie/comfortable-motion.vim'
"let g:comfortable_motion_scroll_down_key = "j"
"let g:comfortable_motion_scroll_up_key = "k"
"" Plugin 'terryma/vim-smooth-scroll'
"" noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<cr>
"" noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<cr>
"" noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<cr>
"" noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<cr>

""
""" Plugin 'henrik/vim-open-url'
" Plugin 'ap/vim-css-color'
Plugin 'fatih/vim-go'
"" Plugin 'kamykn/dark-theme.vim'
"" colorscheme darktheme

"" Plugin 'ayu-theme/ayu-vim' " or other package manager
"""...
" set termguicolors     " enable true colors support
""let ayucolor="light"  " for light version of theme
"" let ayucolor="mirage" " for mirage version of theme
"" let ayucolor="dark"   " for dark version of theme
"" colorscheme ayu


"" Plugin 'arcticicestudio/nord-vim'
"" colorscheme nord
"""""""""""""""""""""""""""""""""""""""""""
Plugin 'kchmck/vim-coffee-script'
"Plugin 'sonph/onehalf', { 'rtp': 'vim/' }
"syntax on
" set t_co=256
set cursorline
"let g:airline_theme='onehalfdark'
"let g:airline_theme='onehalflight'
"" let g:airline_theme='onehalflight'
"" colorscheme onehalflight
"" colorscheme onehalfdark


"" lightline
"" let g:lightline = { 'colorscheme': 'onehalfdark' }
Plugin 'thoughtbot/vim-rspec'
"" Plugin 'itmammoth/run-rspec.vim'
"" Plugin 'skwp/vim-rspec'
"" Plugin 'kana/vim-vspec'
"Plugin 'vim-airline/vim-airline'
"" let g:airline_theme='onehalfdark'
Plugin 'jiangmiao/auto-pairs'
" set background=light
"let g:airline#extensions#tabline#enabled = 1
"Plugin 'vim-airline/vim-airline-themes'

Plugin 'codota/tabnine-vim'
"Plugin 'godlygeek/tabular'
Plugin 'alxekb/vim-tags'
"let g:vim_tags_auto_generate = 1
"Plugin 'plasticboy/vim-markdown'
"" Plugin 'shougo/deoplete.nvim'
"" Plugin 'webastien/vim-ctags'
"Plugin 'dart-lang/dart-vim-plugin'
"Plugin 'natebosch/vim-lsc'
"Plugin 'natebosch/vim-lsc-dart'
Plugin 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plugin 'neoclide/coc-python', {'do': 'yarn install --frozen-lockfile'}
Plugin 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plugin 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'}
let g:coc_global_extensions = [ 'coc-tsserver', 'coc-solargraph' ]
"" inoremap <silent><expr> <tab>
"      " \ pumvisible() ? "\<c-n>" :
"      " \ <sid>check_back_space() ? "\<tab>" :
"      " \ coc#refresh()
"" inoremap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<c-h>"

"" function! s:check_back_space() abort
"  " let col = col('.') - 1
"  " return !col || getline('.')[col - 1]  =~# '\s'
"" endfunction
Plugin 'ecomba/vim-ruby-refactoring'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-unimpaired'
Plugin 'adelarsq/vim-matchit'
Plugin 'Vundlevim/Vundle.vim'
"Plugin 'dyng/ctrlsf.vim'
Plugin 'rizzatti/dash.vim'
" Plugin 'skywind3000/vim-preview'
Plugin 'haya14busa/incsearch.vim'
Plugin 'tpope/vim-dispatch'
"Plugin 'tpope/vim-rhubarb'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-commentary'
noremap <c-m> :Commentary<cr>
"" noremap ÷ :Commentary<cr>
autocmd filetype ruby setlocal commentstring=#\ %s
map <s-d> :tabnext<cr>
map <s-w> :tabnew<cr>
map <s-s> :tabpr<cr>
Plugin 'tpope/vim-rails'
Plugin 'pope/vim-abolish'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-haml'
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plugin 'junegunn/fzf.vim'
Plugin 'chengzeyi/fzf-preview.vim'
Plugin 'rking/ag.vim'

let g:fzf_preview_window = ['up:60%', 'ctrl-/']
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.85 } }

nnoremap <leader> 0 :Git log --since=midnight --pretty=format:"%s" <cr>
command! -bang -nargs=* Ag
\ call fzf#vim#grep(
\   'ag --column --numbers --noheading  --smart-case '.shellescape(<q-args>), 1,
\   fzf#vim#with_preview('up:55%'), <bang>0)
" remap envoke key
nnoremap <silent> <c-z> :FZF<cr>
nnoremap <silent> <c-x> :Buffers<cr>
" ripgrep
Plugin 'jremmen/vim-ripgrep'
Plugin 'miyase256/vim-ripgrep'
let g:rg_highlight = 1

Plugin 'slim-template/vim-slim.git'
Plugin 'sheerun/vim-polyglot'
Plugin 'alvan/vim-closetag'
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.erb,*.jsx,*.js,*.tsx,*.md,*.es6'
" Plugin 'mileszs/ack.vim'
Plugin 'ludovicchabant/vim-gutentags'
Plugin 'w0rp/ale'
Plugin 'jparise/vim-graphql'
Plugin 'skywind3000/gutentags_plus'
let g:gutentags_define_advanced_commands = 1
" enable gtags module
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
" generate datebases in my cache directory, prevent gtags files polluting my project
let g:gutentags_cache_dir = expand('~/.cache/tags')

" change focus to quickfix window after search (optional).
let g:gutentags_plus_switch = 1

call vundle#end()            " required
" ale
nmap <leader>af :ALEFix<cr>
nmap <leader>n :ALENext<cr>
nmap = :Rex<cr>
let g:netrw_liststyle = 4
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_save = 1
" let g:ale_fix_on_save = 1
" Enable completion where available.
let g:ale_completion_enabled = 0
" let g:ale_completion_enabled = 1
let g:ale_set_loclist = 1
let g:ale_linters_explicit = 1
" Write this in your vimrc file
let g:ale_lint_on_text_changed = 'never'
" Show 5 lines of errors (default: 10)
let g:ale_list_window_size = 5
" let g:ale_list_window_size = 5
" You can disable this option too
" if you don't want linters to run on opening a file
let g:ale_lint_on_enter = 0
" highlight clear ALEWarningSign
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
" vim-ruby
let g:ruby_indent_access_modifier_style = 'normal'
let g:ruby_indent_assignment_style = 'variable'
let g:ruby_indent_block_style = 'do'
highlight! link difftext matchparen
command -nargs=* Glg Git log --graph --pretty=format:'\%h - (\%ad)\%d \%s <\%an>' --abbrev-commit --date=local <args>
" source ~/.vim/Plugins/cscope_maps.vim
autocmd bufread,bufnewfile *.md setlocal spell
" let g:vim_markdown_conceal

set laststatus=2
" set statusline+=%#normal#
" set statusline+=%{expand('%:P:h:t')}/%t
" set statusline+=%=

" autocmd %=%{&filetype}
function! MyStatusLine()
    let l:w = min([14,winwidth(0)/2-3])
    return expand("%f %h%w%m%r%=%-" . l:w . ".(%l,%c%V%) %P")
endfunction
set statusline=%{MyStatusLine()}

" set complete+=kspell
autocmd bufread,bufnewfile *.md setlocal spell

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

"let g:gutentags_define_advanced_commands = 1

"" always show the signcolumn, otherwise it would shift the text each time
"" diagnostics appear/become resolved.
"if has("nvim-0.5.0") || has("patch-8.1.1564")
"  " recently vim can merge signcolumn and number column into one
"  set signcolumn=number
"else
"  set signcolumn=yes
"endif

nmap <silent> [g <plug>(coc-diagnostic-prev)
nmap <silent> ]g <plug>(coc-diagnostic-next)

"" goto code navigation.
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

"" Map function and class text objects
"" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
"" xmap if <Plug>(coc-funcobj-i)
"" omap if <Plug>(coc-funcobj-i)
"" xmap af <Plug>(coc-funcobj-a)
"" omap af <Plug>(coc-funcobj-a)
"" xmap ic <Plug>(coc-classobj-i)
"" omap ic <Plug>(coc-classobj-i)
"" xmap ac <Plug>(coc-classobj-a)
"" omap ac <Plug>(coc-classobj-a)

" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

"" Mappings for CoCList
"" Show all diagnostics.
"" nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
"" Manage extensions.
"" nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
"" Show commands.
"" nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
"" Find symbol of current document.
"" nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
"" Search workspace symbols.
"" nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
"" Do default action for next item.
"" nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
"" Do default action for previous item.
"" nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
"" Resume latest coc list.
"" nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
"" hi Pmenu ctermbg=white
" hi CocListFgYellow ctermfg=blue
"set virtualedit=all

"set diffopt+=iwhite

nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)
"command! Gqf GitGutterQuickFix | copen
"highlight link GitGutterChangeLine DiffText


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

let g:LanguageClient_autoStop = 1
" Tell the language client to use the default IP and port
" that Solargraph runs on
let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'javascript': ['/usr/local/bin/javascript-typescript-stdio'],
    \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
    \ 'python': ['/usr/local/bin/pyls'],
    \ 'ruby': ['~/.rbenv/shims/solargraph', 'stdio'],
    \ }
    " \ 'ruby': ['tcp://localhost:7658']
" note that if you are using Plug mapping you should not use `noremap` mappings.
nmap <F5> <Plug>(lcn-menu)
" Or map each action separately
nmap <silent>K <Plug>(lcn-hover)
" nmap <silent> gd <Plug>(lcn-definition)
nmap <silent> <F2> <Plug>(lcn-rename)

augroup disableCocInDiff
  autocmd!
  autocmd DiffUpdated * let b:coc_enabled=0
augroup END
set cursorcolumn
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

" inoremap <Up> <nop>
" inoremap <Down> <nop>
" inoremap <Left> <nop>
" inoremap <Right> <nop>

nnoremap gb :ls<CR>:b<Space>
