-- https://github.com/benoror/gpg.nvim
return {
  {
    "benoror/gpg.nvim",
    -- This only works if you have a working graphical pinentry, not a text pinentry
    cond = (
      vim.tbl_contains({ 'x11', 'wayland', }, vim.env.XDG_SESSION_TYPE) -- Linux
      or vim.fn.executable('launchctl') == 1 and vim.tbl_contains({ 'Aqua', }, vim.system({'launchctl', 'managername'}):wait().stdout) -- macOS
    ),
  },
}

-- vim: sw=2 et
