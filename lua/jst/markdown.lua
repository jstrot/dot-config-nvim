--
-- This file contains Markdown configuration options.
--

local M = {}

M.markdown_default_plugin = 'render-markdown'
M.markdown_default_plugin = 'markview'

local markdown_plugin_opts = {
  markdown = {
    plugin = M.markdown_default_plugin,
    auto_preview = false,
  },
  quarto = {
    plugin = M.markdown_default_plugin,
    auto_preview = false,
  },
  rmd = {
    plugin = M.markdown_default_plugin,
    auto_preview = false,
  },
  Avante = {
    plugin = "render-markdown",
    auto_preview = true,
  },
  codecompanion = {
    plugin = "render-markdown",
    auto_preview = true,
  },
  opencode_output = {
    plugin = "render-markdown",
    auto_preview = true,
  },
  ["copilot-chat"] = {
    plugin = "render-markdown", -- TODO:
    auto_preview = true,
  },
  --[[ Inline ]]
  markdown_inline = {
    plugin = "render-markdown", -- TODO:
    auto_preview = true,
  },
  c = {
    plugin = "render-markdown", -- TODO:
    auto_preview = true,
  },
}

M.markdown_filetypes = {}
M.markdown_filetypes_per_plugin = {}
M.markdown_filetypes_auto_preview_per_plugin = {}
for ft, opts in pairs(markdown_plugin_opts) do
  local plugin = opts.plugin
  if plugin then
    table.insert(M.markdown_filetypes, ft)
    M.markdown_filetypes_per_plugin[plugin] = M.markdown_filetypes_per_plugin[plugin] or {}
    table.insert(M.markdown_filetypes_per_plugin[plugin], ft)
    if opts.auto_preview then
      M.markdown_filetypes_auto_preview_per_plugin[plugin] = M.markdown_filetypes_auto_preview_per_plugin[plugin] or {}
      table.insert(M.markdown_filetypes_auto_preview_per_plugin[plugin], ft)
    end
  end
end

local function is_markview_attached(buf)
  buf = buf or vim.api.nvim_get_current_buf()
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
  buf = buf or vim.api.nvim_get_current_buf()
  if package.loaded['render-markdown']
    and require('render-markdown.core.manager').attached(buf) then
    return true
  end
  return false
end

local function buf_attached_plugin(buf)
  buf = buf or vim.api.nvim_get_current_buf()
  if is_markview_attached(buf) then
    return 'markview'
  elseif is_render_markdown_attached(buf) then
    return 'render-markdown'
  else
    return nil
  end
end
M.buf_attached_plugin = buf_attached_plugin

local function buf_enabled(buf)
  buf = buf or vim.api.nvim_get_current_buf()
  if is_markview_attached(buf) then
    local state = require('markview.state')
    local buf_state = state.get_buffer_state(buf, false);
    return buf_state and buf_state.enable or false
  elseif is_render_markdown_attached(buf) then
    local state = require('render-markdown.state')
    local config = state.get(buf)
    return config.enabled
  else
    vim.notify("No markdown render plugin attached to this buffer", vim.log.levels.WARN)
    return
  end
end
M.buf_enabled = buf_enabled

local function buf_toggle(buf)
  buf = buf or vim.api.nvim_get_current_buf()
  local plugin = 'unknown'
  if is_markview_attached(buf) then
    plugin = 'markview'
    require('markview.actions').toggle(buf)
  elseif is_render_markdown_attached(buf) then
    plugin = 'render-markdown'
    -- require('render-markdown').buf_toggle()
    require('render-markdown.core.manager').set_buf(buf)
  else
    vim.notify("No markdown render plugin attached to this buffer", vim.log.levels.WARN)
    return
  end
  vim.notify('Markdown render toggled: ' .. vim.inspect(buf_enabled(buf)) .. ' (' .. plugin .. ')')
end
M.buf_toggle = buf_toggle

vim.keymap.set('n', '<leader>tm', buf_toggle, { desc = '[T]oggle [M]arkdown render' })

return M

-- vim: sw=2 et
