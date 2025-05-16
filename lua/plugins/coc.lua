-- https://github.com/neoclide/coc.nvim
return {
  {
    "neoclide/coc.nvim",
    enabled = vim.g.cmp_plugin == 'coc',
    event = 'InsertEnter',
    branch = "release",
  }
}

-- vim: sw=2 et
