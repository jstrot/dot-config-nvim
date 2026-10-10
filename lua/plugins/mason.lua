-- A list of servers to automatically install if they're not already installed.
---@type string[]
local jst_ts = require('jst.treesitter.config')

local lsp_ensure_installed = {
  'lua_ls',
}

local tools_ensure_installed = {
  jst_ts.ts_enabled and vim.fn.executable('tree-sitter') == 0 and "tree-sitter-cli" or nil,
}

return {
  -- https://github.com/mason-org/mason.nvim
  {
    'mason-org/mason.nvim',
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
  -- https://github.com/mason-org/mason-lspconfig.nvim
  -- Gives option to use lspconfig names instead of Mason names.
  {
    'mason-org/mason-lspconfig.nvim',
    enabled = vim.fn.has('nvim-0.11.0') == 1,
    dependencies = {
      'mason-org/mason.nvim',
      'neovim/nvim-lspconfig',
    },
    lazy = vim.tbl_isempty(lsp_ensure_installed),
    cmd = {
      'LspInstall',
      'LspUninstall',
    },
    opts = {
      ensure_installed = lsp_ensure_installed,

      -- Whether installed servers should automatically be enabled via `:h vim.lsp.enable()`.
      --
      -- To exclude certain servers from being automatically enabled:
      -- ```lua
      --   automatic_enable = {
      --     exclude = { "rust_analyzer", "ts_ls" }
      --   }
      -- ```
      --
      -- To only enable certain servers to be automatically enabled:
      -- ```lua
      --   automatic_enable = {
      --     "lua_ls",
      --     "vimls"
      --   }
      -- ```
      ---@type boolean | string[] | { exclude: string[] }
      automatic_enable = false,
    },
  },
  -- https://github.com/jay-babu/mason-null-ls.nvim
  -- Gives option to use none-ls/null-ls names instead of Mason names.
  -- {
  --   'jay-babu/mason-null-ls.nvim',
  --   enabled = vim.fn.has('nvim-0.10.0') == 1, -- Officially, 0.7.0
  --   dependencies = {
  --     'mason-org/mason.nvim',
  --   },
  --   lazy = true,
  --   cmd = {
  --     'NoneLsInstall',
  --     'NoneLsUninstall',
  --     'NullLsInstall',
  --     'NullLsUninstall',
  --   },
  --   opts = {
  --     -- Primary source of truth is none-ls
  --     ensure_installed = nil,
  --     automatic_installation = true,
  --   }
  -- },
  -- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    enabled = vim.fn.has('nvim-0.10.0') == 1, -- Not official
    lazy = vim.tbl_isempty(tools_ensure_installed),
    dependencies = {
      'mason-org/mason.nvim',
    },
    cmd = {
      'MasonToolsClean',
      'MasonToolsInstall',
      'MasonToolsInstallSync',
      'MasonToolsUpdate',
      'MasonToolsUpdateSync',
    },
    opts = {
      ensure_installed = tools_ensure_installed,
    },
  },
}

-- vim: sw=2 et
