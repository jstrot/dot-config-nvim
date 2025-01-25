-- https://github.com/OXY2DEV/markview.nvim
return {
  'OXY2DEV/markview.nvim',
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  ft = {
    "markdown",
    "quarto",
    "rmd",
  },
  opts = {
    code_blocks = {
      icons = "devicons",
    },
  },
  config = function(_, opts)
    require("markview").setup(opts);
    vim.keymap.set('n', '<leader>tm', '<CMD>Markview toggle<CR>', { desc = '[T]oggle [M]arkView' })

    -- See https://github.com/OXY2DEV/markview.nvim/issues/248#issuecomment-2603697869
    vim.api.nvim_create_autocmd('FileType', {
      desc = 'Disable `wrap` to improve Markview table rendering',
      pattern = { "markdown", "quarto", "rmd", },
      group = vim.api.nvim_create_augroup('Markview_wrap_disable', { clear = true }),
      callback = function (opts)
        vim.o.wrap = false
      end,
    })

  end

}

-- vim: sw=2 et
