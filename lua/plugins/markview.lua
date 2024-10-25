-- https://github.com/OXY2DEV/markview.nvim
return {
  'OXY2DEV/markview.nvim',
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    code_blocks = {
      icons = "devicons",
    },
  },
  config = function(_, opts)
    require("markview").setup(opts);
    vim.keymap.set('n', '<leader>tm', '<CMD>Markview toggle<CR>', { desc = '[T]oggle [M]arkView' })
  end

}

-- vim: sw=2 et
