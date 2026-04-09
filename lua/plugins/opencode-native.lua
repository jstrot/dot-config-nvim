-- https://github.com/sudo-tee/opencode.nvim
--
-- Your OpenCode configuration here: ~/.config/opencode/opencode.jsonc
--
require('jst.ai.config')

-- OpenCode in a native Neovim window will be affected by Neovim reload prompts.
-- Enabling autoread is optional but recommended to avoid agent errors.
local autoread = true -- Disable if you find this annoying

return {
  {
    "sudo-tee/opencode.nvim",
    name = 'opencode-native', -- To distinguish from NickvanDyke/opencode.nvim
    enabled = vim.g.agentic_mode_plugin == 'opencode-native',
    event = 'VeryLazy',
    opts = {
      preferred_picker = (
        vim.g.picker_plugin == 'fzf-lua' and "fzf"
        or vim.g.picker_plugin == 'telescope' and "telescope"
        or vim.g.picker_plugin == 'snacks.picker' and "snacks"
        or vim.g.picker_plugin == "mini.pick" and "mini.pick"
        or "select"),
      preferred_completion = (
        vim.g.cmp_plugin == 'blink.cmp' and 'blink'
        or vim.g.cmp_plugin == 'nvim-cmp' and 'nvim-cmp'
        or "vim_complete"),
      -- default_mode = 'build', -- 'build' or 'plan' or any custom configured. @see [OpenCode Agents](https://opencode.ai/docs/modes/)

      default_global_keymaps = false,
      keymap = {
        editor = {
          -- ['<leader>aI'] = false,
          -- ['<leader>a/'] = false,
          ['<leader>a<cr>'] = { 'quick_chat', desc = 'AI/[A]gentic/OpenCode: select [A]gent', mode = { 'n', 'x' } }, -- Open quick chat input with selection context in visual mode or current line context in normal mode
          ['<leader>aA'] = { 'select_agent', desc = 'AI/[A]gentic/OpenCode: select [A]gent' },
          ['<leader>aC'] = { function() vim.api.nvim_command('edit ~/.config/opencode/opencode.jsonc') end, desc = 'AI/[A]gentic/OpenCode: edit OpenCode [C]onfig' },
          ['<leader>aR'] = { 'rename_session', desc = 'AI/[A]gentic/OpenCode: [R]ename OpenCode session', mode = 'n' }, -- Rename current session
          ['<leader>aT'] = { 'timeline', desc = 'AI/[A]gentic/OpenCode: [T]imeline picker', mode = 'n' }, -- Display timeline picker to navigate/undo/redo/fork messages
          ['<leader>a[d'] = { 'diff_prev', desc = 'AI/[A]gentic/OpenCode: previous diff', mode = 'n' }, -- Navigate to previous file diff
          ['<leader>a]d'] = { 'diff_next', desc = 'AI/[A]gentic/OpenCode: next diff', mode = 'n' }, -- Navigate to next file diff
          ['<leader>ac'] = { 'diff_close', desc = 'AI/[A]gentic/OpenCode: [C]lose diff view', mode = 'n' }, -- Close diff view tab and return to normal editing
          ['<leader>ad'] = { 'diff_open', desc = 'AI/[A]gentic/OpenCode: open [D]iff view', mode = 'n' }, -- Opens a diff tab of a modified file since the last OpenCode prompt
          ['<leader>af'] = { 'toggle_focus', desc = 'AI/[A]gentic/OpenCode: [F]ocus OpenCode/last window', mode = 'n' }, -- Toggle focus between OpenCode and last window
          -- ['<leader>ag'] = false,
          ['<leader>ai'] = { 'open_input', desc = 'AI/[A]gentic/OpenCode: open [I]nput window', mode = 'n' }, -- Opens and focuses on input window on insert mode
          ['<leader>am'] = { 'configure_provider', desc = 'AI/[A]gentic/OpenCode: configure provider/[M]odel', mode = 'n' }, -- Quick provider and model switch from predefined list
          ['<leader>aM'] = { 'mcp', desc = 'AI/[A]gentic/OpenCode: configure [M]CP servers', mode = 'n' }, -- MCP picker and with toggle option
          ['<leader>an'] = { 'open_input_new_session', desc = 'AI/[A]gentic/OpenCode: [N]ew OpenCode session', mode = 'n' }, -- Opens and focuses on input window on insert mode. Creates a new session
          ['<leader>ao'] = { 'open_output', desc = 'AI/[A]gentic/OpenCode: open [O]utput window', mode = 'n' }, -- Opens and focuses on output window
          -- ['<leader>ap'] = false,
          ['<leader>apA'] = { 'permission_accept_all', desc = 'AI/[A]gentic/OpenCode: [P]ermission [A]ccept all', mode = 'n' }, -- Accept all (for current tool)
          ['<leader>apa'] = { 'permission_accept', desc = 'AI/[A]gentic/OpenCode: [P]ermission [A]ccept once', mode = 'n' }, -- Accept permission request once
          ['<leader>apd'] = { 'permission_deny', desc = 'AI/[A]gentic/OpenCode: [P]ermission [D]eny', mode = 'n' }, -- Deny permission request once
          ['<leader>aq'] = { 'close', desc = 'AI/[A]gentic/OpenCode: [Q]uit/close OpenCode', mode = 'n' }, -- Close UI windows
          ['<leader>arA'] = { 'diff_revert_all', desc = 'AI/[A]gentic/OpenCode: [R]evert [A]ll changes from session', mode = 'n' }, -- Revert all file changes since the last OpenCode session
          ['<leader>arR'] = { 'diff_restore_snapshot_all', desc = 'AI/[A]gentic/OpenCode: [R]estore snapshot [A]ll files', mode = 'n' }, -- Restore all files to a restore point
          ['<leader>arT'] = { 'diff_revert_this', desc = 'AI/[A]gentic/OpenCode: [R]evert [T]his file from session', mode = 'n' }, -- Revert current file changes since the last OpenCode session
          ['<leader>ara'] = { 'diff_revert_all_last_prompt', desc = 'AI/[A]gentic/OpenCode: [R]evert [A]ll changes from last prompt', mode = 'n' }, -- Revert all file changes since the last OpenCode prompt
          ['<leader>arr'] = { 'diff_restore_snapshot_file', desc = 'AI/[A]gentic/OpenCode: [R]estore snapshot [F]ile', mode = 'n' }, -- Restore a file to a restore point
          ['<leader>art'] = { 'diff_revert_this_last_prompt', desc = 'AI/[A]gentic/OpenCode: [R]evert [T]his file from last prompt', mode = 'n' }, -- Revert current file changes since the last OpenCode prompt
          ['<leader>as'] = { 'select_session', desc = 'AI/[A]gentic/OpenCode: [S]elect OpenCode session', mode = 'n' }, -- Select and load a OpenCode session
          ['<leader>at'] = { 'toggle', desc = 'AI/[A]gentic/OpenCode: [T]oggle OpenCode', mode = 'n' }, -- Open OpenCode. Close if opened
          ['<leader>av'] = { 'configure_variant', desc = 'AI/[A]gentic/OpenCode: configure model [V]ariant', mode = 'n' }, -- Switch model variant for the current model
          ['<leader>aV'] = { 'paste_image', desc = 'AI/[A]gentic/OpenCode: paste image from clipboard', mode = 'n' }, -- Paste image from clipboard into current session
          ['<leader>ax'] = { 'swap_position', desc = 'AI/[A]gentic/OpenCode: e[X]change pane position', mode = 'n' }, -- Swap OpenCode pane left/right
          ['<leader>ay'] = { 'add_visual_selection', desc = 'AI/[A]gentic/OpenCode: insert/[Y]ank visual selection as code block', mode = 'v' }, -- Insert visual selection as code block in the input buffer
          ['<leader>aY'] = { 'add_visual_selection_inline', desc = 'AI/[A]gentic/OpenCode: insert/[Y]ank visual selection as inline code block', mode = 'v' }, -- Insert visual selection as inline code block in the input buffer
          ['<leader>az'] = { 'toggle_zoom', desc = 'AI/[A]gentic/OpenCode: [Z]oom OpenCode windows', mode = 'n' }, -- Zoom in/out on the OpenCode windows
        },
        input_window = {
          ['#'] = { 'context_items', desc = 'Manage context items', mode = 'i' }, -- Manage context items (current file, selection, diagnostics, mentioned files)
          ['/'] = { 'slash_commands', desc = 'Slash commands', mode = 'i' }, -- Pick a command to run in the input window
          ['<C-c>'] = { 'cancel', desc = 'Cancel OpenCode request', mode = 'n' }, -- Cancel OpenCode request while it is running
          ['<C-d>'] = { 'close', desc = 'Close OpenCode windows', mode = 'n' }, -- Close UI windows
          ['<C-i>'] = { 'focus_input', desc = 'Focus input window', mode = { 'n', 'i' } }, -- Focus on input window and enter insert mode at the end of the input from the output window
          ['<cr>'] = { 'submit_input_prompt', desc = 'Submit prompt', mode = 'n' }, -- Submit prompt (normal mode and insert mode)
          ['<C-s>'] = { 'submit_input_prompt', desc = 'Submit prompt', mode = { 'n', 'i' } }, -- Submit prompt (normal mode and insert mode)
          ['<M-m>'] = { 'switch_mode', desc = 'Switch mode (build/plan)', mode = 'n' }, -- Switch between modes (build/plan)
          ['<M-v>'] = { 'paste_image', mode = 'i' }, -- Paste image from clipboard as attachment
          ['<S-tab>'] = { 'toggle_pane', desc = 'Toggle input/output pane', mode = { 'n', 'i' } }, -- Toggle between input and output panes
          ['<down>'] = { 'next_prompt_history', desc = 'Next prompt in history', mode = { 'n', 'i' } }, -- Navigate to next prompt in history
          ['<esc>'] = false,
          ['<leader>at<cr>'] = { 'toggle', desc = 'AI/[A]gentic/OpenCode: [T]oggle OpenCode', mode = 'n' },
          ['<leader>att'] = { 'toggle_tool_output', desc = 'AI/[A]gentic/OpenCode: [T]oggle [T]ool Output', mode = 'n' },
          ['<leader>atr'] = { 'toggle_reasoning_output', desc = 'AI/[A]gentic/OpenCode: [T]oggle [R]easoning Output', mode = 'n' },
          ['<leader>av'] = { 'paste_image', desc = 'Paste image from clipboard', mode = 'i' }, -- Paste image from clipboard as attachment
          ['<tab>'] = false,
          ['<up>'] = { 'prev_prompt_history', desc = 'Previous prompt in history', mode = { 'n', 'i' } }, -- Navigate to previous prompt in history
          ['@'] = { 'mention', desc = 'Insert mention', mode = 'i' }, -- Insert mention (file/agent)
          ['~'] = { 'mention_file', desc = 'Mention file', mode = 'i' }, -- Pick a file and add to context. See File Mentions section
        },
        output_window = {
          ['<C-c>'] = { 'cancel', desc = 'Cancel OpenCode request', mode = 'n' }, -- Cancel OpenCode request while it is running
          ['<C-d>'] = { 'close', desc = 'Close OpenCode windows', mode = 'n' }, -- Close UI windows
          ['<C-i>'] = { 'focus_input', desc = 'Focus input window', mode = 'n' }, -- Focus on input window and enter insert mode at the end of the input from the output window
          ['<S-tab>'] = { 'toggle_pane', desc = 'Toggle input/output pane', mode = { 'n', 'i' } }, -- Toggle between input and output panes
          ['<esc>'] = false,
          ['<leader>aD'] = false,
          ['<leader>aDm'] = { 'debug_message', desc = 'AI/[A]gentic/OpenCode: [D]ebug [M]essage', mode = 'n' }, -- Open raw message in new buffer for debugging
          ['<leader>aDo'] = { 'debug_output', desc = 'AI/[A]gentic/OpenCode: [D]ebug [O]utput', mode = 'n' }, -- Open raw output in new buffer for debugging
          ['<leader>aDs'] = { 'debug_session', desc = 'AI/[A]gentic/OpenCode: [D]ebug [S]ession', mode = 'n' }, -- Open raw session in new buffer for debugging
          ['<leader>aO'] = false,
          ['<leader>aS'] = { 'select_child_session', desc = 'AI/[A]gentic/OpenCode: [S]elect child session', mode = 'n' }, -- Select and load a child session
          ['<leader>at'] = false,
          ['<leader>at<cr>'] = { 'toggle', desc = 'AI/[A]gentic/OpenCode: [T]oggle OpenCode', mode = 'n' },
          ['<leader>att'] = { 'toggle_tool_output', desc = 'AI/[A]gentic/OpenCode: [T]oggle [T]ool Output', mode = 'n' },
          ['<leader>atr'] = { 'toggle_reasoning_output', desc = 'AI/[A]gentic/OpenCode: [T]oggle [R]easoning Output', mode = 'n' },
          ['<leader>oD'] = false,
          ['<leader>oO'] = false,
          ['<leader>oS'] = false,
          ['<leader>ods'] = false,
          ['<tab>'] = false,
          ['[['] = { 'prev_message', desc = 'Previous message in conversation', mode = 'n' }, -- Navigate to previous message in the conversation
          [']]'] = { 'next_message', desc = 'Next message in conversation', mode = 'n' }, -- Navigate to next message in the conversation
          ['i'] = false,
        },
        permission = {
          accept = 'a', -- Accept permission request once (only available when there is a pending permission request)
          accept_all = 'A', -- Accept all (for current tool) permission request once (only available when there is a pending permission request)
          deny = 'd', -- Deny permission request once (only available when there is a pending permission request)
        },
        session_picker = {
          rename_session = { '<C-r>' }, -- Rename selected session in the session picker
          delete_session = { '<C-d>' }, -- Delete selected session in the session picker
          new_session = { '<C-n>' }, -- Create and switch to a new session in the session picker
        },
        timeline_picker = {
          undo = { '<C-u>', mode = { 'i', 'n' } }, -- Undo to selected message in timeline picker
          fork = { '<C-f>', mode = { 'i', 'n' } }, -- Fork from selected message in timeline picker
        },
        history_picker = {
          delete_entry = { '<C-d>', mode = { 'i', 'n' } }, -- Delete selected entry in the history picker
          clear_all = { '<C-X>', mode = { 'i', 'n' } }, -- Clear all entries in the history picker
        },
        model_picker = {
          toggle_favorite = { '<C-f>', mode = { 'i', 'n' } },
        },
        mcp_picker = {
          toggle_connection = { '<C-t>', mode = { 'i', 'n' } }, -- Toggle MCP server connection in the MCP picker
        },
      },

      ui = {
        -- position = 'right', -- 'right' (default) or 'left'. Position of the UI split
        -- input_position = 'bottom', -- 'bottom' (default) or 'top'. Position of the input window
        -- window_width = 0.40, -- Width as percentage of editor width
        -- zoom_width = 0.8, -- Zoom width as percentage of editor width
        zoom_width = 1.0, -- Zoom width as percentage of editor width
        -- input_height = 0.15, -- Input height as percentage of window height
        -- display_model = true, -- Display model name on top winbar
        -- display_context_size = true, -- Display context size in the footer
        -- display_cost = true, -- Display cost in the footer
        -- window_highlight = 'Normal:OpencodeBackground,FloatBorder:OpencodeBorder', -- Highlight group for the OpenCode window
        -- icons = {
        --   preset = 'nerdfonts', -- 'nerdfonts' | 'text'. Choose UI icon style (default: 'nerdfonts')
        --   overrides = {}, -- Optional per-key overrides, see section below
        -- },
        -- output = {
        --   tools = {
        --     show_output = true, -- Show tools output [diffs, cmd output, etc.] (default: true)
        --   },
        --   rendering = {
        --     markdown_debounce_ms = 250, -- Debounce time for markdown rendering on new data (default: 250ms)
        --     on_data_rendered = nil, -- Called when new data is rendered; set to false to disable default RenderMarkdown/Markview behavior
        --   },
        -- },
        input = {
          text = {
            wrap = true, -- Wraps text inside input window
          },
        },
        -- completion = {
        --   file_sources = {
        --     enabled = true,
        --     preferred_cli_tool = 'server', -- 'fd','fdfind','rg','git','server' if nil, it will use the best available tool, 'server' uses OpenCode cli to get file list (works cross platform) and supports folders
        --     ignore_patterns = {
        --       '^%.git/',
        --       '^%.svn/',
        --       '^%.hg/',
        --       'node_modules/',
        --       '%.pyc$',
        --       '%.o$',
        --       '%.obj$',
        --       '%.exe$',
        --       '%.dll$',
        --       '%.so$',
        --       '%.dylib$',
        --       '%.class$',
        --       '%.jar$',
        --       '%.war$',
        --       '%.ear$',
        --       'target/',
        --       'build/',
        --       'dist/',
        --       'out/',
        --       'deps/',
        --       '%.tmp$',
        --       '%.temp$',
        --       '%.log$',
        --       '%.cache$',
        --     },
        --     max_files = 10,
        --     max_display_length = 50, -- Maximum length for file path display in completion, truncates from left with "..."
        --   },
        -- },
      },
      -- context = {
      --   enabled = true, -- Enable automatic context capturing
      --   cursor_data = {
      --     enabled = false, -- Include cursor position and line content in the context
      --   },
      --   diagnostics = {
      --     info = false, -- Include diagnostics info in the context (default to false
      --     warn = true, -- Include diagnostics warnings in the context
      --     error = true, -- Include diagnostics errors in the context
      --   },
      --   current_file = {
      --     enabled = true, -- Include current file path and content in the context
      --   },
      --   selection = {
      --     enabled = true, -- Include selected text in the context
      --   },
      -- },
      -- debug = {
      --   enabled = false, -- Enable debug messages in the output window
      -- },
      -- prompt_guard = nil, -- Optional function that returns boolean to control when prompts can be sent (see Prompt Guard section)

      -- User Hooks for custom behavior at certain events
      -- hooks = {
      --   on_file_edited = nil, -- Called after a file is edited by OpenCode.
      --   on_session_loaded = nil, -- Called after a session is loaded.
      --   on_done_thinking = nil, -- Called when OpenCode finishes thinking (all jobs complete).
      --   on_permission_requested = nil, -- Called when a permission request is issued.
      -- },

    },
    config = function(_, opts)

      require("opencode").setup(opts)
      if false then -- FIXME: Causes 'Error fetching Opencode providers: "No server base url"'
        local model = AI_copilot_agent_model()
        if model then
          require('opencode.state').current_model = 'github-copilot/' .. model
        end
      end

      if autoread then
        vim.o.autoread = true
      end

    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- 'OXY2DEV/markview.nvim', -- or "MeanderingProgrammer/render-markdown.nvim" -- Let plugin load based on filetype
      (
        vim.g.cmp_plugin == 'blink.cmp' and 'Saghen/blink.cmp'
        or vim.g.cmp_plugin == 'nvim-cmp' and 'hrsh7th/nvim-cmp'
        or {}),
      (
        vim.g.picker_plugin == 'fzf-lua' and "ibhagwan/fzf-lua"
        or vim.g.picker_plugin == 'telescope' and "nvim-telescope/telescope.nvim"
        or vim.g.picker_plugin == 'snacks.picker' and "folke/snacks.nvim"
        or vim.g.picker_plugin == 'mini.pick' and "nvim_mini/mini.nvim"
        or {}),
    },

  }
}

-- vim: sw=2 et
