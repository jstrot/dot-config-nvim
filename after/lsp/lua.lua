-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/lua_ls.lua
return {
  -- cmd = {...},
  -- filetypes = { ...},
  -- capabilities = {},
  -- FIXME: Does not work (LspInfo shows lua_ls in single file mode). Trying to limit the number of inotify instances!
  -- root_dir = function(fname)
  --   require('lspconfig.util').root_pattern(unpack({
  --     '.luarc.json',
  --     '.luacheckrc',
  --     '.stylua.toml',
  --     'stylua.toml',
  --     'selene.toml',
  --     'init.lua',
  --     '.git',
  --   }))(fname)
  -- end,
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
}
