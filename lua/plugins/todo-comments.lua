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
  },
}

-- vim: sw=2 et
