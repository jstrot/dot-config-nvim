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
}

-- vim: sw=2 et
