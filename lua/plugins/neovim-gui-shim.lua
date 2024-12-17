-- https://github.com/equalsraf/neovim-gui-shim
return {
  {
    'equalsraf/neovim-gui-shim',
    enabled = true,
    lazy = vim.fn.has('gui_running') == 0,
  }
}

-- vim: sw=2 et
