-- See https://github.com/LazyVim/starter

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local uv = vim.uv or vim.loop
if not uv.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup(
  {
    spec = {
      -- -- add LazyVim and import its plugins
      -- { "LazyVim/LazyVim", import = "lazyvim.plugins" },
      -- -- import any extras modules here
      -- -- { import = "lazyvim.plugins.extras.lang.typescript" },
      -- -- { import = "lazyvim.plugins.extras.lang.json" },
      -- -- { import = "lazyvim.plugins.extras.ui.mini-animate" },
      -- { import = "lazyvim.plugins.extras.lsp.none-ls" },
      -- import/override with your plugins from ~/.config/nvim/plugins/
      { import = "plugins" },
    },
    defaults = {
      -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
      -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
      lazy = false,
      -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
      -- have outdated releases, which may break your Neovim install.
      version = false, -- always use the latest git commit
      -- version = "*", -- try installing the latest stable version for plugins that support semver
    },
    install = {
      colorscheme = {
        -- "tokyonight",
        -- "habamax",
      },
    },
    checker = {
      enabled = true, -- automatically check for plugin updates
      frequency = 7 * 24 * 60 * 60, -- check for updates once a week
    },
    change_detection = {
      enabled = false,
    },
    performance = {
      rtp = { -- "runtimepath"
        -- disable some rtp plugins
        disabled_plugins = {
          -- "gzip",
          -- "matchit",
          -- "matchparen",
          -- "netrwPlugin",
          -- "tarPlugin",
          -- "tohtml",
          -- "tutor",
          -- "zipPlugin",
        },
      },
    },
    dev = {
      path = "~/src/nvim",
    },
    ui = {
      -- If you are using a Nerd Font: set icons to an empty table which will use the
      -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
      icons = vim.g.have_nerd_font and {} or {
        cmd = '⌘',
        config = '🛠',
        event = '📅',
        ft = '📂',
        init = '⚙',
        keys = '🗝',
        plugin = '🔌',
        runtime = '💻',
        require = '🌙',
        source = '📄',
        start = '🚀',
        task = '📌',
        lazy = '💤 ',
      },
    },
  }
)

-- vim: sw=2 et
