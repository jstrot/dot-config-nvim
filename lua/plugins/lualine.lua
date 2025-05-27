-- https://github.com/nvim-lualine/lualine.nvim
return {
  {
    "nvim-lualine/lualine.nvim",
    event = 'VeryLazy',
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        -- https://github.com/nvim-lualine/lualine.nvim/blob/master/THEMES.md
        theme = 'auto',
      },
      sections = {
        lualine_a = {
          'mode',
        },
        lualine_b = {
          { 'filename', newfile_status = true, path = 1, }
        },
        lualine_c = {
          'branch',
          'diff',
          'diagnostics',
          'lsp_progress',
        },
        lualine_x = {
          'encoding',
          'fileformat',
          'filetype',
          'fancy_lsp_servers',
        },
        lualine_y = {
          'progress',
        },
        lualine_z = {
          'location',
        }
      },
    },
    config = function(_, opts)
      require('lualine').setup(opts)

      -- NOTE: Same icons as lualine:
      vim.diagnostic.config({
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ', -- x000f015a
            [vim.diagnostic.severity.WARN]  = '󰀪 ', -- x000f002a
            [vim.diagnostic.severity.INFO]  = '󰋽 ', -- x000f02fd
            [vim.diagnostic.severity.HINT]  = '󰌶 ', -- x000f0336
          },
          numhl = {
            [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
            [vim.diagnostic.severity.WARN]  = 'DiagnosticSignWarn',
            [vim.diagnostic.severity.INFO]  = 'DiagnosticSignInfo',
            [vim.diagnostic.severity.HINT]  = 'DiagnosticSignHint',
          },
        },
      })
    end,
  }
}

-- vim: sw=2 et
