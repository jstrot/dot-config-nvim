-- https://docs.github.com/en/copilot/getting-started-with-github-copilot?tool=vimneovim
-- https://github.com/github/copilot.vim
require('config.ai')

if vim.g.github_copilot_enabled and vim.g.github_copilot_active and not vim.g.auto_suggest_completion_plugin then
  vim.g.auto_suggest_completion_plugin = 'copilot'
end

return {
  {
    "github/copilot.vim",
    enabled = vim.g.github_copilot_enabled,
    cond = vim.g.auto_suggest_completion_plugin == 'copilot',
    priority = 45, -- default is 50, 45 is the preferred auto-suggest completion plugin, others are 40

    -- event = 'VeryLazy' | 'InsertEnter', -- Does not load on command-line files until `:e`
    event = { "BufReadPre", "BufNewFile" },
    init = function()

      --[[ Change the default key mapping (default is <Tab>) ]]
      -- vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
      --   expr = true,
      --   replace_keycodes = false
      -- })
      -- vim.g.copilot_no_tab_map = true

      vim.g.copilot_node_command = vim.g.node_host_prog or 'node'

      vim.g.copilot_filetypes = {
        bigfile = false, -- Do not enable on large files
        -- c = true,
        -- markdown = true,
        -- python = true,
      }
      vim.g.copilot_filetypes['*'] = true -- default

      -- vim.g.copilot_workspace_folders = {"~/Projects/myproject"}

    end,
    cmd = {
      'Copilot',
    },
  },
}

-- vim: sw=2 et
