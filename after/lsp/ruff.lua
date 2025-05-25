-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/ruff.lua
-- Ruff can be configured through a pyproject.toml, ruff.toml, or .ruff.toml file.
-- See https://docs.astral.sh/ruff/configuration/
local jst = require('jst')

local ruff_path = jst.fn.venv_exepath('ruff', { fallback_exepath = true, fallback_name = true })

return {
  -- DEFAULT: cmd = { 'ruff', 'server' },
  -- OK: cmd = { '/home/jst/src/merryclaude-woo-manager/venv/bin/ruff', 'server' },
  -- WORKS to pick up the right ruff but it can't find venv-specific modules
  cmd = { ruff_path, 'server' },
  -- filetypes = { 'python' },
  on_attach = function (client, bufnr)
    -- Disable hover in favor of Pyright
    client.server_capabilities.hoverProvider = false
  end,
  settings = {
    -- configuration = "~/path/to/ruff.toml"
    -- configurationPreference = "filesystemFirst", -- "editorFirst" | "filesystemFirst" | "editorOnly"
    -- reportMatchNotExhaustive = true, -- NOTE: enable in pyright instead
  },
}
