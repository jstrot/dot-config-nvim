--
-- This file contains Image support configuration options.
--
-- To determine the final configuration, run `:checkhealth jst.images`
--

--[[ Global Knobs ]]

--- Primary knob, turns images support on or off.
vim.g.images_enabled = true

--[[ Environment Configuration ]]

--- True if your terminal has support for Kitty's Graphics Protocol.
-- Konsole, wayst, WezTerm, and others also support this.
vim.g.have_kitty_graphics_protocol = false

--- True if you have the `magick` rock installed.
-- The `magick` rock provides Lua bindings to ImageMagick for LuaJIT.
vim.g.have_magick_rock = false

--[[ Features Configuration ]]

--- If true, images support plugins will be start automatically.
-- If false, you need to start plugins manually using `:lua require(...)` or keymaps.
vim.g.images_auto_start = true

-- vim: sw=2 et
