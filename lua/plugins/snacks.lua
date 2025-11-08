-- https://github.com/folke/snacks.nvim

-- Control whether snacks.dashboard is enabled on startup.
-- Can be overridden on the command line with `nvim --cmd 'lua vim.g.snacks_dashboard_enabled = false'`
-- Either way, use `:Dashboard` to open it instead or again later.
if vim.g.snacks_dashboard_enabled == nil then
  vim.g.snacks_dashboard_enabled = true
end

local keys = {
  -- browse
  { '<leader>gB', function () Snacks.gitbrowse() end, desc = '[G]it [B]rowse repo online' },
  -- explorer
  { '<leader>te', function() Snacks.explorer() end, desc = '[T]oggle [E]xplorer' },
  -- indent
  { '<leader>tih', function ()
    local snacks_indent = require('snacks.indent')
    if snacks_indent.enabled then
      snacks_indent.disable()
    else
      snacks_indent.enable()
    end
  end, desc = '[T]oggle [I]ndent [H]ighlighting' },
  -- zen
  { '<leader>tz', function () Snacks.zen() end, desc = '[T]oggle [Z]en mode' },
}
if (vim.g.picker_plugin == 'snacks.picker') then
  vim.list_extend(keys, {
    { '<leader>sp', function() Snacks.picker.pickers() end, desc = '[S]earch select [P]icker' },
    { '<leader>s!', function() Snacks.picker.notifications() end, desc = '[S]earch notifications[!]' },
    -- find
    { '<leader><leader>', function() Snacks.picker.buffers() end, desc = '[ ] Find existing buffers' },
    { '<leader>sn', function() Snacks.picker.files({ cwd = vim.fn.stdpath('config'), title = 'Neovim config files' }) end, desc = '[S]earch [N]eovim config files' },
    { '<leader>sf', function() Snacks.picker.files() end, desc = '[S]earch [F]iles' },
    { '<leader>sF', function() Snacks.picker.smart() end, desc = '[S]earch [F]iles (Smart)' },
    { '<leader>sr', function() Snacks.picker.recent() end, desc = '[S]earch [R]ecent files' },
    -- git
    -- Grep
    { '<leader>s/', function() Snacks.picker.grep_buffers() end, desc = '[S]earch by live grep in open buffers' },
    { '<leader>sg', function() Snacks.picker.grep() end, desc = '[S]earch by live [G]rep' },
    { '<leader>sw', function() Snacks.picker.grep_word() end, desc = '[S]earch current [W]ord', mode = { 'n', 'x' } },
    -- search
    { '<leader>s\'', function() Snacks.picker.marks() end, desc = '[S]earch/jump marks (`\'` = mark jump)' },
    { '<leader>s\"', function() Snacks.picker.registers() end, desc = '[S]earch/copy registers (`\"` = register)' },
    { '<leader>sd', function() Snacks.picker.diagnostics() end, desc = '[S]earch workspace [D]iagnostics' },
    { '<leader>sD', function() Snacks.picker.diagnostics_buffer() end, desc = '[S]earch buffer [D]iagnostics' },
    { '<leader>sh', function() Snacks.picker.help() end, desc = '[S]earch [H]elp' },
    { '<leader>se', function() Snacks.picker.icons() end, desc = '[S]earch Symbols/[E]mojis' },
    { '<leader>sj', function() Snacks.picker.jumps() end, desc = '[S]earch [J]ump list' },
    { '<leader>sk', function() Snacks.picker.keymaps() end, desc = '[S]earch [K]eymaps' },
    { '<leader>s.', function() Snacks.picker.resume() end, desc = '[S]earch resume/repeat (`.` = repeat)' },
    { '<leader>sc', function() Snacks.picker.highlights() end, desc = '[S]earch Neovim highlights/[C]olors' },
  })
end
local quickfile_enabled = not vim.o.diff
return {
  {
    'folke/snacks.nvim',
    enabled = vim.fn.has('nvim-0.9.4') == 1,
    event = 'VimEnter',
    priority = 100, -- default is 50, this is high priority so snacks.bigfile loads early
    init = function()

      -- This is an animation library, not actual animations. Disable if you encounter issues.
      vim.g.snacks_animate = true -- vim.b.snacks_animate = false locally for the buffer

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "bigfile",
        callback = function()
          -- Mimic LargeFile plugin
          -- TODO: Save settings and restore on filetype change away from bigfile?
          vim.opt_local.swapfile = false
          vim.opt_local.bufhidden = 'unload'
          vim.opt_local.foldmethod = 'manual'
          vim.opt_local.foldenable = false
          vim.opt_local.complete:remove { 'w', 'b', 'u', 'U', }
          vim.opt_local.backup = false
          vim.opt_local.writebackup = false
          vim.opt_local.undolevels = -1 -- Disable undo history
          -- TODO: snacks.bigfile will schedule to set the syntax back to the original, "off" would be best!
          -- More
          vim.opt_local.wrap = false
        end
      })

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(ev)
          -- Do not allow specific LSPs to attach to big files
          local buf = vim.bo[ev.buf]
          local filetype = buf.filetype
          if filetype == 'bigfile' then
            local client = vim.lsp.get_client_by_id(ev.data.client_id)
            if vim.list_contains({
              'copilot',
            }, client.name) then
              client.stop()
              return
            end
          end
        end
      })

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
        enabled = vim.g.snacks_dashboard_enabled,

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
            -- { icon = " ", key = "n", desc = "New File", action = ":enew | startinsert" },
            { icon = " ", key = "n", desc = "New File", action = ":enew" },
            { icon = "󱇧 ", key = "i", desc = "New File (insert mode)", action = ":enew | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = "<leader>sg" },
            { icon = " ", key = "r", desc = "Recent Files", action = "<leader>sr" },
            { icon = " ", key = "c", desc = "Config", action = "<leader>sn" },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
            -- { icon = " ", key = "q", desc = "Quit", action = ":qa" },
            { icon = " ", key = "q", desc = "Quit", action = ":q" },
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
        replace_netrw = false, -- Using oil plugin to open directories
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
        enabled = vim.g.picker_plugin == 'snacks.picker',
        win = {
          input = {
            keys = {
              ["<c-g>"]     = { "toggle_live", mode = { "i", "n" } }, -- default
              ["<c-space>"] = { "toggle_live", mode = { "i", "n" } }, -- Alternate, to match Telescope
            },
          },
        },
      },

      -- Neovim lua profiler
      profiler = {
        -- For script development or debugging. See docs: https://github.com/folke/snacks.nvim/blob/main/docs/profiler.md
      },

      -- When doing `nvim somefile.txt`, it will render the file as quickly as possible, before loading your plugins. ‼️
      quickfile = {
        enabled = quickfile_enabled,
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
        -- Use keymap to toggle
      },

    },
    keys = keys,
    config = function(_, opts)
      require("snacks").setup(opts);

      -- dashboard
      vim.api.nvim_create_user_command('Dashboard', Snacks.dashboard.open, {})

      -- input
      Snacks.input.enable()
    end,
  },
}

-- vim: sw=2 et
