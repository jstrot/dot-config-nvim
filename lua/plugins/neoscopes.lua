-- https://github.com/smartpde/neoscopes
return {
  {
    'smartpde/neoscopes',
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
            search_dirs = scopes.get_current_scope() and scopes.get_current_paths() or {},
          }
        end
        local function scoped_grep_string()
          ts_builtin.grep_string {
            search_dirs = scopes.get_current_scope() and scopes.get_current_paths() or {},
          }
        end
        local function scoped_live_grep()
          local has_live_grep_args, _ = pcall(require('telescope').load_extension, 'live-grep-args')
          local live_grep = has_live_grep_args and require('telescope').extensions.live_grep_args.live_grep_args or ts_builtin.live_grep
          live_grep {
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
