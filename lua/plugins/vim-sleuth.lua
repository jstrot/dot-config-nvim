-- https://github.com/tpope/vim-sleuth
return {
  {
    'tpope/vim-sleuth',
    config = function()
      -- vim.g.sleuth_heuristics = 0  -- Disable all heuristics
      vim.g.sleuth_mail_heuristics = 0  -- Disable or enable per file type

      -- require('sleuth').setup()
    end

  }
}

-- vim: sw=2 et
