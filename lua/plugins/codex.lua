-- https://github.com/johnseth97/codex.nvim
-- https://github.com/kkrampis/codex.nvim
require('jst.ai.config')
local jst = require('jst')

return {
  {
    "johnseth97/codex.nvim",
    -- "kkrampis/codex.nvim",
    lazy = true,
    cmd = {
      'Codex',
      'CodexToggle',
    },
    keys = {
      {
        '<leader>cC', -- Change this to your preferred keybinding
        function() require('codex').toggle() end,
        desc = '[Code]: Toggle [C]odex popup or side-panel',
        mode = { 'n', 't' }
      },
    },
    opts = {
      cmd = vim.g.codex_host_prog or 'codex',
      keymaps     = {
        toggle = nil, -- Disable internal default keymap in favor of the Lazyvim spec
        quit = '<C-q>', -- Keybind to close the Codex window (default: Ctrl + q)
        -- quit = 'q', -- Keybind to close the Codex window (default: Ctrl + q)
      },
      border      = 'rounded',  -- Options: 'single', 'double', or 'rounded'
      width       = 0.8,        -- Width of the floating window (0.0 to 1.0)
      height      = 0.8,        -- Height of the floating window (0.0 to 1.0)
      model       = nil,        -- Optional: pass a string to use a specific model (e.g., 'o3-mini')
      autoinstall = true,       -- Automatically install the Codex CLI if not found
      panel       = true,       -- Open Codex in a side-panel (vertical split) instead of floating window
      use_buffer  = false,      -- Capture Codex stdout into a normal buffer instead of a terminal buffer
    },
  },
}

-- vim: sw=2 et
