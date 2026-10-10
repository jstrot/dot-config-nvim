-- https://github.com/gh-tui-tools/gh-review.nvim
pcall(require, 'config.github')

return {
  {
    'gh-tui-tools/gh-review.nvim',
    enabled = vim.g.github_plugin == 'gh-review',
    cmd = "GHReview",
    keys = {
      { "<leader>gh<cr>", "<CMD>GHReview<CR>", desc = "[G]it[H]ub: Open PR (auto-detect)", },
    },
    opts = {
      fold = { enabled = true, level = 0 },
      keymaps = {
        diff = {
          thread_open  = "gt",
          comment      = "<leader>ghc",
          suggestion   = "<leader>ghs",
          next_thread  = "]t",
          prev_thread  = "[t",
          preview      = "K",
          toggle_files = "<leader>tghf",
          goto_file    = "gF",
          close        = "q",
        },
        files = {
          open          = "<CR>",
          toggle_viewed = "<Space>",
          refresh       = "R",
          toggle_files  = "<leader>tghf",
          close         = "q",
        },
        thread = {
          submit       = "<C-s>",
          resolve      = "<C-r>",
          close        = "q",
          close_insert = "<C-q>",
        },
      },
    },
  },
}

-- vim: sw=2 et
