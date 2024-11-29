-- https://github.com/TaDaa/vimade
-- Dim, Fade, Tint, and Customize (Neo)vim
return {
  {
    "TaDaa/vimade",
    enabled = false, -- Opt-in feature
    config = function()
      require('vimade').setup {
        style = require('vimade.recipe.default').Default().style,
        ncmode = 'buffers',
        fadelevel = 0.7, -- Vimade's default is 0.4, which I find too dark.
        -- fadelevel = function(style, state)
        --   -- Just an example, but somehow this didn't work reliably.
        --   if style.win.buf_opts.syntax == 'nerdtree' then
        --     return 0.8
        --   else
        --     return 0.6
        --   end
        -- end,
        tint = {
          -- fg = {
          --   rgb = { 0, 0, 255 },
          --   intensity = 0.5,
          -- },
        },
        basebg = '',
        blocklist = {
          buf_opts = {
            buftype = { 'prompt', 'terminal' }
          },
          win_config = { relative = true },
        },
        link = {},
        groupdiff = 1,
        groupscrollbind = 0,
        -- Enable focus fading for tmux.
        -- Add `set -g focus-events on` to your tmux.conf
        enablefocusfading = 1,
        normalid = '',
        normalncid = '',
        nohlcheck = 1,
      }
    end,
  },
}

-- vim: sw=2 et
