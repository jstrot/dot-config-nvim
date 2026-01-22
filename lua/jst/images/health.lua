-- Call `:checkhealth jst.images`
local jst_images = require('jst.images')

local M = {}

M.check = function()
  vim.health.start("JST Images Configuration")

  vim.health.start("Environment")
  if jst_images.enabled then
    vim.health.ok("Global switch: Enabled")
  else
    vim.health.warn("Global switch: Disabled", "Set `jst.images.enabled = true` to enable.")
  end

  vim.health.start("Environment")
  if jst_images.is_terminal then
    vim.health.ok("Running in terminal")
  else
    vim.health.warn("NOT running in terminal")
  end
  if jst_images.have_tmux then
    vim.health.ok("Running in tmux")
  else
    vim.health.ok("NOT running in tmux")
  end
  if jst_images.have_kitty_graphics_protocol then
    vim.health.ok("Kitty Graphics Protocol: Supported")
  else
    vim.health.warn("Kitty Graphics Protocol: NOT supported")
  end

  vim.health.start("Applications")
  if jst_images.have_imagemagick_cli then
    vim.health.ok("ImageMagick CLI tools found")
  else
    vim.health.warn("ImageMagick CLI tools not found", "Install `imagemagick` package.")
  end
  if jst_images.have_ueberzug then
    vim.health.ok("Ueberzug found")
  else
    vim.health.warn("Ueberzug not found", "Install `ueberzug` package.")
  end
  if jst_images.have_mmdc then
    vim.health.ok("Mermaid CLI found")
  else
    vim.health.warn("Mermaid CLI not found", "Install `mermaid-cli` package.")
  end
  if jst_images.have_plantuml then
    vim.health.ok("PlantUML found")
  else
    vim.health.warn("PlantUML not found", "Install `plantuml` package.")
  end
  if jst_images.have_d2 then
    vim.health.ok("D2 found")
  else
    vim.health.warn("D2 not found", "Install `d2` package.")
  end
  if jst_images.have_gnuplot then
    vim.health.ok("GNU Plot found")
  else
    vim.health.warn("GNU Plot not found", "Install `gnuplot` package.")
  end

  vim.health.start("Configuration")
  if jst_images._3rd_diagram_auto then
    vim.health.ok("Diagram rendering: Automatic")
  else
    vim.health.ok("Diagram rendering: Manual only")
  end

  vim.health.start("Plugins")
  if jst_images._3rd_image_processor then
    vim.health.ok("Image processor: " .. vim.inspect(jst_images._3rd_image_processor))
  else
    vim.health.warn("Image processor: none")
  end
  if jst_images._3rd_backend then
    vim.health.ok("Backend: " .. vim.inspect(jst_images._3rd_backend))
  else
    vim.health.error("Backend: none -- Images support is limited")
  end
  vim.health.ok("'3rd/image':"
    .. " " .. (jst_images._3rd_image_enabled and "Enabled" or "Disabled")
    .. "/" .. (jst_images._3rd_image_cond and "On" or "Off")
  )
  vim.health.ok("'3rd/diagram':"
    .. " " .. (jst_images._3rd_diagram_enabled and "Enabled" or "Disabled")
    .. "/" .. (jst_images._3rd_diagram_cond and "On" or "Off")
  )

end

return M

-- vim: sw=2 et
