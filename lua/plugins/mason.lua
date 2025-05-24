return {
  -- https://github.com/williamboman/mason.nvim
  {
    'williamboman/mason.nvim',
    enabled = vim.fn.has('nvim-0.10.0') == 1,
    lazy = true,
    cmd = {
      'Mason',
      'MasonInstall',
      'MasonLog',
      'MasonUninstall',
      'MasonUninstallAll',
      'MasonUpdate',
    },
    opts = {
      ui = {
        icons = {
          package_installed = '',
          package_pending = '',
          package_uninstalled = '',
        },
      }
    }
  },
  -- https://github.com/williamboman/mason-lspconfig.nvim
  -- Gives option to use lspconfig names instead of Mason names.
  {
    'williamboman/mason-lspconfig.nvim',
    enabled = vim.fn.has('nvim-0.11.0') == 1,
    dependencies = {
      'williamboman/mason.nvim',
    },
    lazy = true,
    cmd = {
      'LspInstall',
      'LspUninstall',
    },
    opts = {
      -- Primary source of truth is nvim-lspconfig
      ensure_installed = nil,
      automatic_installation = true,
    },
  },
  -- https://github.com/jay-babu/mason-null-ls.nvim
  -- Gives option to use none-ls/null-ls names instead of Mason names.
  {
    'jay-babu/mason-null-ls.nvim',
    dependencies = {
      'williamboman/mason.nvim',
    },
    lazy = true,
    cmd = {
      'NoneLsInstall',
      'NoneLsUninstall',
      'NullLsInstall',
      'NullLsUninstall',
    },
    opts = {
      -- Primary source of truth is none-ls
      ensure_installed = nil,
      automatic_installation = true,
    }
  },
  -- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    lazy = true,
    cmd = {
      'MasonToolsClean',
      'MasonToolsInstall',
      'MasonToolsInstallSync',
      'MasonToolsUpdate',
      'MasonToolsUpdateSync',
    },
  },
}

-- vim: sw=2 et
