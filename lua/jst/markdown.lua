--
-- This file contains Markdown configuration options.
--

local M = {}

local markdown_plugin_per_ft = {
  markdown = "markview",
  quarto = "markview",
  rmd = "markview",
  Avante = "markview",
  codecompanion = "markview",
  opencode_output = "render-markdown",
  ["copilot-chat"] = "markview", -- TODO:
}

M.markdown_default_plugin = 'markview'

M.markdown_filetypes_per_plugin = {}
for ft, plugin in pairs(markdown_plugin_per_ft) do
  M.markdown_filetypes_per_plugin[plugin] = M.markdown_filetypes_per_plugin[plugin] or {}
  table.insert(M.markdown_filetypes_per_plugin[plugin], ft)
end

local function is_markview_attached(buf)
  if package.loaded['markview'] then
    local state = require('markview.state')
    if state.buf_attached(buf) == false then
      return false
    elseif state.get_splitview_source() == buf then
      return false -- not strictly attached to this buffer, splitview used instead
    else
      return true
    end
  end
  return false
end

local function is_render_markdown_attached(buf)
  if package.loaded['render-markdown']
    and require('render-markdown.core.manager').attached(buf) then
    return true
  end
  return false
end

local function buf_attached_plugin(buf)
  if is_markview_attached(buf) then
    return 'markview'
  elseif is_render_markdown_attached(buf) then
    return 'render-markdown'
  else
    return nil
  end
end
M.buf_attached_plugin = buf_attached_plugin

local function buf_toggle()
  local buf = vim.api.nvim_get_current_buf()
  if is_markview_attached(buf) then
    require('markview.actions').toggle(buf)
  elseif is_render_markdown_attached(buf) then
    -- require('render-markdown').buf_toggle()
    require('render-markdown.core.manager').set_buf(buf)
  else
    vim.notify("No markdown render plugin attached to this buffer", vim.log.levels.WARN)
  end
end
M.buf_toggle = buf_toggle

vim.keymap.set('n', '<leader>tm', buf_toggle, { desc = '[T]oggle [M]arkdown render' })

return M

-- vim: sw=2 et
