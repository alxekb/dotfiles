set nocompatible              " be iMproved, required

" set runtimepath+=~/.vim,~/.vim/after
" set packpath+=~/.vim
set background=light
set number
set scrolloff=9
set clipboard=unnamed
set backspace=indent,eol,start
set hlsearch
set cursorcolumn
set foldmethod=syntax
set nofoldenable
set expandtab tabstop=2 shiftwidth=2 softtabstop=2 smarttab
set cursorline
set rtp+=/usr/local/opt/fzf
set rtp+=~/.vim/bundle/vundle.vim
set tags=tags;/
set laststatus=2
set cc=120
set ttyfast
set completeopt=longest,menuone
set foldcolumn=1
set noerrorbells
set novisualbell
set encoding=UTF-8
set guifont=DroidSansMono\ Nerd\ Font:h13
set virtualedit=onemore
set runtimepath+=~/.vim-plugins/LanguageClient-neovim

let g:ruby_path = '/Users/ai/.asdf/shims/ruby'

au BufRead,BufNewFile *.rb setlocal textwidth=120
au BufNewFile,BufRead *.es6 set filetype=javascript
autocmd bufread,bufnewfile *.md,*.rb setlocal spell
autocmd BufWritePre * %s/\s\+$//e

autocmd filetype ruby setlocal commentstring=#\ %s

augroup netrw_mapping
  autocmd!
  autocmd filetype netrw call NetrwMapping()
augroup END

" filetype plugin indent on

let g:netrw_banner = 0
let g:netrw_keepdir = 1
nmap <leader>e :vs %:h <cr>

let g:netrw_preview   = 1
let g:netrw_liststyle = 3
let g:netrw_winsize   = 34
let g:netrw_localcopydircmd = 'cp -r'
let g:netrw_sizestyle= "h"

let g:AutoPairsShortcutFastWrap = '<M-e>'
let g:AutoPairsFlyMode = 1
let g:AutoPairs = {'<':'>', '<%':'%>', '(':')', '[':']', '{':'}',"'":"'",'"':'"', "`":"`", '```':'```', '"""':'"""', "'''":"'''"}

nnoremap <silent> <leader>c :Dispatch
nnoremap <silent> <leader>rr :Dispatch rubocop -A %<CR>
nnoremap <silent> <leader>tt :Dispatch RAILS_ENV=test rails rswag SWAGGER_DRY_RUN=0<CR>
nnoremap <silent> <leader>dd :Vexplore $PWD<CR>
nnoremap <silent> <leader>df :Vexplore %:~:h<CR>
nnoremap <silent> <leader>ff :vs %:<CR>
nnoremap <silent> <leader>t  :Lexplore %:~:h<CR>
nnoremap <silent> <leader>s :vsplit <C-R>=expand("%:p:h")<CR><CR>
" nnoremap <leader>t :if expand("%:p:h") != "" \| exec "!" expand("%:p:h:S") \| endif<CR>
nnoremap <silent> <leader>f :Rg<cr>
nnoremap <silent> <leader>ee :Lexplore<CR>
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

nnoremap <silent> <leader>0  "0p
" nnoremap <silent> <leader>0 :Git log --since=midnight --pretty=format:"%s" <cr>
nnoremap <silent> <leader>1 <esc>:FZF<cr>
nnoremap <silent> <leader>2 <esc>:Git<cr>
nnoremap <silent> <leader>22 <esc>:BCommits<cr>
nnoremap <silent> <leader>3 <esc>:Rg<cr>
nnoremap <silent> <leader>4 <esc>:Buffers<cr>
nnoremap <silent> <leader>5 <esc>:Commits<cr>

nmap <silent> <leader>d :DashWord<cr>
nmap <silent> <leader>af :ALEFix<cr>
nmap <silent> <leader>n :ALENext<cr>
nmap <silent><leader><space> :tabnew<cr>

let g:coc_global_extensions = [
\  'coc-tsserver',
\  'coc-solargraph',
\  'coc-css',
\  'coc-sourcekit'
\]
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.erb,*.jsx,*.js,*.tsx,*.md,*.es6,*.tsx'

let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_save = 1
let g:ale_set_loclist = 1
let g:ale_linters_explicit = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_list_window_size = 5

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
\  'haml': ['haml-lint'],
\  'hamlc': ['haml-lint'],
\  'ruby': [
\    'remove_trailing_lines',
\    'trim_whitespace',
\    'rubocop',
\  ],
\  'erb': ['rubocop', 'erblint'],
\  'javascript': ['prettier'],
\  'ts': ['tslint'],
\  'jsx': ['stylelint', 'eslint'],
\  'tsx': ['stylelint', 'eslint'],
\  'css': ['prettier'],
\  'scss': ['prettier'],
\  'sass': ['prettier'],
\  'coffee': ['coffeelint'],
\  'c': ['clang-format'],
\  'cpp': ['clang-format'],
\  'json': ['prettier'],
\  'xml': ['prettier', 'xmllint'],
\  'yaml': ['yamllint'],
\  'swift': ['swiftformat', 'swiftlint'],
\  'h': ['cpplint'],
\  'm': ['swiftlint'],
\}

let g:ale_linters = {
\  'erb': ['rubocop', 'erblint'],
\  'haml': ['haml-lint'],
\  'hamlc': ['haml-lint'],
\  'ruby': ['standardrb', 'rubocop', 'rubocop-rails'],
\  'jsx': ['stylelint', 'eslint'],
\  'tsx': ['eslint'],
\  'javascript': ['eslint', 'stylelint'],
\  'typescript': ['eslint'],
\  'scss': ['prettier'],
\  'sass': ['prettier'],
\  'css': ['prettier'],
\  'es6': ['eslint', 'prettier'],
\  'cpp': ['clang-format'],
\  'c': ['clang-format'],
\  'json': ['prettier'],
\  'yaml': ['yamllint'],
\  'xml': ['prettier', 'xmllint'],
\  'swift': ['swiftformat', 'swiftlint'],
\  'h': ['cpplint'],
\  'm': ['swiftlint'],
\  'coffee': ['coffeelint'],
\  'ts': ['tslint'],
\}

let g:ale_ruby_rubocop_executable =  '/users/ai/.asdf/shims/rubocop'
let g:ruby_reek_executable = '/Users/ai/.asdf/shims/reek'
let g:ruby_indent_access_modifier_style = 'normal'
let g:ruby_indent_assignment_style = 'variable'
let g:ruby_indent_block_style = 'do'
let g:doge_doc_standard_ruby = 'YARD'

highlight! link difftext matchparen

let test#strategy = "dispatch"

" nmap <silent> [g <plug>(coc-diagnostic-prev)
" nmap <silent> ]g <plug>(coc-diagnostic-next)
nmap <silent> gd <plug>(coc-definition)
" nmap <silent> gy <plug>(coc-type-definition)
nmap <silent> gi <plug>(coc-implementation)
nmap <silent> gr <plug>(coc-references)

"" Symbol renaming.
" nmap <leader>rn <Plug>(coc-rename)
" nmap <leader>re :RExtractMethod<cr>

"" Applying codeAction to the selected region.
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>ac  <Plug>(coc-codeaction)
nmap <leader>qf  <Plug>(coc-fix-current)
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)

highlight link GitGutterChangeLine DiffText

let g:LanguageClient_autoStop = 1
let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'javascript': ['/usr/local/bin/javascript-typescript-stdio'],
    \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
    \ 'python': ['/usr/local/bin/pyls'],
    \ 'ruby': ['~/.asdf/shims/solargraph', 'stdio'],
    \ }
nmap <F5> <Plug>(lcn-menu)
" Or map each action separately
nmap <silent>K <Plug>(lcn-hover)

hi CursorColumn ctermfg=gray ctermbg=none

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

let $FZF_PREVIEW_COMMAND="COLORTERM=truecolor bat --style=numbers --color=always {}"

call vundle#begin()

Plugin  'sheerun/vim-polyglot'

Plugin 'aklt/plantuml-syntax'

Plugin 'tyru/open-browser.vim'
Plugin 'iamcco/markdown-preview.nvim'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'suketa/nvim-dap-ruby'
Plugin 'mfussenegger/nvim-dap'
Plugin  'nvim-lua/plenary.nvim'
Plugin 'ThePrimeagen/harpoon'
nmap <leader>h <cmd>lua require'harpoon.ui'.toggle_quick_menu()<cr>
nmap <leader>hh <cmd>Telescope harpoon marks<cr>
nmap <leader>7 <cmd>Telescope harpoon marks<cr>
nmap <leader>u <cmd>lua require'harpoon.mark'.add_file()<cr>

Plugin 'nvim-treesitter/nvim-treesitter'
Plugin 'tree-sitter/tree-sitter-typescript'
Plugin 'tree-sitter/tree-sitter-ruby'
Plugin 'antoinemadec/FixCursorHold.nvim'
Plugin 'nvim-neotest/neotest'
Plugin 'nvim-neotest/neotest-vim-test'
Plugin 'olimorris/neotest-rspec'
Plugin 'kamykn/spelunker.vim'
Plugin 'github/copilot.vim'

let g:copilot_no_tab_map = v:true
imap <silent><script><expr><Right> copilot#Accept("\<CR>")
imap <silent><Down> <Plug>(copilot-next)
imap <silent><Up> <Plug>(copilot-previous)

Plugin 'airblade/vim-gitgutter'
Plugin 'skywind3000/vim-preview'
Plugin 'alvan/vim-closetag'
Plugin 'adelarsq/vim-matchit'
Plugin 'alxekb/vim-tags'
Plugin 'ecomba/vim-ruby-refactoring'
Plugin 'haya14busa/incsearch.vim'
Plugin 'fatih/vim-go'
Plugin 'yuki-yano/fzf-preview.vim', { 'branch': 'release/rpc' }
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plugin 'junegunn/fzf.vim'

Plugin 'jremmen/vim-ripgrep'
Plugin 'rking/ag.vim'
Plugin 'scrooloose/vim-slumlord'

Plugin 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
" Plugin 'neoclide/coc-python', {'do': 'yarn install --frozen-lockfile'}
Plugin 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}

Plugin 'weirongxu/plantuml-previewer.vim'

Plugin 'terryma/vim-multiple-cursors'
Plugin 'itchyny/vim-cursorword'

Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-dispatch'
Plugin 'Raimondi/delimitMate'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-commentary'

Plugin 'Vundlevim/Vundle.vim'

Plugin 'vim-ruby/vim-ruby'

Plugin 'w0rp/ale'

Plugin 'neovim/nvim-lspconfig'
Plugin 'nvim-telescope/telescope.nvim'
Plugin 'mrjones2014/dash.nvim'

call vundle#end()            " required
let g:python3_host_prog = '/Library/Frameworks/Python.framework/Versions/3.8/bin/python3'
let g:rails_projections = {
      \  'app/*.rb': {
      \     'alternate': 'spec/{}_spec.rb',
      \     'type': 'source'
      \   },
      \  'spec/engines/*_spec.rb': {
      \     'alternate': 'app/{}.rb',
      \     'type': 'test'
      \   }
      \}
" map <Leader>6 :call RunCurrentSpecFile()<CR>
nmap <leader>6 :lua require("neotest").summary.toggle()<CR>
nmap <leader>66 :lua require("neotest").summary.close()<CR>
nmap <leader>y :lua require("neotest").run.run()<CR>
nmap <leader>yy :lua require("neotest").run.run(vim.fn.expand("%"))<CR>

let g:rspec_command = "Dispatch rspec {spec}"

let g:cursorhold_updatetime = 100

lua << EOF
function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function nmap(shortcut, command)
  map('n', shortcut, command)
end

function imap(shortcut, command)
  map('i', shortcut, command)
end

require('dap-ruby').setup()
local dap = require('dap')
dap.adapters.ruby = {
  type = 'executable';
  command = 'bundle';
  args = {'exec', 'readapt', 'stdio'};
}

require("neotest").setup({
	adapters = {
    require("neotest-rspec")({
      rspec_cmd = function()
        return vim.tbl_flatten({"bundle", "exec", "rspec"})
      end
    }),
		require("neotest-vim-test")({
			ignore_file_types = { "python", "vim", "lua", "ruby" },
		}),
	},
})
dap.configurations.ruby = {
  {
    type = 'ruby';
    request = 'launch';
    name = 'Rails';
    program = 'bundle';
    programArgs = {'exec', 'rails', 's'};
    useBundler = true;
  },
}
EOF
let g:rails_projections = {
      \  'app/*.rb': {
      \     'alternate': 'spec/{}_spec.rb',
      \     'type': 'source'
      \   },
      \  'spec/*_spec.rb': {
      \     'alternate': 'app/{}.rb',
      \     'type': 'test'
      \   }
      \}
autocmd BufNewFile,BufRead Dockerfile* set syntax=dockerfile
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<TAB>"
inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1, 1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0, -1)\<cr>" : "\<Left>"
highlight CocErrorFloat ctermfg=none
hi CursorColumn ctermfg=none

let g:LargeFile = 5 * 1024 * 1024
augroup LargeFile
  au!
  autocmd BufReadPre * let f=getfsize(expand("<afile>")) | if f > g:LargeFile || f == -2 | call LargeFile() | endif
augroup END

function! LargeFile()
 set eventignore+=FileType
 set syntax=off
 setlocal bufhidden=unload
 setlocal buftype=nowrite
 setlocal undolevels=-1
 autocmd VimEnter *  echo "The file is larger than " . (g:LargeFile / 1024 / 1024) . " MB, so some options are changed (see .vimrc for details)."
endfunction
nmap <silent><leader>hc :lua require("harpoon").get_mark_config().marks = {}  <cr>
nmap <silent><Tab> :lua require("harpoon.ui").nav_next()<cr>
nmap <silent><S-Tab> :lua require("harpoon.ui").nav_prev()<cr>
nmap <silent>1 :lua require("harpoon.ui").nav_file(1)<cr>
nmap <silent>2 :lua require("harpoon.ui").nav_file(2)<cr>
nmap <silent>3 :lua require("harpoon.ui").nav_file(3)<cr>

lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "lua", "vim", "help", "query", "ruby", "bash", "json", "yaml", "html", "css", "javascript", },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  highlight = {
    enable = true,
    disable = {},
    disable = function(lang, buf)
        local max_filesize = 1 * 1024 -- 1 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,
    additional_vim_regex_highlighting = false,
  },
}
EOF
