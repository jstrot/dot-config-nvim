-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#copilot
return {
  -- cmd = function()
  --   local copilot_ls_path = vim.fn.exepath("copilot-language-server")
  --   if copilot_ls_path == "" then
  --     copilot_ls_path = "copilot-language-server"
  --   end
  --   return {
  --     vim.g.copilot_node_command or vim.g.node_host_prog or "node",
  --     copilot_ls_path,
  --     "--stdio"
  --   }
  -- end,
  cmd = {
      "/home/strottie/.config/nvm/versions/node/v22.15.0/bin/node",
      "/home/strottie/.local/share/nvim/mason/bin/copilot-language-server",
      "--stdio",
  }
}
