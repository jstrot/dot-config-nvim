-- https://github.com/p00f/clangd_extensions.nvim
return {
  {
    'p00f/clangd_extensions.nvim',
    -- enabled = false,  -- FIXME: XXXJST can get offset_encoding to match!
    opts = {
      cmd = {
        'clangd',
        '--offset-encoding=utf-16',  -- Keep in sync with nvim-lspconfig.lua
        -- '--inlay-hints=true',
      },
    },
  },
}

-- vim: sw=2 et
