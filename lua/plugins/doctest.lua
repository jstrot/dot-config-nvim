-- https://github.com/mtoohey31/doctest.nvim
return {
  {
    'mtoohey31/doctest.nvim',
    ft = {
      'python',
    },
    init = function()
      vim.g.doctest_verbose_string = 'Succeeded'
      vim.g.doctest_remove_pycache = 0
      vim.g.doctest_traceback_info = 0
    end,
  },
}

-- vim: sw=2 et
