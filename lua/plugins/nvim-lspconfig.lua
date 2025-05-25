-- https://github.com/neovim/nvim-lspconfig

return {
  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    enabled = vim.fn.has('nvim-0.10.0') == 1,
  },
}

-- vim: sw=2 et
