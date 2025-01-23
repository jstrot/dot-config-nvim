-- https://github.com/smartpde/neoscopes
return {
  {
    'smartpde/neoscopes',
    event = 'VimEnter',  -- Match Telescope's event to make sure any Telescope is bounded by the initial scope.
    dependencies = {
      'nvim-telescope/telescope.nvim' -- Optionally, install telescope for nicer scope selection UI.
    },
    opts = {
      enable_scopes_from_npm = true,
      diff_ancestors_for_scopes = {
        "origin/main",
      },
      scopes = {
        {
          name = "Neovim config",
          dirs = {
            "~/.config/nvim",
          },
        },
        {
          name = "Home",
          dirs = {
            "~",
          },
        },
        {
          name = "Home bin",
          dirs = {
            "~/bin",
          },
        },

        --[[
        {
          name = "project 1",
          dirs = {
            "~/projects/project1",
            "/tmp/out/project1",
          }
        },
        --]]

        -- Special scope for the current working directory.
        { name = "<cwd>", dirs = {}, }
      },
      add_dirs_to_all_scopes = {
        -- "~/Downloads"
      }
    },
    config = function(_, opts)
      local scopes = require('neoscopes')
      scopes.setup(opts)

      --[[
      scopes.add({
        name = "project 2",
        dirs = {
          "~/projects/project2",
        },
      })
      --]]

      local has_telescope, ts_builtin = pcall(require, 'telescope.builtin')
      if has_telescope then
        local function scoped_find_files()
          ts_builtin.find_files {
            prompt_title = 'Find Files (scoped)',
            search_dirs = scopes.get_current_scope() and scopes.get_current_paths() or {},
          }
        end
        local function scoped_grep_string()

          -- Determine `word` as in lua/telescope/builtin/__files.lua `files.grep_string`
          local word
          local visual = vim.fn.mode() == "v"
          if visual == true then
            local saved_reg = vim.fn.getreg "v"
            vim.cmd [[noautocmd sil norm! "vy]]
            local sele = vim.fn.getreg "v"
            vim.fn.setreg("v", saved_reg)
            word = vim.F.if_nil(opts.search, sele)
          else
            word = vim.F.if_nil(opts.search, vim.fn.expand "<cword>")
          end
          word = tostring(word)

          ts_builtin.grep_string {
            prompt_title = "Find Word (" .. word:gsub("\n", "\\n") .. ") (scoped)",
            search_dirs = scopes.get_current_scope() and scopes.get_current_paths() or {},
          }
        end
        local function scoped_live_grep()
          local has_live_grep_args, _ = pcall(require('telescope').load_extension, 'live-grep-args')
          local live_grep = has_live_grep_args and require('telescope').extensions.live_grep_args.live_grep_args or ts_builtin.live_grep
          live_grep {
            prompt_title = 'Live Grep (scoped)',
            search_dirs = scopes.get_current_scope() and scopes.get_current_paths() or {},
          }
        end
        vim.keymap.set('n', '<leader>sf', scoped_find_files, { desc = '[S]earch [F]iles (scoped)' })
        vim.keymap.set('n', '<leader>sw', scoped_grep_string, { desc = '[S]earch current [W]ord (scoped)' })
        vim.keymap.set('n', '<leader>sg', scoped_live_grep, { desc = '[S]earch by live [G]rep (scoped)' })
        vim.keymap.set('n', '<leader>ss', scopes.select, { desc = '[S]earch select [S]cope' })
      end

      scopes.add_startup_scope() -- adds and selects the '<startup>' scope.
      pcall(scopes.set_current, '<cwd>') -- prefer to start with the current directory scope.

      -- In case you have a ./neoscopes.config.json and it defines a "default" scope, load it:
      pcall(scopes.set_current, 'default')
    end,
  },
}

-- vim: sw=2 et
