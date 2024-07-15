-- https://github.com/hrsh7th/nvim-cmp
return {
  {
    'hrsh7th/nvim-cmp', -- Completion framework
    dependencies = {
      'neovim/nvim-lspconfig',
      -- LSP completion sources:
      'hrsh7th/cmp-nvim-lsp',
      -- Useful completion sources:
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-vsnip',
      'hrsh7th/vim-vsnip',
      -- 'tzachar/cmp-ai',
    },
    config = function()
      local cmp = require('cmp')
      local cmp_opts = {
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            -- vim.fn["vsnip#anonymous"](args.body)        -- For `vsnip` users.
            require('luasnip').lsp_expand(args.body)       -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body)         -- For `ultisnips` users.
            -- vim.snippet.expand(args.body)               -- For native neovim snippets (Neovim v0.10+)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-n>'] = cmp.mapping.select_next_item(),
          -- Add tab support
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),
          ['<Tab>'] = cmp.mapping.select_next_item(),
          ['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.close(),
          -- ['<C-e>'] = cmp.mapping.abort(),

          -- Interferes with newline!
          -- ['<CR>'] = cmp.mapping.confirm({
          --   behavior = cmp.ConfirmBehavior.Insert,
          --   select = true,
          -- }),

        }),
        formatting = {
          fields = {'menu', 'abbr', 'kind'},
          format = function(entry, item)
            local menu_icon ={
              nvim_lsp = 'λ',
              vsnip = '⋗',
              buffer = 'Ω',
              path = '🖫',
            }
            item.menu = menu_icon[entry.source.name]
            return item
          end,
        },
        sources = cmp.config.sources({
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
        }, {
          { name = 'buffer', keyword_length = 2 },        -- source current buffer
        })
      }
      cmp.setup(cmp_opts)
    end
  },
}
-- vim: sw=2 et
