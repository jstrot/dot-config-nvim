-- https://github.com/lewis6991/gitsigns.nvim
return {
  {
    "lewis6991/gitsigns.nvim",
    event = 'VeryLazy',
    opts = {

      signs_staged_enable = true,
      signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
      numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
      linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
      word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
      current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame` (<leader>tgb)

      attach_to_untracked = false,

      on_attach = function(bufnr)
        local gitsigns = require('gitsigns')

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal({']c', bang = true})
          else
            gitsigns.nav_hunk('next')
          end
        end)

        map('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal({'[c', bang = true})
          else
            gitsigns.nav_hunk('prev')
          end
        end)

        -- Actions
        map('n', '<leader>gs', gitsigns.stage_hunk, { desc = '[G]it [S]tage/unstage hunk' })
        map('v', '<leader>gs', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = '[G]it [S]tage/unstage hunk' })
        map('n', '<leader>gr', gitsigns.reset_hunk, { desc = '[G]it [R]eset hunk' })
        map('v', '<leader>gr', function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = '[G]it [R]eset hunk' })
        map('n', '<leader>gp', gitsigns.preview_hunk, { desc = '[G]it [P]review hunk' })
        map('n', '<leader>gb', function() gitsigns.blame_line{full=true} end, { desc = '[G]it [B]lame line' })
        -- Prefer vim-fugitive bindings, if available
        if vim.g.autoloaded_fugitive == nil then
          map('n', '<leader>gS', gitsigns.stage_buffer, { desc = '[G]it [S]tage buffer' })
          map('n', '<leader>gR', gitsigns.reset_buffer, { desc = '[G]it [R]eset buffer' })
          map('n', '<leader>gd', gitsigns.diffthis, { desc = '[G]it vim[D]iff file against the index (or current base)' })
          map('n', '<leader>gD', function() gitsigns.diffthis('~') end, { desc = '[G]it vim[D]iff file against the last commit' })
        end

        -- Toggles
        map('n', '<leader>tgb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle [G]it current line [B]lame' })
        map('n', '<leader>tgd', gitsigns.toggle_deleted,            { desc = '[T]oggle [G]it [D]eleted hunks' }) -- FIXME: Supposedly deprecated but the suggested replacement makes no sense
        map('n', '<leader>tsg', gitsigns.toggle_signs,              { desc = '[T]oggle [S]ign column [G]it info' })

        -- Text object
        map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'Select [I]nside [H]unk' })
      end
    },
  }
}

-- vim: sw=2 et
