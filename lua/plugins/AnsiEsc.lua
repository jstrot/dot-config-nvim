-- https://github.com/vim-scripts/AnsiEsc.vim
-- https://github.com/powerman/vim-plugin-AnsiEsc
return {
  {
    -- "vim-scripts/AnsiEsc.vim",
    "powerman/vim-plugin-AnsiEsc",
    cmd = {
      'AnsiEsc',
    },
    keys = {
      { '<leader>ta', '<cmd>AnsiEsc<cr>', desc = '[T]oggle [A]NSI escapes' },
    },
  },
}

-- vim: sw=2 et
