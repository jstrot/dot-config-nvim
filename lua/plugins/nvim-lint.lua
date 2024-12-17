-- https://github.com/mfussenegger/nvim-lint
return {
  {
    'mfussenegger/nvim-lint',
    -- This is complementary to mason. Configure linters by file type below and enable.
    enabled = false,
    event = 'VeryLazy',
    config = function()
      local lint = require('lint')
      lint.linters_by_ft = {
        -- markdown = {'vale',},
      }
    end,
  }
}

-- vim: sw=2 et
