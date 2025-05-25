-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/clangd.lua

-- Use a custom clang-format. Also see none-ls.lua
local use_custom_clang_format = (vim.g.clang_format_host_prog ~= nil)

return {
  -- filetypes = { 'c', 'cpp', 'cc', },
  offset_encoding = 'utf-16',
  cmd = {
    -- See https://manpages.debian.org/experimental/clangd/clangd.1.en.html
    (vim.g.clangd_host_prog or 'clangd'),
    '--offset-encoding=utf-16',  -- Keep in sync with clangd_extensions.lua
    '--clang-tidy', -- Enable clang-tidy diagnostics: https://clang.llvm.org/extra/clang-tidy/
    '--fallback-style=none',
    '--suggest-missing-includes',
    -- '--inlay-hints=true',  -- TODO: XXXJST SmartDev's clangd is 14.x and does not support display hints using the standard API (15.0 and later required)
  },
  -- root_markers = {
  --   '.clangd',
  --   '.clang-tidy',
  --   '.clang-format',
  --   'compile_commands.json',
  --   'compile_flags.txt',
  --   '.git',
  -- },

  ---@param client vim.lsp.Client
  ---@param bufnr number buffer number
  on_attach = function(client, bufnr)
    local filename = vim.api.nvim_buf_get_name(bufnr)

    if filename:match('^fugitive://') then
      -- clangd will do many error notifications when working on non-files:
      -- > clangd only supports 'file' URI scheme for workspace...
      vim.schedule(function()
        vim.lsp.buf_detach_client(bufnr, client.id)
      end)
      return
    end

    -- Template code to call default on_attach from lspconfig
    local has_defaults, default_configs = pcall(require, 'lspconfig.configs.' .. client.name)
    if has_defaults and default_configs.on_attach then
      default_configs.on_attach(client, bufnr)
    end

    -- Load clangd_extensions plugin, if available
    pcall(require, 'clangd_extensions')

    if use_custom_clang_format then
      client.capabilities.textDocument.formatting = nil
      client.capabilities.textDocument.rangeFormatting = nil
    end

  end,
}
