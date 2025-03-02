-- Default priority is 50. It's recommended to set this to a high number for colorschemes.
return {
  {
    -- https://github.com/catppuccin/nvim
    'catppuccin/nvim',
    -- enabled = false, -- This is the default, disable if you don't use it
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
    enabled = false, -- Enable if you with to use or test it
    name = 'LunarVim-Colorschemes',
    priority = 1000,
  },
  {
    -- https://github.com/folke/tokyonight.nvim
    "folke/tokyonight.nvim",
    enabled = false, -- Enable if you with to use or test it
    lazy = false,
    priority = 1000,
    opts = {},
  },
}

-- vim: sw=2 et
