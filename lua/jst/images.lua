--
-- This file contains Images configuration options.
--

require('config.images')

local M = {}

-- Global Knobs
M.enabled = vim.g.images_enabled or false

-- Environment Configuration
M.have_kitty_graphics_protocol = vim.g.have_kitty_graphics_protocol or false
M.have_magick_rock = vim.g.have_magick_rock or false

-- Features Configuration
M.auto_start = vim.g.images_auto_start or false

M.is_terminal = vim.api.nvim_list_uis()[1] and vim.api.nvim_list_uis()[1].stdout_tty

M.have_tmux = vim.env.TMUX ~= nil
M.have_imagemagick_cli = vim.fn.executable('convert') == 1 and vim.fn.executable('identify') == 1
M.have_ueberzug = vim.fn.executable('ueberzug') == 1
--  vim.fn.has('gui_running') == 0
--  and not vim.g.started_by_firenvim
M.have_mmdc = vim.fn.executable('mmdc') == 1 -- mermaid
M.have_plantuml = vim.fn.executable('plantuml') == 1 -- plantUML
M.have_d2 = vim.fn.executable('d2') == 1 -- D2 (ditaa)
M.have_gnuplot = vim.fn.executable('gnuplot') == 1 -- GNU Plot

-- Pick one:
-- 1. If you have want to use ImageMagick CLI tools (convert, identify)
--    On Ubuntu, you need `apt install imagemagick`
-- 2. If you have want to use magick_rock.
--    On Ubuntu, you need `apt install libmagickwand-dev`
M._3rd_image_processor = (
  (M.have_imagemagick_cli and 'magick_cli')
  or (M.have_magick_rock and 'magick_rock'
  or nil))

M._3rd_backend = (
  M.is_terminal and (
    M.have_kitty_graphics_protocol and 'kitty' -- best in class, works great and is very snappy.
    or (M.have_ueberzug and 'ueberzug') -- backed by ueberzugpp, supports any terminal, but has lower performance.
  )
  or nil)

M._3rd_image_enabled =
  M.enabled
  and M._3rd_image_processor
  and M._3rd_backend

M._3rd_diagram_enabled =
  M._3rd_image_enabled
  and (
    -- You need one of these:
    M.have_mmdc
    or M.have_plantuml
    or M.have_d2
    or M.have_gnuplot
  )

M._3rd_diagram_auto = vim.g.images_auto_diagrams or false

return M

-- vim: sw=2 et
