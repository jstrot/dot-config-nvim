-- https://github.com/equalsraf/neovim-gui-shim
return {
  {
    'equalsraf/neovim-gui-shim',
    enabled = vim.fn.has('gui_running') == 1,
  }
}

-- vim: sw=2 et
