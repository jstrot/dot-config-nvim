-- https://github.com/ravitemer/mcphub.nvim
-- https://ravitemer.github.io/mcphub.nvim/
-- local mcphub_build_type = "bundled" -- "global", "local", "bundled"
local mcphub_build_type = "bundled" -- "global", "local", "bundled"
return {
    {
        'ravitemer/mcphub.nvim',
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
            -- config = vim.fn.expand(".vscode/mcp.json"), -- Reuse VS Code config from workspace
            config = vim.fn.expand("~/.config/mcphub/servers.json"), -- Default config location
            log = {
                -- level = vim.log.levels.ERROR,
                level = vim.log.levels.DEBUG,
                to_file = true, -- false,
                file_path = vim.fn.expand("~/mcphub.log"),
                prefix = "MCPHub",
            },
            auto_approve = true, -- This sets vim.g.mcphub_auto_approve to true by default (can also be toggled from the HUB UI with `ga`)
        },
        config = function(_, opts)
            require("mcphub").setup(opts)
        end,
    },
}
