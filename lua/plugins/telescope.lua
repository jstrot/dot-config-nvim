return {
  -- https://github.com/nvim-telescope/telescope.nvim
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      {
        -- https://github.com/nvim-telescope/telescope-ui-select.nvim
        'nvim-telescope/telescope-ui-select.nvim',
      },

      'nvim-tree/nvim-web-devicons',
      'folke/trouble.nvim',

      -- https://github.com/nvim-telescope/telescope-live-grep-args.nvim
      {
        "nvim-telescope/telescope-live-grep-args.nvim",
        -- This will not install any breaking changes.
        -- For major updates, this must be adjusted manually.
        version = "^1.0.0",
      },

      -- https://github.com/nvim-telescope/telescope-media-files.nvim
      {
        'nvim-telescope/telescope-media-files.nvim',
      },

      -- https://github.com/rcarriga/nvim-notify
      "rcarriga/nvim-notify", -- See lua/plugins/vim-notify.lua
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      local _, src_trouble = pcall(require, 'trouble.sources.telescope')
      local function open_in_trouble(args)
        src_trouble.open(args)
      end

      local _, lga_actions = pcall(require, 'telescope-live-grep-args.actions')
      local lga_quote_prompt = lga_actions and lga_actions.quote_prompt()
      local function quote_prompt(args)
        lga_quote_prompt(args)
      end

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      local opts = {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        defaults = {
          mappings = {
            -- TODO: XXXJST These are not working!?
            i = {
              ['<c-t>'] = src_trouble and open_in_trouble,
              ["<c-k>"] = lga_quote_prompt and quote_prompt,
            },
            n = {
              ['<c-t>'] = src_trouble and open_in_trouble,
              ["<c-k>"] = lga_quote_prompt and quote_prompt,
            },
          },
        },
        -- pickers = {}
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
          ['media_files'] = {
            filetypes = {
              -- images: Requires https://hpjansson.org/chafa/
              'jpg', 'jpeg',
              'png',
              'tiff',
              'webp',
              -- movies: Requires https://github.com/dirkvdb/ffmpegthumbnailer
              'mkv', 'webm',
              'mov', 'mp4',
              -- fonts: Requires https://github.com/sdushantha/fontpreview
              'otf',
              'ttf',
              'woff',
              -- other
              'svg', -- Requires https://imagemagick.org/index.php
              'epub', -- Requires https://github.com/marianosimone/epub-thumbnailer
              'pdf', -- Requires https://linux.die.net/man/1/pdftoppm
            },
            find_cmd = vim.fn.executable('fd') == 1 and 'fd' or 'rg',
          },
        },
      }

      if true then
        -- Enable top-down ordering (in sync with file content!)
        opts.defaults = opts.defaults or {}
        opts.defaults.layout_config = opts.defaults.layout_config or {}
        opts.defaults.layout_config.prompt_position = 'top'
        opts.defaults.sorting_strategy = 'ascending'
      end

      require('telescope').setup(opts)
      local telescope = require('telescope')

      -- Enable Telescope extensions if they are installed
      local extensions = require('telescope').extensions
      pcall(telescope.load_extension, 'fzf')
      pcall(telescope.load_extension, 'ui-select')
      local has_media_files, _ = pcall(telescope.load_extension, 'media_files')
      local has_live_grep_args, _ = pcall(telescope.load_extension, 'live-grep-args')
      local has_notify, _ = pcall(telescope.load_extension, 'notify')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      local live_grep = has_live_grep_args and extensions.live_grep_args.live_grep_args or builtin.live_grep

      vim.keymap.set('n', '<leader>sh', builtin.help_tags,     { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps,       { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files,    { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>st', builtin.builtin,       { desc = '[S]earch select [T]elescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string,   { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', live_grep,             { desc = '[S]earch by live [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics,   { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sb', builtin.buffers,       { desc = '[S]earch [B]uffers' })
      vim.keymap.set('n', '<leader>sr', builtin.oldfiles,      { desc = '[S]earch [R]ecent files' })
      vim.keymap.set('n', '<leader>sj', builtin.jumplist,      { desc = '[S]earch [J]ump list' })
      vim.keymap.set('n', '<leader>s.', builtin.resume,        { desc = '[S]earch resume/repeat (`.` = repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      if has_media_files then
        vim.keymap.set('n', '<leader>sm', extensions.media_files.media_files, { desc = '[S]earch [M]edia files' })
      end

      if has_notify then
        vim.keymap.set('n', '<leader>s!', extensions.notify.notify, { desc = '[S]earch notifications[!]' })
      end

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch by live grep in open files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files {
          prompt_title = 'Find Files (Neovim config)',
          cwd = vim.fn.stdpath 'config',
        }
      end, { desc = '[S]earch [N]eovim config files' })

      -- Locally disable paste mode in telescope prompt (otherwise all mappings are disabled)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "TelescopePrompt",
        callback = function() vim.opt_local.paste = false end,
      })
    end,
  },
  -- https://github.com/prochri/telescope-all-recent.nvim
  {
    'prochri/telescope-all-recent.nvim',
    event = 'VeryLazy', -- Don't need this on startup
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "kkharji/sqlite.lua",
      -- optional, if using telescope for vim.ui.select
      "stevearc/dressing.nvim"
    },
  },
  -- https://github.com/nvim-telescope/telescope-symbols.nvim
  {
    'nvim-telescope/telescope-symbols.nvim',
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    keys = {
      {
        '<leader>se', function ()
          local sources = {
            'emoji',
            'kaomoji',
            'gitmoji',
            'math',
            -- 'latex',
          }
          if vim.bo.filetype == 'gitcommit' then
            sources = { 'gitmoji' }
          elseif vim.bo.filetype == 'tex' or vim.bo.filetype == 'plaintex' or vim.bo.filetype == 'context' then
            sources = { 'latex' }
          end
          require('telescope.builtin').symbols{
            sources = sources,
          }
        end, desc = '[S]earch Symbols/[E]mojis'
      },
    },
  },
  -- https://github.com/nvim-telescope/telescope-bibtex.nvim
  {
    'nvim-telescope/telescope-bibtex.nvim',
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    keys = {
      { '<leader>sb', '<cmd>Telescope bibtex<CR>', desc = '[S]earch [B]ibtex references' },
    },
  },
}

-- vim: sw=2 et
