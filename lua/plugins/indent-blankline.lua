-- https://github.com/lukas-reineke/indent-blankline.nvim
local default_enabled = false
return {
  {
    'lukas-reineke/indent-blankline.nvim',
    lazy = not default_enabled,
    event = default_enabled and 'VeryLazy' or nil,
    main = "ibl",
    opts = {
      enabled = default_enabled,
      scope = {
        enabled = false,
      },
    },
    cmd = {
      'IBLEnable',
      'IBLDisable',
      'IBLToggle',
      'IBLEnableScope',
      'IBLDisableScope',
      'IBLToggleScope',
    },
    keys = {
      { '<leader>ti', '<cmd>IBLToggle<CR>', desc = '[T]oggle [I]ndent highlighting' },
    },
    config = function(_, opts)
      require('ibl').setup(opts);
      vim.keymap.set('n', '<leader>ti', '<cmd>IBLToggle<CR>', { desc = '[T]oggle [I]ndent highlighting' })
    end
  }
}

-- vim: sw=2 et
