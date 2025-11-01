-- https://github.com/echasnovski/mini.nvim
-- A collection of plugins by Evgeni Chasnovski
return {
  --[Use all the mini plugins]--

  -- { 'echasnovski/mini.nvim', version = '*' },

  --[Cherry-picking individual plugins]--

  -- https://github.com/echasnovski/mini.operators
  {
    'echasnovski/mini.operators',
    version = '*',
    enabled = false, -- Really annoying that it overrides a lot of default mappings
    event = 'VeryLazy',
    opts = {},
  },

  {
    'echasnovski/mini.diff',
    enabled = vim.g.auto_suggest_completion_plugin == 'codecompanion', -- Only using it to enhance CodeCompanion
    config = function()
      local diff = require("mini.diff")
      local opts = {
        -- Disabled by default
        source = diff.gen_source.none(),
      }
      diff.setup(opts)
    end,

  }
}

-- vim: sw=2 et
