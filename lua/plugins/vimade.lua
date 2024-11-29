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
      }
    end,
  },
}

-- vim: sw=2 et
