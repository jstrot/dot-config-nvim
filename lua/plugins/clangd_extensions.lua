-- https://github.com/p00f/clangd_extensions.nvim
return {
  {
    'p00f/clangd_extensions.nvim',
    lazy = true, -- Loaded by nvim-lspconfig
    opts = {
      cmd = {
        (vim.g.clangd_host_prog or 'clangd'),
        '--offset-encoding=utf-16',  -- Keep in sync with nvim-lspconfig.lua
        -- '--inlay-hints=true',
      },
    },
  },
}

-- vim: sw=2 et
