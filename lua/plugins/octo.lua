-- https://github.com/pwntester/octo.nvim

return {
  {
    'pwntester/octo.nvim',
    opts = {
      picker = (
        (vim.g.picker_plugin == 'telescope') and 'telescope'
        or (vim.g.picker_plugin == 'fzf-lua') and 'fzf-lua'
        or (vim.g.picker_plugin == 'snacks.picker') and 'snacks'
        or 'telescope' -- fallback
      ),
      -- bare Octo command opens picker of commands
      enable_builtin = true,
      use_diagnostic_signs = true,

      gh_cmd = vim.g.gh_bin_path or 'gh',
      -- timeout = 20000, -- timeout (in ms) for requests with the remote server. Default is 5s.

    },
    cmd = "Octo",
    keys = {
      { "<leader>gh<cr>", "<CMD>Octo<CR>", desc = "[G]it[H]ub: Command list", },
      { "<leader>ghi", "<CMD>Octo issue list<CR>", desc = "[G]it[H]ub: [I]ssues", },
      { "<leader>ghp", "<CMD>Octo pr list<CR>", desc = "[G]it[H]ub: [P]ull requests", },
      { "<leader>ghd", "<CMD>Octo discussion list<CR>", desc = "[G]it[H]ub: [D]iscussions", },
      { "<leader>ghn", "<CMD>Octo notification list<CR>", desc = "[G]it[H]ub: [N]otifications", },
      { "<leader>ghs", function() require("octo.utils").create_base_search_command { include_current_repo = true } end, desc = "[G]it[H]ub: [S]earch repo", },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      (
        (vim.g.picker_plugin == 'telescope') and 'nvim-telescope/telescope.nvim' or
        (vim.g.picker_plugin == 'fzf-lua') and 'ibhagwan/fzf-lua' or
        (vim.g.picker_plugin == 'snacks.picker') and 'folke/snacks.nvim' or
        'nvim-telescope/telescope.nvim' -- fallback
      ),
      "nvim-tree/nvim-web-devicons",
    },
  },
}

-- vim: sw=2 et
