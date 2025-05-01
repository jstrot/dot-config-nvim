-- https://docs.github.com/en/copilot/getting-started-with-github-copilot?tool=vimneovim
return {
  {
    "github/copilot.vim",

    -- FIXME: Lazy-loading doesn't seem to work for Copilot because it always
    -- requires the file to be re-loaded (`:e`) before getting attached.
    -- event = 'InsertEnter',
    -- cmd = {
    --   'Copilot',
    -- },

    init = function()

      --[[ Change the default key mapping (default is <Tab>) ]]
      -- vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
      --   expr = true,
      --   replace_keycodes = false
      -- })
      -- vim.g.copilot_no_tab_map = true

      vim.g.copilot_node_command = vim.g.node_host_prog or 'node'

      -- vim.g.copilot_filetypes = {
      --   c = true,
      --   markdown = true,
      --   python = true,
      -- }
      -- vim.g.copilot_filetypes['*'] = false

      -- vim.g.copilot_workspace_folders = {"~/Projects/myproject"}

    end,
  },
}

-- vim: sw=2 et
