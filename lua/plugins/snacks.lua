-- https://github.com/folke/snacks.nvim
return {
  {
    'folke/snacks.nvim',
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
        enabled = false,
      },

      -- Delete buffers without disrupting window layout
      bufdelete = {
        -- library only
      },

      -- Beautiful declarative dashboards ‼️
      dashboard = {
        enabled = false,
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
        enabled = false,
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
        enabled = false,
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
        enabled = false,
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
    config = function(_, opts)
      require("snacks").setup(opts);

      vim.api.nvim_create_user_command('Dashboard', Snacks.dashboard.open, {})
    end,
  },
}

-- vim: sw=2 et
