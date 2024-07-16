-- https://github.com/dhananjaylatkar/cscope_maps.nvim
return {
  {
    'dhananjaylatkar/cscope_maps.nvim',
    enabled = false, -- Nowadays, 
    -- Keymaps: https://github.com/dhananjaylatkar/cscope_maps.nvim?tab=readme-ov-file#default-keymaps
    prefix = '<leader>c',
    picker = 'telescope',  -- telescope, fzf-lua or quickfix
  }
}

-- vim: sw=2 et
