-- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/pyright.lua
local jst = require('jst')

-- TODO: common code for pyright/basedpyright paths
-- Prefer basedpyright to pyright; Prefer venv to $PATH.
local pyright_lsp_path = ''
local basedpyright_lsp_path = ''
basedpyright_lsp_path = jst.fn.venv_exepath('basedpyright-langserver')
if basedpyright_lsp_path == '' then
  pyright_lsp_path = jst.fn.venv_exepath('pyright-langserver')
end
if basedpyright_lsp_path == '' and pyright_lsp_path == '' then
  basedpyright_lsp_path = vim.fn.exepath('basedpyright-langserver')
  if basedpyright_lsp_path == '' then
    pyright_lsp_path = vim.fn.exepath('pyright-langserver')
  end
end
if basedpyright_lsp_path == '' then
  basedpyright_lsp_path = 'basedpyright-langserver'
end
if pyright_lsp_path == '' then
  pyright_lsp_path = 'pyright-langserver'
end

return {
  cmd = { pyright_lsp_path, '--stdio' },
  filetypes = jst.fn.isresolvedpath(basedpyright_lsp_path) and {} -- prefer basedpyright
    or { 'python' },
  settings = {
    pyright = {
      disableOrganizeImports = true, -- use ruff instead
      -- There's no way to suppress tagged hints and they are mostly duplicates of other diagnostics.
      -- See https://github.com/neovim/neovim/issues/30444
      disableTaggedHints = true,
    },
    python = {
      analysis = {
        ignore = { '*' }, -- use ruff instead
        -- typeCheckingMode = 'off', -- Using mypy
        -- reportMatchNotExhaustive = true,
      },
    },
  },
}
