-- https://github.com/ravitemer/mcphub.nvim
-- https://ravitemer.github.io/mcphub.nvim/
local mcphub_build_type = "bundled" -- "global", "local", "bundled"

local function mcphub_config_file()
  local config_file = nil
  local config_files = {
    ".vscode/mcp.json", -- Reuse VS Code config from workspace?
    "~/.config/mcphub/servers.json" -- Default config location, must be last.
  }
  for _, test_file in ipairs(config_files) do
    config_file = vim.fn.expand(test_file)
    if vim.fn.exists(config_file) == 1 then
      break
    end
  end
  return config_file
end

return {
  {
    'ravitemer/mcphub.nvim',
    enabled = vim.tbl_contains({ "avante", "codecompanion", }, vim.g.agentic_mode_plugin),
    build = (
      mcphub_build_type == "global" and "npm install -g mcp-hub@latest" or (
      mcphub_build_type == "bundled" and "bundled_build.lua" or (
      mcphub_build_type == "node" and nil or (
      nil)))),
    opts = {
      -- port = 3001,
      use_bundled_binary = (mcphub_build_type == "bundled"),
      cmd = mcphub_build_type == "node" and (vim.g.node_host_prog or 'node') or nil,
      cmdArgs = mcphub_build_type == "node" and ({vim.fn.stdpath('data') .. '/lazy/mcphub.nvim/bundled/mcp-hub/node_modules/mcp-hub/dist/cli.js'}) or nil,
      config = mcphub_config_file(),
      log = {
        -- level = vim.log.levels.ERROR,
        level = vim.log.levels.DEBUG,
        to_file = true, -- false,
        file_path = vim.fn.expand("~/mcphub.log"),
        prefix = "MCPHub",
      },
      extensions = {
        avante = {
          make_slash_commands = true, -- make /slash commands from MCP server prompts
        }
      },
      auto_approve = true, -- This sets vim.g.mcphub_auto_approve to true by default (can also be toggled from the HUB UI with `ga`)
    },
    config = function(_, opts)
      require("mcphub").setup(opts)
    end,
  },
}

-- vim: sw=2 et
