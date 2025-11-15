-- https://github.com/brianhuster/live-preview.nvim
-- XXXJST: Consider these too:
-- https://github.com/yusukebe/gh-markdown-preview
-- https://github.com/MeanderingProgrammer/render-markdown.nvim
return {
  'brianhuster/live-preview.nvim',
  opts = {
    port = 5500,
    browser = 'default',
    dynamic_root = false,
    sync_scroll = false, -- true,
    picker = (
      (vim.g.picker_plugin == 'telescope') and 'telescope' or
      (vim.g.picker_plugin == 'fzf-lua') and 'fzf-lua' or
      (vim.g.picker_plugin == 'mini.pick') and 'mini.pick' or
      -- (vim.g.picker_plugin == 'snacks.picker') and 'snacks.picker' or -- FIXME: live-preview doesn't find it for some reason
      'vim.ui.select'
    ),
    address = (function()
      local interfaces = vim.uv.interface_addresses()
      for iface, iface_addresses in pairs(interfaces) do
        for _, address in ipairs(iface_addresses) do
          if address.family == "inet" and address.internal == false then
            return address.ip
          end
        end
      end
      return '127.0.0.1'  -- fallback to localhost
    end)(),
  },
  cmd = {
    'LivePreview',
  },
  keys = {
      { '<leader>tP', '<cmd>LivePreview start<CR>', desc = '[T]oggle live [P]review' },
  },
  config = function(_, opts)
    require('livepreview.config').set(opts)
  end,
  dependencies = {
    (
      (vim.g.picker_plugin == 'telescope') and 'nvim-telescope/telescope.nvim' or
      (vim.g.picker_plugin == 'fzf-lua') and 'ibhagwan/fzf-lua' or
      (vim.g.picker_plugin == 'mini.pick') and 'echasnovski/mini.pick' or
      (vim.g.picker_plugin == 'snacks.picker') and 'folke/snacks.nvim' or
      nil
    ),
  },
}

-- vim: sw=2 et
