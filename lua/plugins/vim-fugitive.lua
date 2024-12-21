-- https://github.com/tpope/vim-fugitive
return {
  {
    "tpope/vim-fugitive",
    event = 'VeryLazy',
    config = function()
      -- require('fugitive')  -- Auto-loading

      -- https://github.com/tpope/vim-fugitive/issues/1663
      vim.api.nvim_create_user_command('Gclogfunc', function()
        vim.cmd [[ execute '.Gclog -L :' . expand('<cword>') . ':%' ]]
      end, { bang = true, bar = true, })
      vim.api.nvim_create_user_command('Gllogfunc', function()
        vim.cmd [[ execute '.Gclog -L :' . expand('<cword>') . ':%' ]]
      end, { bang = true, bar = true, })

      vim.keymap.set('n', '<leader>gd', '<cmd>Gvdiffsplit<CR>', { desc = '[G]it vim[D]iff file against the index' })
      vim.keymap.set('n', '<leader>gD', '<cmd>Gvdiffsplit HEAD~1<CR>', { desc = '[G]it vim[D]iff file against the last commit' })

      vim.keymap.set('n', '<leader>gc', '<cmd>Git commit<CR>', { desc = '[G]it [C]commit' })
      vim.keymap.set('n', '<leader>gS', '<cmd>Git stage %<CR>', { desc = '[G]it [S]tage buffer' })
      vim.keymap.set('n', '<leader>gR', '<cmd>Git reset %<CR>', { desc = '[G]it [R]eset buffer' })

    end
  }
}

-- vim: sw=2 et
