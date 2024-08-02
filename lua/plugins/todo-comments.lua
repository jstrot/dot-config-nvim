-- https://github.com/folke/todo-comments.nvim
return {
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    opts = {
      signs = false,  -- Enable this if you want to see signs in the margin
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
      },
    },
    config = function(_, opts)
      require('todo-comments').setup(opts)

      vim.keymap.set("n", "<leader>st", '<cmd>TodoTelescope<cr>', { desc = "[S]earch [T]odo comments" })
      vim.keymap.set("n", "]t", function() require("todo-comments").jump_next() end, { desc = "Next todo comment" })
      vim.keymap.set("n", "[t", function() require("todo-comments").jump_prev() end, { desc = "Previous todo comment" })
    end
  },
}

-- vim: sw=2 et
