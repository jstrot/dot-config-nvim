-- Fill this configuration:
local is_kitty_term = true -- Support for Kitty's Graphics Protocol. Konsole, wayst and WezTerm supposedly also support this.

local have_magick_rock = false

-- These should auto-configure themselves:
local have_tmux = vim.env.TMUX ~= nil
local have_imagemagick_cli = vim.fn.executable('convert') == 1 and vim.fn.executable('identify') == 1
local have_ueberzug = vim.fn.executable('ueberzug') == 1
local is_terminal = vim.api.nvim_list_uis()[1] and vim.api.nvim_list_uis()[1].stdout_tty
--  vim.fn.has('gui_running') == 0
--  and not vim.g.started_by_firenvim

-- Pick one:
-- 1. If you have want to use ImageMagick CLI tools (convert, identify)
--    On Ubuntu, you need `apt install imagemagick`
local _3rd_image_processor = (
  (have_imagemagick_cli and 'magick_cli')
  or (have_magick_rock and 'magick_rock'
  or nil))
-- 2. If you have want to use magick_rock.
--    On Ubuntu, you need `apt install libmagickwand-dev`
-- processor = 'magick_rock'
local _3rd_backend = (
  is_terminal and (
    is_kitty_term and 'kitty' -- best in class, works great and is very snappy.
    or (have_ueberzug and 'ueberzug') -- backed by ueberzugpp, supports any terminal, but has lower performance.
  ) or nil)

-- print('is_terminal = ' .. vim.inspect(is_terminal))
-- print('_3rd_image_processor = ' .. vim.inspect(_3rd_image_processor))
-- print('_3rd_backend = ' .. vim.inspect(_3rd_backend))

return {

  -- https://github.com/3rd/image.nvim
  -- 3rd/image.nvim is great with Kitty
  {
    '3rd/image.nvim',
    enabled = true,
    lazy = not (_3rd_image_processor and _3rd_backend),
    build = _3rd_image_processor == 'magick_rock',
    opts = {
      backend = _3rd_backend,
      processor = _3rd_image_processor,
      tmux_show_only_in_active_window = true,
    },
  },

  -- https://github.com/3rd/diagram.nvim
  {
    '3rd/diagram.nvim',
    dependencies = {
      "3rd/image.nvim",
    },
    enabled = false, -- You need `mmdc` (mermaid), `plantuml`, and `d2` (ditaa) installed.
    lazy = not (_3rd_image_processor and _3rd_backend),
    config = function()
      require("diagram").setup({
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
        }
      })
    end,
  },

}

--[[
References:
- Kitty: https://sw.kovidgoyal.net/kitty/
- Überzug++: https://github.com/jstkdng/ueberzugpp
--]]

-- vim: sw=2 et
