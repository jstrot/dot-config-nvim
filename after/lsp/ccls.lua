-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/ccls.lua

return {

  root_markers = {
    -- 'compile_commands.json', -- prefer clangd
    '.ccls',
    -- '.git',
  },

  on_attach = function(client, bufnr)

    -- Template code to call default on_attach from lspconfig
    local has_defaults, default_configs = pcall(require, 'lspconfig.configs.' .. client.name)
    if has_defaults and default_configs.on_attach then
      default_configs.on_attach(client, bufnr)
    end

    -- Load ccls plugin, if enabled
    pcall(require, 'ccls')

  end,
}
