-- https://github.com/christoomey/vim-tmux-navigator
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
      { '<c-l>',     '<cmd><C-U>TmuxNavigateRight<cr>',    desc = 'Navigate split right (Tmux aware)' },
      { '<c-\\>',    '<cmd><C-U>TmuxNavigatePrevious<cr>', desc = 'Navigate to previous split (Tmux aware)' },
      { '<c-space>', '<cmd><C-U>NvimTmuxNavigateNext<cr>', desc = 'Navigate to next split, by pane number (Tmux aware)' },
    },
  }
}
-- vim: sw=2 et
