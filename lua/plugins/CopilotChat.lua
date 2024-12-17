-- https://github.com/CopilotC-Nvim/CopilotChat.nvim
return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    event = 'VeryLazy',
    dependencies = {
      -- { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
      { "github/copilot.vim" },
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
    opts = {
      -- debug = true, -- Enable debugging
      -- See Configuration section for rest
      -- See Commands section for default commands if you want to lazy load on them

      -- debug = false, -- Enable debug logging
      -- proxy = nil, -- [protocol://]host[:port] Use this proxy
      -- allow_insecure = false, -- Allow insecure server connections

      -- system_prompt = prompts.COPILOT_INSTRUCTIONS, -- System prompt to use
      -- model = 'gpt-4', -- GPT model to use, 'gpt-3.5-turbo' or 'gpt-4'
      -- temperature = 0.1, -- GPT temperature

      -- question_header = '## User ', -- Header to use for user questions
      -- answer_header = '## Copilot ', -- Header to use for AI answers
      -- error_header = '## Error ', -- Header to use for errors
      -- separator = '───', -- Separator to use in chat

      -- show_folds = true, -- Shows folds for sections in chat
      -- show_help = true, -- Shows help message as virtual lines when waiting for user input
      -- auto_follow_cursor = true, -- Auto-follow cursor in chat
      -- auto_insert_mode = true, -- Automatically enter insert mode when opening window and if auto follow cursor is enabled on new prompt
      -- clear_chat_on_new_prompt = false, -- Clears chat on every new prompt
      -- highlight_selection = true, -- Highlight selection in the source buffer when in the chat window

      -- context = nil, -- Default context to use, 'buffers', 'buffer' or none (can be specified manually in prompt via @).
      -- history_path = vim.fn.stdpath('data') .. '/copilotchat_history', -- Default path to stored history
      -- callback = nil, -- Callback to use when ask response is received

      -- window = {
      -- layout = 'vertical', -- 'vertical', 'horizontal', 'float', 'replace'
      -- width = 0.5, -- fractional width of parent, or absolute width in columns when > 1
      -- height = 0.5, -- fractional height of parent, or absolute height in rows when > 1
      -- -- Options below only apply to floating windows
      -- relative = 'editor', -- 'editor', 'win', 'cursor', 'mouse'
      -- border = 'single', -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
      -- row = nil, -- row position of the window, default is centered
      -- col = nil, -- column position of the window, default is centered
      -- title = 'Copilot Chat', -- title of chat window
      -- footer = nil, -- footer of chat window
      -- zindex = 1, -- determines if window is on top or below other floating windows
      -- },
    },
    keys = {
      { "<leader>cc<cr>", "<cmd>CopilotChat<cr>",         mode = "n", desc = "Run [C]opilot [C]hat" },
      { "<leader>cc<cr>", "<cmd>'<,'>CopilotChat<cr>",    mode = "v", desc = "Run [C]opilot [C]hat" },
      { "<leader>ccf",    "<cmd>CopilotChatFix<cr>",      mode = "n", desc = "Run [C]opilot [C]hat [F]ix" },
      { "<leader>ccf",    "<cmd>'<,'>CopilotChatFix<cr>", mode = "v", desc = "Run [C]opilot [C]hat [F]ix" },
    },
  },
}

-- vim: sw=2 et
