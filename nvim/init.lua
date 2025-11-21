local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  'github/copilot.vim',
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      "nvim-neotest/nvim-nio",
      'jay-babu/mason-nvim-dap.nvim',
      'mfussenegger/nvim-dap-python',
      "theHamsta/nvim-dap-virtual-text",
      "igorlfs/nvim-dap-view", -- Using dap-view instead of dap-ui
    },
    keys = {
      {
        mode = "n",
        "<leader>df",
        function()
          require("dap-python").test_method()
        end,
        desc = "Debug Test Method"
      },
      {
        mode = "n", 
        "<leader>dt",
        function()
          require("dap-python").test_class()
        end,
        desc = "Debug Test Class"
      },
    },
    config = function()
      local dap = require("dap")
      local dap_python = require("dap-python")
      local dapview = require("dap-view")

      -- Helper function to find project root
      local function find_project_root()
        local markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git", "pytest.ini", "tox.ini", ".venv" }
        local current_dir = vim.fn.expand("%:p:h")

        while current_dir ~= "/" do
          for _, marker in ipairs(markers) do
            if vim.fn.filereadable(current_dir .. "/" .. marker) == 1 or vim.fn.isdirectory(current_dir .. "/" .. marker) == 1 then
              return current_dir
            end
          end
          current_dir = vim.fn.fnamemodify(current_dir, ":h")
        end

        -- Fallback to current working directory
        return vim.fn.getcwd()
      end

      -- Enhanced Python path detection
      local function get_python_path()
        local project_root = find_project_root()

        -- Check for virtual environment
        local venv_path = os.getenv('VIRTUAL_ENV')
        if venv_path then
          return venv_path .. '/bin/python'
        end

        -- Check for project-local venv
        local venv_python = project_root .. '/.venv/bin/python'
        if vim.fn.executable(venv_python) == 1 then
          return venv_python
        end

        -- Check for other common venv names
        local common_venv_names = { 'venv', 'env', '.env' }
        for _, name in ipairs(common_venv_names) do
          local python_path = project_root .. '/' .. name .. '/bin/python'
          if vim.fn.executable(python_path) == 1 then
            return python_path
          end
        end

        -- Fallback to system python
        return vim.fn.exepath('python3') or vim.fn.exepath('python') or '/usr/bin/python3'
      end

      local python_path = get_python_path()

      -- Setup dap-python with proper test runner
      dap_python.setup(python_path)
      dap_python.test_runner = "pytest"

      -- Setup dap-view (replaces dap-ui)
      dapview.setup({
        -- Add your dap-view specific configuration here
      })

      -- Setup virtual text
      require("nvim-dap-virtual-text").setup({
        commented = true,
      })

      -- Python adapter configuration
      dap.adapters.python = {
        type = 'executable',
        command = python_path,
        args = { '-m', 'debugpy.adapter' },
        options = {
          source_filetype = 'python',
        },
      }

      -- Enhanced Python configurations with proper path handling
      dap.configurations.python = {
        -- FastAPI configuration (keeping your existing one)
        {
          type = "python",
          request = "launch",
          name = "FastAPI",
          module = "uvicorn",
          args = { "app.main:app", "-h", "0.0.0.0", "-p", "8002" },
          cwd = function()
            return find_project_root()
          end,
          env = function()
            local project_root = find_project_root()
            local variables = {
              PYTHONPATH = project_root,
            }
            -- Merge with existing environment
            for k, v in pairs(vim.fn.environ()) do
              variables[k] = v
            end
            return variables
          end,
          subProcess = false,
          pythonPath = function()
            return get_python_path()
          end,
        },
        
        -- Launch current file with proper paths
        {
          type = 'python',
          request = 'launch',
          name = "Launch file",
          program = "${file}",
          cwd = function()
            return find_project_root()
          end,
          env = function()
            local project_root = find_project_root()
            return {
              PYTHONPATH = project_root,
            }
          end,
          pythonPath = function()
            return get_python_path()
          end,
        },

        -- Debug all pytest tests
        {
          type = "python",
          request = "launch",
          name = "Debug pytest (all tests)",
          module = "pytest",
          args = { "." },
          cwd = function()
            return find_project_root()
          end,
          env = function()
            local project_root = find_project_root()
            return {
              PYTHONPATH = project_root,
            }
          end,
          pythonPath = function()
            return get_python_path()
          end,
          console = "integratedTerminal",
        },

        -- Debug current pytest file
        {
          type = "python",
          request = "launch",
          name = "Debug current pytest file",
          module = "pytest",
          args = function()
            local current_file = vim.fn.expand("%:p")
            local project_root = find_project_root()
            -- Get relative path from project root
            local relative_path = vim.fn.substitute(current_file, "^" .. project_root .. "/", "", "")
            return { relative_path, "-v" }
          end,
          cwd = function()
            return find_project_root()
          end,
          env = function()
            local project_root = find_project_root()
            return {
              PYTHONPATH = project_root,
            }
          end,
          pythonPath = function()
            return get_python_path()
          end,
          console = "integratedTerminal",
        },

        -- Debug specific pytest function
        {
          type = "python",
          request = "launch",
          name = "Debug pytest (input test)",
          module = "pytest",
          args = function()
            local test_name = vim.fn.input("Test name (e.g., test_function or TestClass::test_method): ")
            if test_name == "" then
              return { "." }
            end
            
            local current_file = vim.fn.expand("%:p")
            local project_root = find_project_root()
            local relative_path = vim.fn.substitute(current_file, "^" .. project_root .. "/", "", "")
            
            return { relative_path .. "::" .. test_name, "-v" }
          end,
          cwd = function()
            return find_project_root()
          end,
          env = function()
            local project_root = find_project_root()
            return {
              PYTHONPATH = project_root,
            }
          end,
          pythonPath = function()
            return get_python_path()
          end,
          console = "integratedTerminal",
        },

        -- Debug pytest with custom args
        {
          type = "python",
          request = "launch",
          name = "Debug pytest (custom args)",
          module = "pytest",
          args = function()
            local args_string = vim.fn.input("Pytest args: ", "-v")
            return vim.split(args_string, " ")
          end,
          cwd = function()
            return find_project_root()
          end,
          env = function()
            local project_root = find_project_root()
            return {
              PYTHONPATH = project_root,
            }
          end,
          pythonPath = function()
            return get_python_path()
          end,
          console = "integratedTerminal",
        },
      }

      -- DAP signs (keeping your existing styling)
      vim.fn.sign_define("DapBreakpoint", {
        text = "🔴",
        texthl = "DiagnosticSignError",
        linehl = "",
        numhl = "",
      })

      vim.fn.sign_define("DapBreakpointRejected", {
        text = "⭕",
        texthl = "DiagnosticSignError",
        linehl = "",
        numhl = "",
      })

      vim.fn.sign_define("DapStopped", {
        text = "➤",
        texthl = "DiagnosticSignWarn",
        linehl = "Visual",
        numhl = "DiagnosticSignWarn",
      })

      -- Auto open/close dap-view
      dap.listeners.after.event_initialized["dapview_config"] = function()
        dapview.open()
      end
      dap.listeners.before.event_terminated["dapview_config"] = function()
        dapview.close()
      end
      dap.listeners.before.event_exited["dapview_config"] = function()
        dapview.close()
      end

      -- Enhanced keymaps
      local opts = { noremap = true, silent = true }

      -- Basic debugging controls
      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
      vim.keymap.set("n", "<leader>dB", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, { desc = "Set Conditional Breakpoint" })
      
      vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Debug: Continue" })
      vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Debug: Step Over" })
      vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Debug: Step Into" })
      vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "Debug: Step Out" })
      vim.keymap.set("n", "<leader>dq", dap.terminate, { desc = "Debug: Terminate" })

      -- Function keys for quick access
      -- vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
      -- vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: Step Over" })
      -- vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: Step Into" })
      -- vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Debug: Step Out" })

      -- Python/pytest specific shortcuts
      vim.keymap.set("n", "<leader>dpt", function()
        dap_python.test_method()
      end, { desc = "Debug: Test Method" })
      
      vim.keymap.set("n", "<leader>dpc", function()
        dap_python.test_class()
      end, { desc = "Debug: Test Class" })
      
      vim.keymap.set("v", "<leader>dps", function()
        dap_python.debug_selection()
      end, { desc = "Debug: Selection" })

      -- dap-view controls
      vim.keymap.set("n", "<leader>dv", dapview.toggle, { desc = "Toggle DAP View" })
      -- vim.keymap.set("n", "<leader>de", dapview.eval, { desc = "Evaluate Expression" })

      -- Utility functions for debugging
      vim.keymap.set("n", "<leader>drl", function()
        dap.run_last()
      end, { desc = "Debug: Run Last" })

      vim.keymap.set("n", "<leader>dr", function()
        dap.repl.open()
      end, { desc = "Debug: Open REPL" })

      -- Enhanced pytest debugging with better error handling
      vim.keymap.set("n", "<leader>dpf", function()
        local current_file = vim.fn.expand("%:p")
        if not current_file:match("test_.*%.py$") and not current_file:match(".*_test%.py$") then
          vim.notify("Not in a test file", vim.log.levels.WARN)
          return
        end
        
        -- Find and run the appropriate test configuration
        local configs = dap.configurations.python
        for _, config in ipairs(configs) do
          if config.name == "Debug current pytest file" then
            dap.run(config)
            return
          end
        end
      end, { desc = "Debug: Current Test File" })
    end,
  },
  {
    "echasnovski/mini.diff",
    config = function()
      local diff = require("mini.diff")
      diff.setup({
        -- Disabled by default
        source = diff.gen_source.none(),
      })
    end,
  },
  -- {
  --   "supermaven-inc/supermaven-nvim",
  --   config = function()
  --     require("supermaven-nvim").setup({})
  --   end,
  -- },
  'ap/vim-css-color',
  'LunarVim/bigfile.nvim',
  'RRethy/base16-nvim',
  "williamboman/mason.nvim",
  "folke/which-key.nvim",
  { "folke/neoconf.nvim", cmd = "Neoconf" },
  "folke/neodev.nvim",
  'tamton-aquib/keys.nvim',
  'tyru/open-browser.vim',
  'nvim-lua/plenary.nvim',
  -- {
  --   'mfussenegger/nvim-dap',
  --   dependencies = {
  --     "nvim-neotest/nvim-nio",
  --     'jay-babu/mason-nvim-dap.nvim',
  --     'mfussenegger/nvim-dap-python',
  --     "theHamsta/nvim-dap-virtual-text",
  --   },
  --   keys = {
  --     {
  --       mode = "n",
  --       "<leader>df",
  --       function()
  --         require("dap-python").test_method()
  --       end,
  --     },
  --   },
  --   config = function()
  --     local dap = require("dap")
  --     local dap_python = require("dap-python")
  --     -- local debug_path = vim.loop.os_homedir() .. '/.virtualenvs/debugpy/bin/python'


  --     dap_python.test_runner = "pytest"
  --     local function get_python_path()
  --       local venv_path = os.getenv('VIRTUAL_ENV')
  --       if venv_path then
  --         return venv_path .. '/bin/python'
  --       end

  --       local cwd = "/Users/alekseiivanov/dev/github/AI-Document-Analyser"
  --       local venv_python = cwd .. '/.venv/bin/python'
  --       if vim.fn.executable(venv_python) == 1 then
  --         return venv_python
  --       end

  --       return "/Users/alekseiivanov/dev/github/AI-Document-Analyser"  --- vim.fn.exepath('python3') or vim.fn.exepath('python') or debug_path
  --     end

  --     local python_path = get_python_path()

  --     dap.adapters.python = {
  --       type = 'executable',
  --       command = "/Users/alekseiivanov/dev/github/AI-Document-Analyser/.venv/bin/python", --  debug_path,
  --       args = { '-m', 'debugpy.adapter' },
  --     }

  --     dap.configurations.python = {
  --       {
  --         type = "python",
  --         request = "launch",
  --         name = "FastAPI",
  --         module = "uvicorn",
  --         args = { "app.main:app", "-h", "0.0.0.0", "-p", "8002" },
  --         cwd = "/Users/alekseiivanov/dev/github/AI-Document-Analyser",
  --         env = function()
  --           local variables = {
  --             PYTHONPATH = "/Users/alekseiivanov/dev/github/AI-Document-Analyser",
  --           }
  --           for k, v in pairs(vim.fn.environ()) do
  --             table.insert(variables, string.format("%s=%s", k, v))
  --           end
  --           return variables
  --         end,
  --         subProcess = false,
  --       },
  --       {
  --         type = 'python',
  --         request = 'launch',
  --         name = "Launch file",
  --         program = "${file}",
  --         pythonPath = function()
  --           return python_path
  --         end,
  --       },
  --     }

  --     dap_python.test_runner = "pytest"

  --     vim.fn.sign_define("DapBreakpoint", {
  --       text = "",
  --       texthl = "DiagnosticSignError",
  --       linehl = "",
  --       numhl = "",
  --     })

  --     vim.fn.sign_define("DapBreakpointRejected", {
  --       text = "", -- or "❌"
  --       texthl = "DiagnosticSignError",
  --       linehl = "",
  --       numhl = "",
  --     })

  --     vim.fn.sign_define("DapStopped", {
  --       text = "", -- or "→"
  --       texthl = "DiagnosticSignWarn",
  --       linehl = "Visual",
  --       numhl = "DiagnosticSignWarn",
  --     })

  --     require("nvim-dap-virtual-text").setup({
  --       commented = true, -- Show virtual text alongside comment
  --     })

  --     local opts = { noremap = true, silent = true }

  --     -- Toggle breakpoint
  --     vim.keymap.set("n", "<leader>db", function()
  --       dap.toggle_breakpoint()
  --     end, opts)

  --     -- Continue / Start
  --     vim.keymap.set("n", "<leader>dc", function()
  --       dap.continue()
  --     end, opts)

  --     -- Step Over
  --     vim.keymap.set("n", "<leader>do", function()
  --       dap.step_over()
  --     end, opts)

  --     -- Step Into
  --     vim.keymap.set("n", "<leader>di", function()
  --       dap.step_into()
  --     end, opts)

  --     -- Step Out
  --     vim.keymap.set("n", "<leader>dO", function()
  --       dap.step_out()
  --     end, opts)
			
  --     -- Keymap to terminate debugging
	  -- vim.keymap.set("n", "<leader>dq", function()
	      -- require("dap").terminate()
  --     end, opts)
  --   end,
  -- },

  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      {
        "OXY2DEV/markview.nvim",
        lazy = false,
        opts = function()
          local function conceal_tag(icon, hl_group)
            return {
              on_node = { hl_group = hl_group },
              on_closing_tag = { conceal = '' },
              on_opening_tag = {
                conceal = '',
                virt_text_pos = 'inline',
                virt_text = {{ icon .. ' ', hl_group }},
              },
            }
          end

          return {
            html = {
              container_elements = {
                ['^buf$']         = conceal_tag('', 'CodeCompanionChatVariable'),
                ['^file$']        = conceal_tag('', 'CodeCompanionChatVariable'),
                ['^help$']        = conceal_tag('󰘥', 'CodeCompanionChatVariable'),
                ['^image$']       = conceal_tag('', 'CodeCompanionChatVariable'),
                ['^symbols$']     = conceal_tag('', 'CodeCompanionChatVariable'),
                ['^url$']         = conceal_tag('󰖟', 'CodeCompanionChatVariable'),
                ['^var$']         = conceal_tag('', 'CodeCompanionChatVariable'),
                ['^tool$']        = conceal_tag('', 'CodeCompanionChatTool'),
                ['^user_prompt$'] = conceal_tag('', 'CodeCompanionChatTool'),
                ['^group$']       = conceal_tag('', 'CodeCompanionChatToolGroup'),
              },
            },
          }
        end,
      },
    },
  },
  'tree-sitter/tree-sitter-typescript',
  'tree-sitter/tree-sitter-ruby',
  'tree-sitter/tree-sitter-python',
  'antoinemadec/FixCursorHold.nvim',

  'nvim-neotest/neotest',
  'nvim-neotest/neotest-vim-test',
  -- 'olimorris/neotest-rspec',
  'vim-test/vim-test',

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
  -- 'mfussenegger/nvim-dap',
  'nvim-telescope/telescope.nvim',
  'aklt/plantuml-syntax',
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  'hrsh7th/cmp-vsnip',
  'hrsh7th/vim-vsnip',
  "onsails/lspkind.nvim",
  "jose-elias-alvarez/null-ls.nvim",

  {
    "olimorris/codecompanion.nvim",
    config = function(_, opts)
      local workflows = dofile('/Users/alekseiivanov/dotfiles/nvim/lua/codecompanion_workflows.lua')
      
      -- Merge workflows into opts
      opts.workflows = workflows.workflows
      
      require("codecompanion").setup(opts)
      workflows.setup_keymaps()
    end,
    dependencies = {
      {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown", "codecompanion" }
      },
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "ravitemer/mcphub.nvim",
      "MeanderingProgrammer/render-markdown.nvim",
      "echasnovski/mini.diff",
      "echasnovski/mini.indentscope",
      {
        "HakonHarnes/img-clip.nvim",
        opts = {
          filetypes = {
            codecompanion = {
              prompt_for_file_name = false,
              template = "[Image]($FILE_PATH)",
              use_absolute_path = true,
            },
          },
        },
      },
      {
        "ravitemer/mcphub.nvim",
        dependencies = {
          "nvim-lua/plenary.nvim",
        },
        build = "npm install -g mcp-hub@latest",  -- Installs `mcp-hub` node binary globally
        config = function()
          require("mcphub").setup({
              port = 3000,
              config = vim.fn.expand("~/mcpservers.json"),
            })
        end
      },
      {
        "Davidyz/VectorCode",
        version = "*", -- optional, depending on whether you're on nightly or release
        dependencies = { "nvim-lua/plenary.nvim" },
        cmd = "VectorCode", -- if you're lazy-loading VectorCode
        },
    },
    opts = {
      log_level = 'DEBUG',
      workflows = dofile('/Users/alekseiivanov/dotfiles/nvim/lua/codecompanion_workflows.lua').workflows,
    },
    display = {
      diff = {
        enabled = true,
        layout = 'vertical', -- vertical|horizontal split for default provider
        opts = { 'internal', 'filler', 'closeoff', 'algorithm:patience', 'followwrap', 'linematch:120' },
        provider = 'mini_diff', -- default|mini_diff
      },
    },
  },
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
  },
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
    ['<C-j>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<C-k>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
    ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' }),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
  }),
  sources = cmp.config.sources({
    per_filetype = {
      codecompanion = { "codecompanion" },
    },

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
-- lspconfig.pylsp.setup{}
-- lspconfig.tsserver.setup{}
-- lspconfig.stimulus_ls.setup{}
-- lspconfig.stylelint_lsp.setup{}
-- lspconfig.tailwindcss.setup{}
-- lspconfig.terraformls.setup{}
-- lspconfig.html.setup{}
-- lspconfig.jsonls.setup{}
-- lspconfig.bashls.setup{}
-- lspconfig.dockerls.setup{}
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

local function open_sidebar_and_find()
  local current_file = vim.fn.expand("%:t")
  if current_file == "" then
    vim.cmd('Sex!')
    return
  end
  
  vim.cmd('Sex!')
  vim.defer_fn(function()
    vim.fn.setreg('/', current_file)
    vim.fn.search(current_file)
  end, 150)
end

vim.keymap.set('n', '<leader>e', open_sidebar_and_find, {noremap = true, silent = true})
vim.keymap.set('n', '<leader>c', ':CodeCompanionActions<CR>', {noremap = true, silent = true})
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
-- vim.api.nvim_set_keymap('n', '<leader>ff', ':ALEFix<cr>', { silent = true })
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

vim.api.nvim_set_keymap('n', '<Leader>ff', '<Cmd>lua vim.lsp.buf.format()<CR>', { noremap = true, silent = true })

require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = { "solargraph"},
    automatic_installation = true,
}
vim.g.closetag_filenames = '*.html,*.xhtml,*.phtml,*.erb,*.jsx'
vim.g.closetag_xhtml_filenames = '*.xhtml,*.jsx,*.erb'
vim.g.closetag_emptyTags_caseSensitive = 1
vim.g.closetag_shortcut = '>'
vim.g.closetag_close_shortcut = '<leader>>'
vim.opt.laststatus = 3

require("codecompanion").setup({
  tools = {
    ["mcp"] = {
      callback = require("mcphub.extensions.codecompanion"),
      description = "Call tools and resources from the MCP Servers",
      opts = {
        user_approval = true,
      },
    },
  },
  strategies = {
    chat = {
      adapter = "copilot",
      tools = {
        groups = {
          ["github_pr_workflow"] = {
            description = "GitHub operations from issue to PR",
            tools = {
              -- File operations
              "neovim__read_multiple_files", "neovim__write_file", "neovim__edit_file",
              -- GitHub operations
              "github__list_issues", "github__get_issue", "github__get_issue_comments",
              "github__create_issue", "github__create_pull_request", "github__get_file_contents",
              "github__create_or_update_file",  "github__search_code"             
            },
          },
        },
      },
    },
    inline = {
      adapter = "copilot"
    },
    cmd = {
      adapter = "copilot"
    },
  },
  opts = {
    log_level = "DEBUG", -- TRACE|DEBUG|ERROR|INFO
  },
  extensions = {
    mcphub = {
      callback = "mcphub.extensions.codecompanion",
      opts = {
        make_vars = true,
        show_server_tools_in_chat = true,
        make_slash_commands = true,
        show_result_in_chat = true
      }
    }
  },
  adapters = {
    my_openai = function()
      return require("codecompanion.adapters").extend("openai_compatible", {
        env = {
          -- url = "0.tcp.eu.ngrok.io:18315/v1", -- optional: default value is ollama url http://127.0.0.1:11434
          url = "http://localhost:11435/v1", -- optional: default value is ollama url http://127.0.0.1:11434
          api_key = "OpenAI_API_KEY", -- optional: if your endpoint is authenticated
          chat_url = "/chat/completions", -- optional: default value, override if different
          tags_endpoint = "/v1/tags", -- optional: attaches to the end of the URL to form the endpoint to retrieve tags
          models_endpoint = "/models", -- optional: attaches to the end of the URL to form the endpoint to retrieve models
        },
        schema = {
          model = {
            -- default = "mistralai/devstral-small-2507",
            -- default = "gpt-oss:20b",  -- define llm model to be used
            -- default = "qwen/qwen3-8b"
            -- default = "openai/gpt-oss-20b"
            -- default = "lmstudio-community/gpt-oss-20b"
            -- default = "qwen/qwen3-coder-30b"
            -- default = "qwen/qwen3-14b"
            -- default = "qwen/qwen3-1.7b"
            default = "ibm/granite-4-h-tiny"
          },
          temperature = {
            order = 2,
            mapping = "parameters",
            type = "number",
            optional = true,
            default = 0.8,
            desc = "What sampling temperature to use, between 0 and 2. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic. We generally recommend altering this or top_p but not both.",
            validate = function(n)
              return n >= 0 and n <= 2, "Must be between 0 and 2"
            end,
          },
          max_completion_tokens = {
            order = 3,
            mapping = "parameters",
            type = "integer",
            optional = true,
            default = nil,
            desc = "An upper bound for the number of tokens that can be generated for a completion.",
            validate = function(n)
              return n > 0, "Must be greater than 0"
            end,
          },
          stop = {
            order = 4,
            mapping = "parameters",
            type = "string",
            optional = true,
            default = nil,
            desc = "Sets the stop sequences to use. When this pattern is encountered the LLM will stop generating text and return. Multiple stop patterns may be set by specifying multiple separate stop parameters in a modelfile.",
            validate = function(s)
              return s:len() > 0, "Cannot be an empty string"
            end,
          },
          logit_bias = {
            order = 5,
            mapping = "parameters",
            type = "map",
            optional = true,
            default = nil,
            desc = "Modify the likelihood of specified tokens appearing in the completion. Maps tokens (specified by their token ID) to an associated bias value from -100 to 100. Use https://platform.openai.com/tokenizer to find token IDs.",
            subtype_key = {
              type = "integer",
            },
            subtype = {
              type = "integer",
              validate = function(n)
                return n >= -100 and n <= 100, "Must be between -100 and 100"
              end,
            },
          },
        },
      })
    end,
  },
})
-- require("dap").adapters.python = function(cb, config)
  --if config.request == 'attach' then
  --  ---@diagnostic disable-next-line: undefined-field
  --  local port = (config.connect or config).port
  --  ---@diagnostic disable-next-line: undefined-field
  --  local host = (config.connect or config).host or '127.0.0.1'
  --  cb({
  --    type = 'server',
  --    port = assert(port, '`connect.port` is required for a python `attach` configuration'),
  --    host = host,
  --    options = {
  --      source_filetype = 'python',
  --    },
  --  })
  --else
    -- cb({
    --   type = 'executable',
    --   command = os.getenv("VIRTUAL_ENV") .. "/bin/python",
    --   args = { '-m', 'debugpy.adapter' },
    --   options = {
    --     source_filetype = 'python',
    --   },
    -- })
  -- end
-- end
-- require("dap-python").setup("uv")
--

-- filepath: ~/.config/nvim/lua/spec_goto.lua
local api = vim.api

local function goto_spec()
  local buf_path = api.nvim_buf_get_name(0)
  if buf_path == "" then return end

  -- Pattern: find root up to first dir after app/composites/
  local root, rest = buf_path:match("^(.-app/composites/[^/]+)(/.*)$")
  if not root then
    vim.notify("Not in a recognized source directory", vim.log.levels.ERROR)
    return
  end

  -- Insert /spec/ after root
  local spec_dir = root .. "/spec" .. rest

  -- Add _spec before .rb
  local spec_path = spec_dir:gsub("(.+)(%.rb)$", "%1_spec%2")

  -- Open or create the spec file
  if vim.fn.filereadable(spec_path) == 1 then
    vim.cmd("edit " .. spec_path)
  else
    -- Ensure parent directories exist
    vim.fn.mkdir(vim.fn.fnamemodify(spec_path, ":h"), "p")
    vim.cmd("edit " .. spec_path)
  end
end

-- Keymap: <leader>gt
vim.keymap.set("n", "<leader>gt", goto_spec, { desc = "Go to/create spec file for current buffer" })

-- filepath: ~/.config/nvim/lua/spec_goto.lua
-- ...existing code...

local function goto_code()
  local buf_path = api.nvim_buf_get_name(0)
  if buf_path == "" then return end

  -- Pattern: find root up to first dir after app/composites/
  local root, rest = buf_path:match("^(.-app/composites/[^/]+)(/spec/.*)$")
  if not root then
    vim.notify("Not in a recognized spec directory", vim.log.levels.ERROR)
    return
  end

  -- Remove /spec/ after root
  local code_dir = root .. rest:gsub("^/spec/", "/")

  -- Remove _spec before .rb
  local code_path = code_dir:gsub("(.+)_spec(%..+)$", "%1%2")

  -- Open or create the code file
  if vim.fn.filereadable(code_path) == 1 then
    vim.cmd("edit " .. code_path)
  else
    vim.fn.mkdir(vim.fn.fnamemodify(code_path, ":h"), "p")
    vim.cmd("edit " .. code_path)
  end
end

-- Keymap: <leader>gc
vim.keymap.set("n", "<leader>gc", goto_code, { desc = "Go to/create implementation file from spec" })
-- ...existing code...
-- Add this to your init.lua or a separate config file

-- Set up the keybinding to open current file in GitHub browser
vim.keymap.set('n', '<leader>gh', function()
  local file = vim.fn.expand('%')
  local line = vim.fn.line('.')
  local cmd = string.format('gh browse %s:%d', file, line)
  
  vim.fn.system(cmd)
  
  -- Optional: show a message
  vim.notify(string.format('Opening %s at line %d in browser', file, line), vim.log.levels.INFO)
end, { desc = 'Open file in GitHub browser at current line' })
-- vim.g.copilot_settings = { selectedCompletionModel = 'claude-haiku-4-5-20251001' }
-- Open GitHub PR in web browser
vim.keymap.set('n', '<leader>gpr', function()
  vim.fn.system('gh pr view --web')
end, { noremap = true, silent = true, desc = 'Open PR in browser' })
require('lspconfig').elixirls.setup({
  cmd = { vim.fn.stdpath("data") .. "/mason/bin/elixir-ls" },
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    -- Format on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
    })
  end,
  settings = {
    elixirLS = {
      dialyzerEnabled = true,
      fetchDeps = false,
      enableTestLenses = false,
      suggestSpecs = false,
    }
  }
})
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
})

-- local workflows = dofile('/Users/alekseiivanov/dotfiles/nvim/lua/codecompanion_workflows.lua')
-- workflows.setup()
-- require("codecompanion").add_workflows(workflows.workflows)
-- workflows.setup_keymaps()
