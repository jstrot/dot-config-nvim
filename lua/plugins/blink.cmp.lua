-- https://github.com/Saghen/blink.cmp
return {
  {
    'Saghen/blink.cmp',
    enabled = vim.g.cmp_plugin == 'blink.cmp',
    version = '1.*',
    dependencies = {
      -- 'rafamadriz/friendly-snippets', -- optional: provides snippets for the snippet source
      'L3MON4D3/LuaSnip',
    },

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = { preset = 'default' },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      -- https://cmp.saghen.dev/configuration/reference.html#sources
      sources = {
        default = {
          'lsp',
          'path',
          'snippets',
          'buffer',
          -- 'cmdline',
          -- 'omni',
        },
      },

      -- https://cmp.saghen.dev/configuration/reference.html#snippets
      snippets = {
        preset = 'luasnip' -- 'default', 'luasnip', 'mini_snippets'
      },

      -- Enable or disable per file type:
      enabled = function()
        if vim.tbl_contains({
          -- 'markdown',
        }, vim.bo.filetype) then
          return false
        else
          return true
        end
      end,

      -- https://cmp.saghen.dev/configuration/reference.html#completion
      completion = {

        -- https://cmp.saghen.dev/configuration/reference.html#completion-menu
        menu = {

          -- https://cmp.saghen.dev/configuration/reference.html#completion-menu-draw
          draw = {
            columns = {
              { 'kind_icon', },
              { 'label', 'label_description', gap = 1 },
              { 'source_name', } -- non-default, an extra I like
            },
          },

        },

        -- https://cmp.saghen.dev/configuration/reference.html#completion
        documentation = {
          auto_show = true,

          auto_show_delay_ms = 200, -- default is 500ms
          update_delay_ms = 100,    -- default is 50ms
        },

        -- https://cmp.saghen.dev/configuration/reference.html#completion-ghost-text
        ghost_text = {
          -- enabled = true, -- Do not enable if other completion agents, like Copilot, use ghost text.
        },

      },

      -- Experimental! https://cmp.saghen.dev/configuration/reference.html#signature
      signature = {
        -- enabled = true,
      },

    },

    -- https://cmp.saghen.dev/configuration/reference.html#fuzzy
    fuzzy = { implementation = "prefer_rust_with_warning" },

    opts_extend = { "sources.default" }
  },
}

-- vim: sw=2 et
