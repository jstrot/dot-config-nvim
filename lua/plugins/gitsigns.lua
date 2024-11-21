-- https://github.com/lewis6991/gitsigns.nvim
return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
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
        map('n', '<leader>hs', gitsigns.stage_hunk, { desc = '[H]unk [S]tage' })
        map('v', '<leader>hs', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = '[H]unk [S]tage' })
        map('n', '<leader>hr', gitsigns.reset_hunk, { desc = '[H]unk [R]eset' })
        map('v', '<leader>hr', function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = '[H]unk [R]eset' })
        map('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = '[H]unk stage [U]ndo' })
        map('n', '<leader>hS', gitsigns.stage_buffer, { desc = '[S]tage buffer' })
        map('n', '<leader>hR', gitsigns.reset_buffer, { desc = '[R]eset buffer' })
        map('n', '<leader>hp', gitsigns.preview_hunk, { desc = '[H]unk [P]review' })
        map('n', '<leader>hb', function() gitsigns.blame_line{full=true} end, { desc = '[H]unk [B]lame' })
        map('n', '<leader>hd', gitsigns.diffthis, { desc = 'Perform vim[D]iff' })
        map('n', '<leader>hD', function() gitsigns.diffthis('~') end, { desc = 'Perform vim[D]iff last commit' })

        map('n', '<leader>tgb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle [G]it current line [B]lame' })
        map('n', '<leader>tgd', gitsigns.toggle_deleted,            { desc = '[T]oggle [G]it [D]eleted hunks' })
        map('n', '<leader>tsg', gitsigns.toggle_signs,              { desc = '[T]oggle [S]ign column [G]it info' })

        -- Text object
        map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'Select [H]unk' })
      end
    },
  }
}

-- vim: sw=2 et
