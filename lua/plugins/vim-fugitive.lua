-- https://github.com/tpope/vim-fugitive
return {
  {
    "tpope/vim-fugitive",
    config = function()
      -- require('fugitive')  -- Auto-loading

      -- https://github.com/tpope/vim-fugitive/issues/1663
      vim.api.nvim_create_user_command('Gclogfunc', function()
        vim.cmd [[ execute '.Gclog -L :' . expand('<cword>') . ':%' ]]
      end, { bang = true, bar = true, })
      vim.api.nvim_create_user_command('Gllogfunc', function()
        vim.cmd [[ execute '.Gclog -L :' . expand('<cword>') . ':%' ]]
      end, { bang = true, bar = true, })

    end
  }
}

-- vim: sw=2 et
