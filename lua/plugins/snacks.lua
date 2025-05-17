-- https://github.com/folke/snacks.nvim
return {
  {
    'folke/snacks.nvim',
    event = 'VimEnter',
    init = function()

      -- This is an animation library, not actual animations. Disable if you encounter issues.
      vim.g.snacks_animate = true -- vim.b.snacks_animate = false locally for the buffer

    end,
    opts = {

      -- Efficient animations including over 45 easing functions (library)
      animate = {
        -- library only
        -- See vim.g.snacks_animate above
      },

      -- Deal with big files ‼️
      bigfile = {
        enabled = true,
        notify = true,
        size = 20 * 1024 * 1024,
        line_lenght = 1000,
      },

      -- Delete buffers without disrupting window layout
      bufdelete = {
        -- library only
      },

      -- Beautiful declarative dashboards ‼️
      dashboard = {
        enabled = true,

        sections = {
          { section = "header" },
          { pane = 2, section = "terminal", padding = 1,
            cmd = "fortune -s | cowsay",
            hl = "header",
            indent = 8,
            enabled = vim.fn.executable('fortune') == 1 and vim.fn.executable('cowsay') == 1,
          },
          { section = "keys", gap = 1, padding = 1, },
          { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
          { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
          {
            pane = 2, icon = " ", title = "Git Status", section = "terminal", indent = 3, padding = 1,
            enabled = function()
              return Snacks.git.get_root() ~= nil
            end,
            cmd = "git status --short --branch --renames",
            height = 5,
            ttl = 5 * 60,
          },
          { section = "startup" },
        },

        preset = {
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = "<leader>sf" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = "<leader>sg" },
            { icon = " ", key = "r", desc = "Recent Files", action = "<leader>sr" },
            { icon = " ", key = "c", desc = "Config", action = "<leader>sn" },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
      },

      -- Pretty inspect & backtraces for debugging
      debug = {
        -- library only
      },

      -- Focus on the active scope by dimming the rest
      dim = {
        enabled = false,
      },

      -- A file explorer (picker in disguise) ‼️
      explorer = {
        enabled = false,
        replace_netrw = false,
        -- `lua Snacks.explorer()`
      },

      -- Git utilities
      git = {
        -- library
      },

      -- Open the current file, branch, commit, or repo in a browser (e.g. GitHub, GitLab, Bitbucket)
      gitbrowse = {
        -- library
      },

      -- Image viewer using Kitty Graphics Protocol, supported by kitty, wezterm and ghostty ‼️
      image = {
        enabled = false, -- Limited functionality, using lua/plugins/images.lua for now
      },

      -- Indent guides and scopes
      indent = {
        enabled = false, -- Select default and use keymap to toggle
      },

      -- Better vim.ui.input ‼️
      input = {
        -- Enabled below with Snacks.input.enable()
      },

      -- Window layouts
      layout = {
        -- library
      },

      -- Open LazyGit in a float, auto-configure colorscheme and integration with Neovim
      lazygit = {
        -- `:lua Snacks.lazygit()`
        -- Needs `lazygit` installed
      },

      -- Pretty vim.notify ‼️
      notifier = {
        enabled = true,
        style = 'fancy', -- 'compact', 'minimal', 'fancy'
      },

      -- Utility functions to work with Neovim's vim.notify
      notify = {
        -- library
      },

      -- Picker for selecting items ‼️
      picker = {
        enabled = false, -- Using telescope for now
      },

      -- Neovim lua profiler
      profiler = {
        -- For script development or debugging. See docs: https://github.com/folke/snacks.nvim/blob/main/docs/profiler.md
      },

      -- When doing `nvim somefile.txt`, it will render the file as quickly as possible, before loading your plugins. ‼️
      quickfile = {
        enabled = true,
        -- any treesitter langs to exclude
        exclude = {
          "latex", -- Folke's default
        },
      },

      -- LSP-integrated file renaming with support for plugins like neo-tree.nvim and mini.files.
      rename = {
        -- library. See lua/plugins/oil.lua
      },

      -- Scope detection, text objects and jumping based on treesitter or indent ‼️
      scope = {
        enabled = true, -- Used by other snacks
        -- Tweak with https://github.com/folke/snacks.nvim/blob/main/docs/scope.md
      },

      -- Scratch buffers with a persistent file
      scratch = {
        -- library
      },

      -- Smooth scrolling ‼️
      scroll = {
        enabled = false, -- not recommended over ssh or slow connections
      },

      -- Pretty status column ‼️
      statuscolumn = {
        enabled = false, -- FIXME: Doesn't seem to do anything
      },

      -- Create and toggle floating/split terminals
      terminal = {
        -- library (mostly)
      },

      -- Toggle keymaps integrated with which-key icons / colors
      toggle = {
        -- library, with options to enhance.
        -- TODO: Find how to access the current toggle list/window
      },

      -- Utility functions for Snacks (library)
      util = {
        -- library
      },

      -- Create and manage floating windows or splits
      win = {
        -- library
      },

      -- Auto-show LSP references and quickly navigate between them ‼️
      words = {
        enabled = false, -- TODO:
      },

      -- Zen mode • distraction-free coding
      zen = {
        enabled = false,
      },

    },
    keys = {
      -- browse
      { '<leader>gB', function () Snacks.gitbrowse() end, desc = '[G]it [B]rowse repo online' },
      -- indent
      { '<leader>tih', function ()
        local snacks_indent = require('snacks.indent')
        if snacks_indent.enabled then
          snacks_indent.disable()
        else
          snacks_indent.enable()
        end
      end, desc = '[T]oggle [I]ndent [H]ighlighting' },
    },
    config = function(_, opts)
      require("snacks").setup(opts);

      -- dashboard
      vim.api.nvim_create_user_command('Dashboard', Snacks.dashboard.open, {})
    end,
  },
}

-- vim: sw=2 et
