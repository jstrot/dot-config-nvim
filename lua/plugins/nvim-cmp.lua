-- https://github.com/hrsh7th/nvim-cmp
return {
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'neovim/nvim-lspconfig',
      -- LSP completion sources:
      'hrsh7th/cmp-nvim-lsp',
      -- Useful completion sources:
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-path',
      -- 'hrsh7th/cmp-vsnip',
      -- 'hrsh7th/vim-vsnip',
      'saadparwaiz1/cmp_luasnip',
      "L3MON4D3/LuaSnip",
      'tzachar/cmp-ai',
    },
    event = 'InsertEnter',
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      luasnip.config.setup {}

      cmp.setup {
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            -- vim.fn["vsnip#anonymous"](args.body)        -- For `vsnip` users.
            luasnip.lsp_expand(args.body)                  -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body)         -- For `ultisnips` users.
            -- vim.snippet.expand(args.body)               -- For native neovim snippets (Neovim v0.10+)
          end,
        },
        completion = {
          completeopt = 'menu,menuone,noinsert',  -- Default: 'menu,menuone,noselect'
        },

        -- For an understanding of why these mappings were
        -- chosen, you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        mapping = cmp.mapping.preset.insert {
          -- Select the [n]ext item
          ['<C-n>'] = cmp.mapping.select_next_item(),
          -- Select the [p]revious item
          ['<C-p>'] = cmp.mapping.select_prev_item(),

          -- You may add tab support, if you don't use it for other purposes (e.g., Copilot)
          -- ['<Tab>'] = cmp.mapping.select_next_item(),
          -- ['<S-Tab>'] = cmp.mapping.select_prev_item(),

          -- Scroll the documentation window [b]ack / [f]orward
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),

          -- Accept ([y]es) the completion.
          --  This will auto-import if your LSP supports it.
          --  This will expand snippets if the LSP sent a snippet.
          ['<C-y>'] = cmp.mapping.confirm { select = true },

          -- If you prefer more traditional completion keymaps,
          -- you can uncomment the following lines
          -- ['<CR>'] = cmp.mapping.confirm { select = true }, -- Careful! Interferes with adding newlines!

          -- Manually trigger a completion from nvim-cmp.
          --  Generally you don't need this, because nvim-cmp will display
          --  completions whenever it has completion options available.
          ['<C-space>'] = cmp.mapping.complete {},

          -- Think of <c-l> as moving to the right of your snippet expansion.
          --  So if you have a snippet that's like:
          --  function $name($args)
          --    $body
          --  end
          --
          -- <c-l> will move you to the right of each of the expansion locations.
          -- <c-h> is similar, except moving you backwards.
          -- XXXJST TODO understand and document these mappings
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),

          -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
          --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
          -- ['<C-e>'] = cmp.mapping.close(),
          -- ['<C-e>'] = cmp.mapping.abort(),
        },
        sources = cmp.config.sources(
          -- Group 1
          {
            { name = 'path' },                              -- file paths
            { name = 'nvim_lsp', keyword_length = 3 },      -- from language server
            { name = 'nvim_lsp_signature_help'},            -- display function signatures with current parameter emphasized
            { name = 'nvim_lua', keyword_length = 2},       -- complete neovim's Lua runtime API such vim.lsp.*
            -- { name = 'vsnip', keyword_length = 2 },      -- For `vsnip` users.
            { name = 'luasnip' },                           -- For `luasnip` users.
            -- { name = 'ultisnips' },                      -- For `ultisnips` users.
            -- { name = 'snippy' },                         -- For `snippy` users.
            { name = 'calc'},                               -- source for math calculation
            { name = 'cmp_ai' },
          },
          -- Group 2
          {
            { name = 'buffer', keyword_length = 2 },        -- source current buffer
          }
        ),
        formatting = {
          expandable_indicator = true,
          fields = {'menu', 'abbr', 'kind'},
          format = function(entry, item)
            local menu_icon ={
              nvim_lsp = 'λ',
              vsnip = '⋗',
              buffer = 'Ω',
              path = '◇',
            }
            item.menu = menu_icon[entry.source.name]
            return item
          end,
        },

        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
      }
      -- Avoid extra ins-completion-menu messages
      vim.opt.shortmess:append 'c'
    end,
  },
}

-- vim: sw=2 et
