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
      integrations = {
        blink_pairs = true,
        diffview = true,
        fzf = vim.g.picker_plugin == 'fzf-lua',
        -- gitsigns = true,
        gitsigns = {
          enabled = true,
          -- align with the transparent_background option by default
          transparent = false,
        },
        copilot_vim = vim.g.github_copilot_enabled and vim.g.auto_suggest_completion_plugin ~= 'copilot-lua',
        -- TODO: blink_indent = true, 'saghen/blink.indent'
        render_markdown = true,
        snacks = {
          enabled = vim.g.picker_plugin == 'snacks',
          indent_scope_color = "", -- catppuccin color (eg. `lavender`) Default: text
        },
        telescope = {
          enabled = vim.g.picker_plugin == 'telescope',
        },
        which_key = true,
      },
    },
    dependencies = {
      -- 'Saghen/blink.pairs', -- `blink_pairs` integration
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
