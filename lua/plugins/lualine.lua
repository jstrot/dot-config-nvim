-- https://github.com/nvim-lualine/lualine.nvim
return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    setup = function()
      require('lualine').setup {
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
      }
      -- NOTE: Same icons as lualine
      local signs = {
        Error = '󰅚 ', -- x000f015a
        Warn  = '󰀪 ', -- x000f002a
        Info  = '󰋽 ', -- x000f02fd
        Hint  = '󰌶 ', -- x000f0336
      }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end
    end,
  }
}

-- vim: sw=2 et
