-- https://github.com/neovim/nvim-lspconfig

vim.g.format_lsp_timeout_ms = 5000
vim.g.format_lsp_async = false

-- Use a custom clang-format. Also see none-ls.lua
local use_custom_clang_format = (vim.g.clang_format_host_prog ~= nil)

local ruff_path = vim.env.VIRTUAL_ENV and vim.fn.exepath(vim.env.VIRTUAL_ENV .. '/bin/ruff')
if not ruff_path or ruff_path == '' then ruff_path = 'ruff' end

return {
  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    enabled = vim.fn.has('nvim-0.10.0') == 1,
    -- event = 'VeryLazy', -- Does not load on command-line files until `:e`
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      {
        'hrsh7th/cmp-nvim-lsp',
        enabled = vim.g.cmp_plugin == 'nvim-cmp',
      }
    },
    init = function()
      -- Not about nvim-lspconfig but this is where you'd expect to fit it:
      vim.diagnostic.config({
        float = {
          border = 'rounded',
        },
      })
    end,
    config = function()
      -- Brief aside: **What is LSP?**
      --
      -- LSP is an initialism you've probably heard, but might not understand what it is.
      --
      -- LSP stands for Language Server Protocol. It's a protocol that helps editors
      -- and language tooling communicate in a standardized fashion.
      --
      -- In general, you have a "server" which is some tool built to understand a particular
      -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
      -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
      -- processes that communicate with some "client" - in this case, Neovim!
      --
      -- LSP provides Neovim with features like:
      --  - Go to definition
      --  - Find references
      --  - Autocompletion
      --  - Symbol Search
      --  - and more!
      --
      -- Thus, Language Servers are external tools that must be installed separately from
      -- Neovim. This is where `mason` and related plugins come into play.
      --
      -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
      -- and elegantly composed help section, `:help lsp-vs-treesitter`

      local util = require('lspconfig.util')
      -- Lsp logs can get very big very fast!
      -- See ~/.local/state/nvim/lsp.log
      vim.lsp.set_log_level('off')
      -- vim.lsp.set_log_level('debug')

      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)

          -- NOTE: Remember that Lua is a real programming language, and as such it is possible
          -- to define small helper and utility functions so you don't have to repeat yourself.
          --
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(modes, lhs, rhs, opts)
            opts = opts or {}
            setmetatable(opts,{__index={
              buffer = event.buf,
            }})
            vim.keymap.set(modes, lhs, rhs, opts)
          end

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map('n', 'gd', function()
            if (vim.g.picker_plugin == 'snacks.picker') then
              require('snacks.picker').lsp_definitions()
            else
              require('telescope.builtin').lsp_definitions()
            end
          end, {desc='LSP: [G]oto [D]efinition'})

          -- Find references for the word under your cursor.
          map('n', '<leader>slr', function()
            if (vim.g.picker_plugin == 'snacks.picker') then
              require('snacks.picker').lsp_references()
            else
              require('telescope.builtin').lsp_references()
            end
          end, {desc='LSP: [S]earch [L]SP [R]eferences'})

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('n', '<leader>sli', function()
            if (vim.g.picker_plugin == 'snacks.picker') then
              require('snacks.picker').lsp_implementations()
            else
              require('telescope.builtin').lsp_implementations()
            end
          end, {desc='LSP: [S]earch [L]SP [I]mplementations'})

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('n', '<leader>D', function()
            if (vim.g.picker_plugin == 'snacks.picker') then
              require('snacks.picker').lsp_type_definitions()
            else
              require('telescope.builtin').lsp_type_definitions()
            end
          end , {desc='LSP: Type [D]efinition'})

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('n', '<leader>ds', function()
            if (vim.g.picker_plugin == 'snacks.picker') then
              require('snacks.picker').lsp_symbols()
            else
              require('telescope.builtin').lsp_document_symbols()
            end
          end, {desc='LSP: [D]ocument [S]ymbols'})

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map('n', '<leader>ws', function()
            if (vim.g.picker_plugin == 'snacks.picker') then
              require('snacks.picker').lsp_workspace_symbols()
            else
              require('telescope.builtin').lsp_dynamic_workspace_symbols()
            end
          end, {desc='LSP: [W]orkspace [S]ymbols'})

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('n', '<leader>rn', vim.lsp.buf.rename, {desc='LSP: [R]e[n]ame'})

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('n', '<leader>ca', vim.lsp.buf.code_action, {desc='LSP: [C]ode [A]ction'})

          -- Opens a popup that displays documentation about the word under your cursor
          --  See `:help K` for why this keymap.
          map('n', 'K', vim.lsp.buf.hover, {desc='LSP: Hover Documentation'})

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('n', 'gD', function()
            if (vim.g.picker_plugin == 'snacks.picker') then
              Snacks.picker.lsp_declarations()
            else
              vim.lsp.buf.declaration()
            end
          end , {desc='LSP: [G]oto [D]eclaration'})

          -- Opens a popup that displays documentation about the word under your cursor
          --  See `:help K` for why this keymap.
          map({'n', 'v'}, '<leader>fl',
            function ()
              vim.lsp.buf.format({
                timeout_ms = vim.g.format_lsp_timeout_ms or 1000,
                async = vim.g.format_lsp_async or false,
                filter = function (client)
                  if client.name == 'clangd' and use_custom_clang_format then
                    -- Don't let clangd use an old version of clang-format. Instead, let none-ls handle it, even though it's slower outside the LSP.
                    return false
                  else
                    return true
                  end
                end,
              })
            end, {desc='LSP: [F]ormat using [L]SP'})

          -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
          ---@param client vim.lsp.Client
          ---@param method vim.lsp.protocol.Method
          ---@param bufnr? integer some lsp support methods only in specific files
          ---@return boolean
          local function client_supports_method(client, method, bufnr)
            if vim.fn.has('nvim-0.11') == 1 then
              return client:supports_method(method, bufnr)
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- The following autocommand is used to enable inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            -- NOTE: The default mapping from kickstart.nvim is `<leader>th`
            -- but here's I'm using `<leader>tlh` to match the mappings from
            -- toggle-lsp-diagnostics.nvim.
            map('n', '<leader>tlh', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end, {desc='LSP: [T]oggle [L]SP diagnostics inlay [H]ints'})
          end

          local name = client and client.name
          if name == 'clangd' then
            local ok, clangd_extensions = pcall(require, 'clangd_extensions')
            if ok then
              pcall(clangd_extensions.setup_autocmd)
              pcall(clangd_extensions.set_inlay_hints)
            end
            if use_custom_clang_format then
              client.capabilities.textDocument.formatting = nil
              client.capabilities.textDocument.rangeFormatting = nil
            end
          end
          if name == 'ccls' then
            local ok, ccls = pcall(require, 'ccls')
          end

        end,
      })

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      if vim.g.cmp_plugin == 'blink.cmp' then
        capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities({}, false))
      elseif vim.g.cmp_plugin == 'nvim-cmp' then
        capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
      end

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {

        -- gopls = {},
        -- rust_analyzer = {},
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        --
        -- Some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- But for many setups, the LSP (`tsserver`) will work just fine
        -- tsserver = {},
        --

        --[[ Python ]]
        -- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/ruff.lua
        -- Ruff can be configured through a pyproject.toml, ruff.toml, or .ruff.toml file.
        -- See https://docs.astral.sh/ruff/configuration/
        ruff = {
          -- DEFAULT: cmd = { 'ruff', 'server' },
          -- OK: cmd = { '/home/jst/src/merryclaude-woo-manager/venv/bin/ruff', 'server' },
          -- WORKS to pick up the right ruff but it can't find venv-specific modules
          cmd = { ruff_path, 'server' },
          -- filetypes = { 'python' },
          on_attach = function (client, bufnr)
            -- Disable hover in favor of Pyright
            client.server_capabilities.hoverProvider = false
          end,
          settings = {
            -- configuration = "~/path/to/ruff.toml"
            -- configurationPreference = "filesystemFirst", -- "editorFirst" | "filesystemFirst" | "editorOnly"
            -- reportMatchNotExhaustive = true, -- NOTE: enable in pyright instead
          },
        },
        -- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/pyright.lua
        pyright = {
          settings = {
            pyright = {
              disableOrganizeImports = true, -- use ruff instead
              -- There's no way to suppress tagged hints and they are mostly duplicates of other diagnostics.
              -- See https://github.com/neovim/neovim/issues/30444
              disableTaggedHints = true,
            },
            python = {
              analysis = {
                ignore = { '*' }, -- use ruff instead
                -- typeCheckingMode = 'off', -- Using mypy
                -- reportMatchNotExhaustive = true,
              },
            },
          },
        },
        -- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/basedpyright
        -- https://detachhead.github.io/basedpyright
        -- basedpyright = {},

        -- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/clangd.lua
        clangd = {
          filetypes = { 'c', 'cpp', 'cc', },
          offset_encoding = 'utf-16',
          cmd = {
            -- See https://manpages.debian.org/experimental/clangd/clangd.1.en.html
            (vim.g.clangd_host_prog or 'clangd'),
            '--offset-encoding=utf-16',  -- Keep in sync with clangd_extensions.lua
            '--clang-tidy', -- Enable clang-tidy diagnostics: https://clang.llvm.org/extra/clang-tidy/
            '--fallback-style=none',
            '--suggest-missing-includes',
            '--inlay-hints=true',
          },
          root_dir = function(fname)
            return util.root_pattern(unpack({
              '.clangd',
              '.clang-tidy',
              '.clang-format',
              'compile_commands.json',
              'compile_flags.txt',
            }))(fname)
            -- or util.find_git_ancestor(fname)
          end,
        },

        -- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/lua_ls.lua
        lua_ls = {
          -- cmd = {...},
          -- filetypes = { ...},
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
              hint = {
                enable = true,
              },
              -- https://luals.github.io/wiki/formatter/
              format = {
                enable = true,
                -- Put format options here
                -- NOTE: the value should be STRING!!
                defaultConfig = {
                  indent_style = "space",
                  indent_size = "2",
                }
              },
              runtime = {
                -- Tell the language server which version of Lua you're using
                -- (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT'
              },
              workspace = {
                checkThirdParty = false,
                library = {
                  vim.env.VIMRUNTIME
                  -- Depending on the usage, you might want to add additional paths here.
                  -- "${3rd}/luv/library"
                  -- "${3rd}/busted/library",
                }
                -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                -- library = vim.api.nvim_get_runtime_file("", true)
              }
            },
          },
        },

        -- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/bashls.lua
        bashls = {
        },

        --[[ PHP ]]
        intelephense = {
          -- filetypes = { 'php' },
          settings = {
            intelephense = {
              -- Add wordpress to the list of stubs
              stubs = {
                -- [[ DEFAULTS ]]
                'apache',
                'bcmath',
                'bz2',
                'calendar',
                'com_dotnet',
                'Core',
                'ctype',
                'curl',
                'date',
                'dba',
                'dom',
                'enchant',
                'exif',
                'FFI',
                'fileinfo',
                'filter',
                'fpm',
                'ftp',
                'gd',
                'gettext',
                'gmp',
                'hash',
                'iconv',
                'imap',
                'intl',
                'json',
                'ldap',
                'libxml',
                'mbstring',
                'meta',
                'mysqli',
                'oci8',
                'odbc',
                'openssl',
                'pcntl',
                'pcre',
                'PDO',
                'pdo_ibm',
                'pdo_mysql',
                'pdo_pgsql',
                'pdo_sqlite',
                'pgsql',
                'Phar',
                'posix',
                'pspell',
                'readline',
                'Reflection',
                'session',
                'shmop',
                'SimpleXML',
                'snmp',
                'soap',
                'sockets',
                'sodium',
                'SPL',
                'sqlite3',
                'standard',
                'superglobals',
                'sysvmsg',
                'sysvsem',
                'sysvshm',
                'tidy',
                'tokenizer',
                'xml',
                'xmlreader',
                'xmlrpc',
                'xmlwriter',
                'xsl',
                'Zend OPcache',
                'zip',
                'zlib',
              },
              environment = {
                -- includePaths = '~/.config/composer/vendor/php-stubs', -- this line forces the composer path for the stubs in case intelephense don't find it...
              },
              files = {
                maxSize = 5000000,
              },
            },
          },
        },

        --[[ Markdown ]]
        -- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/marksman.lua
        marksman = {
        },

      }
      local servers_no_install = {
        -- TODO: XXXJST This is broken when using mason-tool-installer

        ccls = {
          -- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/ccls.lua
          lsp = {
            lspcopnfig = {
              filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'opencl' },
              root_dir = function(fname)
                return util.root_pattern(unpack({
                  -- prefer clangd: 'compile_commands.json',
                  '.ccls',
                }))(fname)
                -- or util.find_git_ancestor(fname)
              end,
            },
          },
        },

      }

      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
      })

      local ok, mason_lspconfig = pcall(require, 'mason-lspconfig')
      if ok then
        -- mason-tool-installer can only use "lspconfig" server names if 'mason-lspconfig' is available.
        require('mason-tool-installer').setup { ensure_installed = ensure_installed }
        mason_lspconfig.setup {
          handlers = {
            function(server_name)
              local server = servers[server_name] or servers_no_install[server_name] or {}
              -- This handles overriding only values explicitly passed
              -- by the server configuration above. Useful when disabling
              -- certain features of an LSP (for example, turning off formatting for tsserver)
              server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
              require('lspconfig')[server_name].setup(server)
            end,
          },
        }
      end

      vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
        pattern = { '/tmp/*', },
        callback = function ()
          vim.diagnostic.enable(false)
        end,
      })

    end,
  },
}

-- vim: sw=2 et
