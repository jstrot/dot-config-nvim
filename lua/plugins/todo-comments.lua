-- https://github.com/folke/todo-comments.nvim
return {
  {
    'folke/todo-comments.nvim',
    event = 'VeryLazy',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    opts = {
      signs = true,  -- Enable this if you want to see signs in the margin
      keywords = {
        -- Standard keywords:
        -- FIX: Looks like this
        --  FIXME: is an alternate
        --  BUG: is an alternate
        --  FIXIT: is an alternate
        --  ISSUE: is an alternate
        -- TODO: Looks like this
        -- HACK: Looks like this
        -- WARN: Looks like this
        -- PERF: Looks like this
        -- NOTE: Looks like this
        -- TEST: Looks like this

        -- Add your own:
        -- XXXJST: Looks like this
        XXXJST = { icon = '😎', color = 'warning', alt = {} },
        -- TEMP: Looks like this
        TEMP = { icon = '🕔', color = 'info', alt = {} },
      },
    },
    config = function(_, opts)
      require('todo-comments').setup(opts)

      local has_telescope, telescope = pcall(require, 'telescope')
      if has_telescope then
        local has_neoscopes, neoscopes = pcall(require, 'neoscopes')
        if has_neoscopes then
          vim.keymap.set("n", "<leader>st", function ()
            local search_dirs = neoscopes.get_current_paths()
            local cwd = search_dirs[1]
            telescope.extensions['todo-comments'].todo({
              prompt_title = cwd and 'Find Todo (scoped: ' .. cwd .. ')' or 'Find Todo (<cwd>)', -- FIXME: todo-comments.lua overrides prompt_title
              cwd = cwd,
            })
          end, { desc = "[S]earch [T]odo comments (scoped)" })
        else
          vim.keymap.set("n", "<leader>st", telescope.extensions['todo-comments'].todo, { desc = "[S]earch [T]odo comments" })
        end
      else
        vim.keymap.set("n", "<leader>st", '<cmd>TodoQuickfix<cr>', { desc = "[S]earch [T]odo comments in quickfix" })
      end
      vim.keymap.set("n", "]t", function() require("todo-comments").jump_next() end, { desc = "Next todo comment" })
      vim.keymap.set("n", "[t", function() require("todo-comments").jump_prev() end, { desc = "Previous todo comment" })
    end
  },
}

-- vim: sw=2 et
