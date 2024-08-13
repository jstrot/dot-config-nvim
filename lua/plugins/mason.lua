return {
  -- https://github.com/williamboman/mason.nvim
  {
    'williamboman/mason.nvim',
    opts = {
      ui = {
        icons = {
          package_installed = "",
          package_pending = "",
          package_uninstalled = "",
        },
      }
    }
  },
  -- https://github.com/williamboman/mason-lspconfig.nvim
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
      'williamboman/mason.nvim',
    },
    opts = {
    }
  },
  -- https://github.com/jay-babu/mason-null-ls.nvim
  {
    'jay-babu/mason-null-ls.nvim',
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
    opts = {
      automatic_installation = true,
    }
  }
}
-- vim: sw=2 et
