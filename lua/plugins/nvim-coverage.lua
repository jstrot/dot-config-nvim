-- https://github.com/andythigpen/nvim-coverage
-- https://github.com/strottie/nvim-coverage
return {
  {
    'andythigpen/nvim-coverage',
    -- 'https://github.com/strottie/nvim-coverage',
    -- dir = vim.env.HOME .. "/src/nvim-coverage",
    dev = true,
    dependencies = { 'nvim-lua/plenary.nvim' },
    rocks = { 'lua-xmlreader' },
    init = function()
      require('coverage').setup({
        lang = {
          cpp = {
            coverage_file = "report.info",
          },
        },
        signs = {
          covered = { hl = 'CoverageCovered', text = '✔' },
          uncovered = { hl = 'CoverageUncovered', text = '✖' },
          partial = { hl = 'CoveragePartial', text = '◔' },
        },
      })
    end,
  },
}

-- vim: sw=2 et
