-- See `:checkhealth jst.images`
local jst_images = require('jst.images')

return {

  -- https://github.com/3rd/image.nvim
  -- 3rd/image.nvim is great with Kitty
  {
    '3rd/image.nvim',
    enabled = jst_images._3rd_image_enabled,
    lazy = not jst_images.auto_start,
    build = jst_images._3rd_image_processor == 'magick_rock',
    opts = {
      backend = jst_images._3rd_backend,
      processor = jst_images._3rd_image_processor,
      tmux_show_only_in_active_window = true,
    },
  },

  -- https://github.com/3rd/diagram.nvim
  {
    '3rd/diagram.nvim',
    dependencies = {
      "3rd/image.nvim",
    },
    enabled = jst_images._3rd_diagram_enabled,
    lazy = not jst_images.auto_start,
    config = function()
      local opts = {
        integrations = {
          require("diagram.integrations.markdown"),
          require("diagram.integrations.neorg"),
        },
        renderer_options = {
          -- mermaid = {
          --   background = nil, -- nil | "transparent" | "white" | "#hex"
          --   theme = nil, -- nil | "default" | "dark" | "forest" | "neutral"
          --   scale = 1, -- nil | 1 (default) | 2  | 3 | ...
          -- },
          -- plantuml = {
          --   charset = nil,
          -- },
          -- d2 = {
          --   theme_id = nil,
          --   dark_theme_id = nil,
          --   scale = nil,
          --   layout = nil,
          --   sketch = nil,
          -- },
          -- gnuplot = {
          --   size = nil, -- nil | "800,600" | ...
          --   font = nil, -- nil | "Arial,12" | ...
          --   theme = nil, -- nil | "light" | "dark" | custom theme string
          -- },
        }
      }
      require("diagram").setup(opts)
    end,
  },

}

--[[
References:
- Kitty: https://sw.kovidgoyal.net/kitty/
- Überzug++: https://github.com/jstkdng/ueberzugpp
--]]

-- vim: sw=2 et
