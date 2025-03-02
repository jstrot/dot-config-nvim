-- https://github.com/nvim-tree/nvim-web-devicons
-- TEST: Run `:NvimWebDeviconsHiTest` to see all icons and their highlighting.
return {
  {
    'nvim-tree/nvim-web-devicons',
    event = 'VeryLazy',
    enabled = vim.g.have_nerd_font,
  }
}

-- vim: sw=2 et
