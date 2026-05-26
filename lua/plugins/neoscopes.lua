-- https://github.com/smartpde/neoscopes
return {
  {
    'smartpde/neoscopes',
    event = 'VimEnter',  -- Match Telescope's event to make sure any Telescope is bounded by the initial scope.
    dependencies = {
      (vim.g.picker_plugin == 'snacks.picker') and 'folke/snacks.nvim' or 'nvim-telescope/telescope.nvim',
    },
    opts = {
      enable_scopes_from_npm = true,
      diff_ancestors_for_scopes = {
        -- WARN: This can really slow down loading times!
        -- "origin/main",
      },
      scopes = {
        {
          name = "Neovim config",
          dirs = {
            "~/.config/nvim",
          },
        },
        {
          name = "Neovim plugins",
          dirs = {
            "~/.local/share/nvim/lazy",
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

      if (vim.g.picker_plugin == 'snacks.picker') then
        local has_snacks_picker, snacks_picker = pcall(require, 'snacks.picker')
        if has_snacks_picker then
          local layout = require("snacks.picker.config.layouts")
          local function scoped_find_files()
            local search_opts = {}
            local search_dirs = scopes.get_current_scope() and scopes.get_current_paths() or {}
            if next(search_dirs) ~= nil then
              search_opts.title = 'Find Files (scoped)'
              search_opts.dirs = search_dirs
            end
            snacks_picker.files(search_opts)
          end
          local function scoped_grep_string()

            -- Determine `word` as in lua/snacks/picker/core/picker.lua
            local visual = Snacks.picker.util.visual()
            local word = visual and visual.text or vim.fn.expand("<cword>")
            word = tostring(word)

            local search_opts = {}
            local search_dirs = scopes.get_current_scope() and scopes.get_current_paths() or {}
            if next(search_dirs) ~= nil then
              search_opts.title = "Find Word (" .. word:gsub("\n", "\\n") .. ") (scoped)"
              search_opts.dirs = search_dirs
            end
            snacks_picker.grep_word(search_opts)
          end
          local function scoped_live_grep()
            local search_opts = {}
            local search_dirs = scopes.get_current_scope() and scopes.get_current_paths() or {}
            if next(search_dirs) ~= nil then
              search_opts.title = 'Live Grep (scoped)'
              search_opts.dirs = search_dirs
            end
            -- TODO: live_grep_args
            snacks_picker.grep(search_opts)
          end
          local function scope_picker()
            local items = {}
            for name, scope in pairs(scopes.get_all_scopes()) do
              local preview = ''
              if #(scope.dirs or {}) > 0 then
                preview = preview .. "Directories\n"
                preview = preview .. "===========\n"
                preview = preview .. "\n"
                for _, e in ipairs(scope.dirs) do
                  preview = preview .. "- " .. e .. "\n"
                end
                preview = preview .. "\n"
              end
              if #(scope.files or {}) > 0 then
                preview = preview .. "Files\n"
                preview = preview .. "=====\n"
                preview = preview .. "\n"
                for _, e in ipairs(scope.files) do
                  preview = preview .. "- " .. e .. "\n"
                end
                preview = preview .. "\n"
              end
              table.insert(items, {
                text = name,
                name = name,
                scope = scope,
                preview = {
                  text = string.gsub(preview, '\n+$', ''),
                  ft = "markdown",
                },

              })
            end
            return Snacks.picker({
              items = items,
              confirm = function(picker, item)
                picker:close()
                scopes.set_current(item.name)
              end,
              format = function(item)
                local ret = {}
                ret[#ret + 1] = { item.name, 'SnacksPickerLabel' }
                return ret
              end,
              preview = 'preview',
              title = 'Neoscopes',
            })
          end
          vim.keymap.set('n', '<leader>sf', scoped_find_files, { desc = '[S]earch [F]iles (scoped)' })
          vim.keymap.set('n', '<leader>sw', scoped_grep_string, { desc = '[S]earch current [W]ord (scoped)' })
          vim.keymap.set('n', '<leader>sg', scoped_live_grep, { desc = '[S]earch by live [G]rep (scoped)' })
          vim.keymap.set('n', '<leader>ss', scope_picker, { desc = '[S]earch select [S]cope' })
        end
      elseif (vim.g.picker_plugin == 'telescope') then
        local has_telescope, ts_builtin = pcall(require, 'telescope.builtin')
        if has_telescope then
          local function scoped_find_files()
            local search_opts = {}
            local search_dirs = scopes.get_current_scope() and scopes.get_current_paths() or {}
            if next(search_dirs) ~= nil then
              search_opts.prompt_title = 'Find Files (scoped)'
              search_opts.search_dirs = search_dirs
            end
            ts_builtin.find_files(search_opts)
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

            local search_opts = {}
            local search_dirs = scopes.get_current_scope() and scopes.get_current_paths() or {}
            if next(search_dirs) ~= nil then
              search_opts.prompt_title = "Find Word (" .. word:gsub("\n", "\\n") .. ") (scoped)"
              search_opts.search_dirs = search_dirs
            end
            ts_builtin.grep_string(search_opts)
          end
          local function scoped_live_grep()
            local has_live_grep_args, _ = pcall(require('telescope').load_extension, 'live-grep-args')
            local live_grep = has_live_grep_args and require('telescope').extensions.live_grep_args.live_grep_args or ts_builtin.live_grep
            local search_opts = {}
            local search_dirs = scopes.get_current_scope() and scopes.get_current_paths() or {}
            if next(search_dirs) ~= nil then
              search_opts.prompt_title = 'Live Grep (scoped)'
              search_opts.search_dirs = search_dirs
            end
            live_grep(search_opts)
          end
          vim.keymap.set('n', '<leader>sf', scoped_find_files, { desc = '[S]earch [F]iles (scoped)' })
          vim.keymap.set('n', '<leader>sw', scoped_grep_string, { desc = '[S]earch current [W]ord (scoped)' })
          vim.keymap.set('n', '<leader>sg', scoped_live_grep, { desc = '[S]earch by live [G]rep (scoped)' })
          vim.keymap.set('n', '<leader>ss', scopes.select, { desc = '[S]earch select [S]cope' })
        end
      end

      -- Select starup scope; last one wins
      scopes.add_startup_scope() -- adds and selects the '<startup>' scope.
      pcall(scopes.set_current, '<cwd>')
      pcall(scopes.set_current, 'default') -- In case you have a ./neoscopes.config.json and it defines a "default" scope
    end,
  },
}

-- vim: sw=2 et
