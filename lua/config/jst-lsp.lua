-- Lsp logs can get very big very fast!
-- See ~/local/state/nvim/lsp.log
vim.lsp.set_log_level("off")
-- vim.lsp.set_log_level('debug')

local lspconfig = require("lspconfig")
local util = require("lspconfig.util")

-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/ccls.lua
local ccls_root_files = {
  -- prefer clangd "compile_commands.json",
  ".ccls",
}
local ccls_server_config = {
  filetypes = { "c", "cpp", "objc", "objcpp", "opencl" },
  root_dir = function(fname)
    return util.root_pattern(unpack(ccls_root_files))(fname)
    -- or util.find_git_ancestor(fname)
  end,
}
require("ccls").setup { lsp = { lspconfig = ccls_server_config } }

-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/clangd.lua
local clangd_root_files = {
  '.clangd',
  '.clang-tidy',
  '.clang-format',
  'compile_commands.json',
  'compile_flags.txt',
}
require("lspconfig").clangd.setup {
  filetypes = { "c", "cpp", "cc", },
  -- cmd = { "/usr/bin/clangd-18", },
  root_dir = function(fname)
    return util.root_pattern(unpack(clangd_root_files))(fname)
    -- or util.find_git_ancestor(fname)
  end,
}

-- vim: sw=2 et
