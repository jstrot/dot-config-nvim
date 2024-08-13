-- https://github.com/christoomey/vim-tmux-navigator
local function ModeAndNavRight()
  vim.cmd('mode')
  vim.cmd('TmuxNavigateRight')
end

return {
  {
    'christoomey/vim-tmux-navigator',
    cmd = {
      'TmuxNavigateLeft',
      'TmuxNavigateDown',
      'TmuxNavigateUp',
      'TmuxNavigateRight',
      'TmuxNavigatePrevious',
    },
    keys = {
      { '<c-h>',     '<cmd><C-U>TmuxNavigateLeft<cr>',     desc = 'Navigate split left (Tmux aware)' },
      { '<c-j>',     '<cmd><C-U>TmuxNavigateDown<cr>',     desc = 'Navigate split down (Tmux aware)' },
      { '<c-k>',     '<cmd><C-U>TmuxNavigateUp<cr>',       desc = 'Navigate split up (Tmux aware)' },
      { '<c-l>',     ModeAndNavRight,                      desc = 'Navigate split right (Tmux aware)' },
      { '<c-\\>',    '<cmd><C-U>TmuxNavigatePrevious<cr>', desc = 'Navigate to previous split (Tmux aware)' },
      { '<c-space>', '<cmd><C-U>NvimTmuxNavigateNext<cr>', desc = 'Navigate to next split, by pane number (Tmux aware)' },
    },
    config = function()
      -- VimScript only: require('vim-tmux-navigator').setup()

      -- Ctrl-L should also to the default clear+redraw
      vim.keymap.set('n', '<c-l>', ModeAndNavRight, { desc = 'Navigate split right (Tmux aware)' })
    end,
  }
}
-- vim: sw=2 et
