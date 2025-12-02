-- https://github.com/jamessan/vim-gnupg

-- WARN:
-- TTY-based pinentry programs cannot run on the same terminal as Neovim.
-- For this reason, the DISPLAY environment variable is checked to ensure that
-- a graphical pinentry program can be used.

return {
  {
    "jamessan/vim-gnupg",
    cond = vim.env.DISPLAY ~= nil,
    lazy = false,
  },
}

-- vim: sw=2 et
