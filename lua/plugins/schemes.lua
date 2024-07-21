-- Default priority is 50. It's recommended to set this to a high number for colorschemes.
return {
  {
    -- https://github.com/catppuccin/nvim
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    opts = {
      flavour = 'auto', -- auto, latte, frappe, macchiato, mocha
      dim_inactive = {
        -- enabled = true,
      },
    },
  },
  {
    -- https://github.com/LunarVim/Colorschemes
    'LunarVim/Colorschemes',
    name = 'LunarVim-Colorschemes',
    priority = 1000,
  },
}

-- vim: sw=2 et
