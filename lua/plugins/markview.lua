-- https://github.com/OXY2DEV/markview.nvim
return {
  'OXY2DEV/markview.nvim',
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function ()
    require("markview").setup();
    vim.keymap.set('n', '<leader>tm', '<CMD>Markview toggle<CR>', { desc = '[T]oggle [M]arkView' })
  end

}

-- vim: sw=2 et
