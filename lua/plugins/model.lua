-- https://github.com/gsuuon/model.nvim
if false then
return {
  'gsuuon/model.nvim',

  -- Don't need these if lazy = false
  cmd = { 'M', 'Model', 'Mchat' },
  init = function()
    vim.filetype.add({
      extension = {
        mchat = 'mchat',
      }
    })
  end,
  ft = 'mchat',

  keys = {
    {'<C-m>d', ':Mdelete<cr>', mode = 'n'},
    {'<C-m>s', ':Mselect<cr>', mode = 'n'},
    {'<C-m><space>', ':Mchat<cr>', mode = 'n' }
  },

  -- To override defaults add a config field and call setup()

  config = function()
    -- require('model').setup({
    --   prompts = {..},
    --   chats = {..},
    --   ..
    -- })
    --
    -- require('model.providers.ollama').setup({
    --   url = 'http://ollama.jsoft.lan:11434',
    --   model = 'phi3:3.8b',
    -- })
    -- require('model.providers.llamacpp').setup({
    --   binary = '~/path/to/server/binary',
    --   models = '~/path/to/models/directory'
    -- })
  end,
}
else
  return {}
end

-- vim: sw=2 et
