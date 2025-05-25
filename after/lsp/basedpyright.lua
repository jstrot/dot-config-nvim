-- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/basedpyright.lua
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
  cmd = { basedpyright_lsp_path, '--stdio' },
  filetypes = { 'python' },
  settings = {
    basedpyright = {
      disableOrganizeImports = true, -- use ruff instead
      -- analysis = {
      --   autoSearchPaths = true,
      --   useLibraryCodeForTypes = true,
      --   diagnosticMode = 'openFilesOnly',
      -- },
    },
  },
}
