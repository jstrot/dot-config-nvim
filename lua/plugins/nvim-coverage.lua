-- https://github.com/andythigpen/nvim-coverage
-- https://github.com/strottie/nvim-coverage
local function ToggleCoverage()
  local signs = require('coverage.signs')
  if signs.is_enabled() then
    require('coverage').toggle()
  else
    require('coverage').load(true)
  end
end
return {
  {
    -- 'andythigpen/nvim-coverage',

    -- TODO: XXXJST Until corbertura support is fixed, use my fork:
    -- https://github.com/andythigpen/nvim-coverage/pull/44
    'https://github.com/strottie/nvim-coverage', branch = 'strottie-cpp-cobertura',

    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    opts = {
      lang = {
        cpp = {
          coverage_file = 'report.info',
        },
      },
      signs = {
        covered = { hl = 'CoverageCovered', text = '✔' },
        uncovered = { hl = 'CoverageUncovered', text = '✖' },
        partial = { hl = 'CoveragePartial', text = '◔' },
      },
    },

    config = function(_, opts)
      require('coverage').setup(opts)
      vim.keymap.set('n', '<leader>tc', ToggleCoverage, { desc = '[T]oggle [C]overage signs' })
    end,
  },
}

-- vim: sw=2 et
