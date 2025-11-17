-- https://github.com/zbirenbaum/copilot.lua
require('jst.ai.config')

if AI_is_copilot_active() and not vim.g.auto_suggest_completion_plugin then
  vim.g.auto_suggest_completion_plugin = 'copilot-lua'
end

return {
  {
    "zbirenbaum/copilot.lua",
    enabled = AI_is_copilot_enabled() and vim.g.auto_suggest_completion_plugin ~= 'copilot', -- Avoid plugin name conflict
    cond = vim.g.auto_suggest_completion_plugin == 'copilot-lua',
    priority = 45, -- default is 50, 45 is the preferred auto-suggest completion plugin, others are 40

    cmd = "Copilot",
    -- event = 'VeryLazy' | 'InsertEnter', -- Does not load on command-line files until `:e` ???
    -- event = { "BufReadPre", "BufNewFile" },
    event = "InsertEnter", -- as per the author's suggestion
    opts = {
      copilot_node_command = vim.g.node_host_prog or 'node',
      filetypes = {
        -- These are set to false by the plugin author
        yaml = true, -- defaults to false
        markdown = true, -- defaults to false
        help = false, -- defaults to false
        gitcommit = true, -- defaults to false
        gitrebase = false, -- defaults to false
        hgcommit = true, -- defaults to false
        svn = false, -- defaults to false
        cvs = false, -- defaults to false
        -- Customize or add more below.
        bigfile = false, -- Do not enable on large files
        ["."] = true, -- defaults to false
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        hide_during_completion = true,
        debounce = 75,
        trigger_on_accept = true,
        keymap = {
          -- Adjusted key mappings to match the Tim Pope's official Copilot plugin
          accept = "<Tab>",
          accept_word = "<M-right>",
          accept_line = "<M-C-Right>",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
      workspace_folders = {},
      copilot_model = AI_copilot_code_model(), -- Start typing `$` in `:CopilotChat` panel for the list of models
      logger = {
        file = vim.fn.stdpath("log") .. "/copilot-lua.log",
        file_log_level = vim.log.levels.DEBUG, -- vim.log.levels.OFF,
        print_log_level = vim.log.levels.WARN,
        trace_lsp = "verbose", -- "off", -- "off" | "messages" | "verbose"
        trace_lsp_progress = true, -- false,
        log_lsp_messages = true, -- false,
      },
    },
  }
}

-- vim: sw=2 et
