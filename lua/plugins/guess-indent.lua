-- https://github.com/NMAC427/guess-indent.nvim
return {
  {
    'NMAC427/guess-indent.nvim',
    opts = {
      filetype_exclude = {  -- A list of filetypes for which the auto command gets disabled
        "netrw", "tutor", -- These are excluded by default
        "mail",
      },
    },
  },
}

-- vim: sw=2 et
