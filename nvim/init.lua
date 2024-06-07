local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- 'phha/zenburn.nvim',
  'ap/vim-css-color',
  'LunarVim/bigfile.nvim',
  -- 'brenoprata10/nvim-highlight-colors',
  "williamboman/mason.nvim",
  "folke/which-key.nvim",
  { "folke/neoconf.nvim", cmd = "Neoconf" },
  "folke/neodev.nvim",
  'tamton-aquib/keys.nvim',
  'tyru/open-browser.vim',
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  -- 'ekalinin/Dockerfile.vim',
  'github/copilot.vim',
  'suketa/nvim-dap-ruby',
  'mfussenegger/nvim-dap-python',
  { "rcarriga/nvim-dap-ui", dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"} },
  'nvim-lua/plenary.nvim',
  'mfussenegger/nvim-dap',

  'nvim-treesitter/nvim-treesitter',
  -- 'windwp/nvim-ts-autotag',
  'tree-sitter/tree-sitter-typescript',
  'tree-sitter/tree-sitter-ruby',
  'tree-sitter/tree-sitter-python',

  'antoinemadec/FixCursorHold.nvim',

  'nvim-neotest/neotest',
  'nvim-neotest/neotest-vim-test',
  'olimorris/neotest-rspec',

  'kamykn/spelunker.vim',

  'airblade/vim-gitgutter',
  'skywind3000/vim-preview',
  'alvan/vim-closetag',
  'haya14busa/incsearch.vim',
  'fatih/vim-go',
  'yuki-yano/fzf-preview.vim',
  'junegunn/fzf',
  'junegunn/fzf.vim',
  'jremmen/vim-ripgrep',
  'rking/ag.vim',
  'scrooloose/vim-slumlord',
  'weirongxu/plantuml-previewer.vim',
  'sheerun/vim-polyglot',
  'vim-ruby/vim-ruby',
  -- 'adelarsq/vim-matchit',
  -- 'LunarWatcher/auto-pairs',
  -- 'Raimondi/delimitMate',
  'tpope/vim-repeat',
  'tpope/vim-rails',
  'tpope/vim-endwise',
  'tpope/vim-ragtag',
  'tpope/vim-bundler',
  'tpope/vim-unimpaired',
  'tpope/vim-dispatch',
  'tpope/vim-fugitive',
  'tpope/vim-surround',
  'tpope/vim-repeat',
  'tpope/vim-commentary',
  'vim-ruby/vim-ruby',
  'w0rp/ale',
  'neovim/nvim-lspconfig',
  'williamboman/mason-lspconfig.nvim',
  'mfussenegger/nvim-dap',
  'rcarriga/nvim-dap-ui',
  'nvim-telescope/telescope.nvim',
  'aklt/plantuml-syntax',
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  'hrsh7th/cmp-vsnip',
  'hrsh7th/vim-vsnip',
  -- {
  --   'tzachar/cmp-tabnine',
  --   build = './install.sh',
  --   dependencies = 'hrsh7th/nvim-cmp',
  -- },
  "onsails/lspkind.nvim",
  "jose-elias-alvarez/null-ls.nvim"
})


-- require('nvim-highlight-colors').setup {}
local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    end,
  },
  window = {
    completion = {
      border = "rounded",
      winhighlight = "Normal:CmpNormal",
    },
    documentation = {
      winhighlight = "Normal:CmpDocNormal",
      border = "rounded",
      winblend = 10,
    }
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-m>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ['<C-j>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<C-k>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
    ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' }),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local lspkind = require('lspkind')

local source_mapping = {
  buffer = "[Buffer]",
  nvim_lsp = "[LSP]",
  nvim_lua = "[Lua]",
  path = "[Path]",
}

require'cmp'.setup {
  sources = {
    { name = 'nvim_lsp' }, 
    { name = 'solargraph' },
    { name = 'vim-dadbod-completion' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'tsserver' },
    { name = 'pylsp'},
  },
  formatting = {
    format = function(entry, vim_item)
      -- if you have lspkind installed, you can use it like
      -- in the following line:
      vim_item.kind = lspkind.symbolic(vim_item.kind, {mode = "symbol"})
      vim_item.menu = source_mapping[entry.source.name]
      if entry.source.name == "cmp_tabnine" then
        local detail = (entry.completion_item.labelDetails or {}).detail
        vim_item.kind = ""
        if detail and detail:find('.*%%.*') then
          vim_item.kind = vim_item.kind .. ' ' .. detail
        end

        if (entry.completion_item.data or {}).multiline then
          vim_item.kind = vim_item.kind .. ' ' .. '[ML]'
        end
      end
      local maxwidth = 80
      vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth)
      return vim_item
    end,
  },
}


local lspconfig = require'lspconfig'

lspconfig.solargraph.setup{}
lspconfig.yamlls.setup{
  yaml = {
    schemas = {
      kubernetes = "/*.yaml",
    }
  }
}
lspconfig.pylsp.setup{}
lspconfig.tsserver.setup{}
lspconfig.stimulus_ls.setup{}
lspconfig.stylelint_lsp.setup{}
lspconfig.ruby_ls.setup{}
lspconfig.tailwindcss.setup{}
lspconfig.terraformls.setup{}
lspconfig.html.setup{}
lspconfig.jsonls.setup{}
-- lspconfig.bashls.setup{}
lspconfig.dockerls.setup{}
-- lspconfig.svelte.setup{}
-- lspconfig.graphql.setup{}
-- lspconfig.vuels.setup{}
-- lspconfig.gopls.setup{}
-- lspconfig.hls.setup{}


vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.smarttab = true
vim.opt.runtimepath = vim.o.runtimepath .. ',/usr/local/bin/fzf'
vim.opt.scrolloff = 9
vim.opt.errorbells = false
vim.opt.visualbell = false
vim.opt.virtualedit = 'onemore'
vim.opt.cursorline = on
vim.opt.wrap = false

vim.opt.number = true
vim.opt.clipboard:append("unnamedplus")

vim.api.nvim_set_keymap('n', '<leader>e', ':Vexplore<CR>:let @/ = expand("%:t")<CR>/', {noremap = true, silent = true})
local width_percentage = math.floor(vim.o.columns * 0.3)
vim.g.netrw_winsize = width_percentage
vim.g.netrw_banner = 0
vim.g.netrw_preview = 1
vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = 34
vim.g.netrw_localcopydircmd = 'cp -r'
vim.g.netrw_sizestyle = "h"

vim.api.nvim_set_keymap('n', '<M-k>', ':m .-2<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<M-j>', ':m .+1<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '˚', ':m .-2<CR>==', { silent = true })
vim.api.nvim_set_keymap('n', '∆', ':m .+1<CR>==', { silent = true })
vim.api.nvim_set_keymap('i', '˚', '<Esc>:m .-2<CR>==gi', { silent = true })
vim.api.nvim_set_keymap('i', '∆', '<Esc>:m .+1<CR>==gi', { silent = true })
vim.api.nvim_set_keymap('v', '˚', ":'<,'>m '<-2<CR>gv=gv", { silent = true })
vim.api.nvim_set_keymap('v', '∆', ":'<,'>m '>+1<CR>gv=gv", { silent = true })
vim.api.nvim_set_keymap('n', '<leader>0', '"0p', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>1', '<esc>:FZF<cr>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>2', '<esc>:Git<cr>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>22', '<esc>:BCommits<cr>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>3', '<esc>:RG<cr>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>4', '<esc>:Buffers<cr>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>5', '<esc>:Commits<cr>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>d', ':DashWord<cr>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>af', ':ALEFix<cr>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>n', ':ALENext<cr>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader><space>', ':tabnew<cr>', { silent = true })
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

vim.api.nvim_set_keymap('n', '<Leader>af', '<Cmd>lua vim.lsp.buf.format()<CR>', { noremap = true, silent = true })

require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = { "lua_ls", "rust_analyzer", "solargraph", "tsserver", "pylsp"},
    automatic_installation = true,
}

vim.g.closetag_filenames = '*.html,*.xhtml,*.phtml,*.erb,*.jsx'
vim.g.closetag_xhtml_filenames = '*.xhtml,*.jsx,*.erb'
vim.g.closetag_emptyTags_caseSensitive = 1
vim.g.closetag_shortcut = '>'
vim.g.closetag_close_shortcut = '<leader>>'

vim.keymap.set('i', '<C-y>', 'copilot#Accept("\\<CR>")', {
    expr = true,
    replace_keycodes = false
  })
vim.g.copilot_no_tab_map = true

vim.api.nvim_set_keymap('i', '<C-j>', '<Plug>(copilot-next)', { silent = true })
vim.api.nvim_set_keymap('i', '<C-k>', '<Plug>(copilot-previous)', { silent = true })
vim.api.nvim_set_keymap('i', '<C-\\>', '<Plug>(copilot-dismiss)', { silent = true })
vim.api.nvim_set_keymap('i', '<C-m>', '<Plug>(copilot-select)', { silent = true })
vim.api.nvim_set_keymap('i', '<C-e>', '<Plug>(copilot-cancel)', { silent = true })
vim.api.nvim_set_keymap('i', '<C-s>', '<Plug>(copilot-suggest)', { silent = true })
-- require('zenburn').setup()
vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = 'zenburn',
  callback = function()
    vim.api.nvim_set_hl(0, 'CopilotSuggestion', {
        ctermfg = 8,
        force = true
      })
  end
})
-- require('nvim-ts-autotag').setup {
--   enable = true,
--   filetypes = { 'html', 'xml', 'javascript', 'typescript', 'typescriptreact', 'javascriptreact', 'vue', 'erb', 'eruby', 'jsx', 'tsx' }
-- }
