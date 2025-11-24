-- https://github.com/TaDaa/vimade
-- Dim, Fade, Tint, and Customize (Neo)vim
return {
  {
    "TaDaa/vimade",
    enabled = false, -- Opt-in feature
    event = 'VeryLazy',
    config = function()
      require('vimade').setup {
        style = require('vimade.recipe.default').Default().style,
        fadelevel = 0.7, -- Vimade's default is 0.4, which I find too dark.
        blocklist = {
          default = {
            -- Disable vimade in terminal buffers because all it does otherwise is make it gray text and lose all colors.
            buf_opts = {buftype = {'terminal'}},
          },
        },
      }
    end,
  },
}

-- vim: sw=2 et
