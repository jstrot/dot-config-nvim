-- https://github.com/nvim-lualine/lualine.nvim
return {
  {
    "nvim-lualine/lualine.nvim",
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
  }
}

-- vim: sw=2 et
