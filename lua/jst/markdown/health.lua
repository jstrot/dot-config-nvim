-- Call `:checkhealth jst.markdown`
local jst_md = require('jst.markdown')

local M = {}

M.check = function()

  vim.health.start("JST Markdown Configuration")

  vim.health.start("Filetypes")
  for plugin, fts in pairs(jst_md.markdown_filetypes_per_plugin) do
    vim.health.ok('Plugin: ' .. plugin .. ', filetypes: ' .. table.concat(fts, ', '))
  end

  vim.health.start("Auto-preview")
  for plugin, fts in pairs(jst_md.markdown_filetypes_auto_preview_per_plugin) do
    vim.health.ok('Plugin: ' .. plugin .. ', filetypes: ' .. table.concat(fts, ', '))
  end

end

return M

-- vim: sw=2 et
