-- https://github.com/OXY2DEV/markview.nvim
jst_md = require('jst.markdown')

-- Whether all list items should be rendered with extra padding on the left, like some editors (GitHub, Obsidian, ...)
local default_list_items_add_padding = false -- disable for a more compact view

return {
  'OXY2DEV/markview.nvim',
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  ft = jst_md.markdown_filetypes_per_plugin['markview'],
  opts = {
    code_blocks = {
      icons = "devicons",
    },

    preview = {
      enable = true, -- Start enabled or not, toggle with `<leader>tm`
      filetypes = jst_md.markdown_filetypes_per_plugin['markview'],
      ignore_buftypes = {
        -- Important to not ignore "nofile" buftypes for Avante and CodeCompanion
        (not vim.tbl_contains({'avante', 'codecompanion'}, vim.g.agentic_mode_plugin)) and "nofile" or nil,
      },
      icon_provider = "devicons", -- "internal", "mini", "devicons"
    },

    markdown = {
      list_items = {
        -- indent_size = 4, -- Defaults to initial `vim.b.shiftwidth`, make sure to use `vim-sleuth` to auto-detect per document
        shift_width = 2, -- Defaults to 4 but I prefer a more compact view
        marker_minus = {
          add_padding = default_list_items_add_padding, -- default is true
        },
        marker_plus = {
          add_padding = default_list_items_add_padding, -- default is true
        },
        marker_star = {
          add_padding = default_list_items_add_padding, -- default is true
        },
        marker_dot = {
          add_padding = default_list_items_add_padding, -- default is true
        },
        marker_parenthesis = {
          add_padding = default_list_items_add_padding, -- default is true
        },
      },
    },
  },
  config = function(_, opts)
    require("markview").setup(opts);

    -- See https://github.com/OXY2DEV/markview.nvim/issues/248#issuecomment-2603697869
    vim.api.nvim_create_autocmd('FileType', {
      desc = 'Disable `wrap` to improve Markview table rendering',
      pattern = {
        "markdown",
        "quarto",
        "rmd",
        -- Not "Avante"
        -- Not "codecompanion"
      },
      group = vim.api.nvim_create_augroup('Markview_wrap_disable', { clear = true }),
      callback = function (opts)
        vim.o.wrap = false
      end,
    })

    -- The default MarkviewCheckboxUnchecked mapping is that of an error state. Unchecked checkboxes are not errors, just in progress.
    vim.cmd([[ highlight! link MarkviewCheckboxUnchecked Normal ]])

  end

}

-- vim: sw=2 et
