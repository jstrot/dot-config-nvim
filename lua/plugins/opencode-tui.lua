-- https://github.com/NickvanDyke/opencode.nvim
--
-- Context markers, like @this: `:help opencode.nvim-contexts`
--
-- Your OpenCode configuration here: ~/.config/opencode/opencode.jsonc
--
require('jst.ai.config')

-- Opencode in a split terminal will not be affected by Neovim reload prompts.
-- Enabling autoread is optional.
local autoread = false

local function focus_opencode_window()
  local provider_opts = require('opencode.config').opts.provider
  local win = require("snacks.terminal").get(provider_opts.cmd, vim.tbl_deep_extend("force", provider_opts, { create = false }))
  if win then
    win:show()
    vim.api.nvim_set_current_win(win.win)
    vim.cmd.startinsert()
  else
    vim.notify('No opencode window found')
  end
end

return {
  {
    "NickvanDyke/opencode.nvim",
    name = 'opencode-tui', -- To distinguish from sudo-tee/opencode.nvim
    enabled = vim.g.agentic_mode_plugin == 'opencode-tui',
    dependencies = {
      "folke/snacks.nvim", -- opts = { input = {}, picker = {}, terminal = {} }
    },
    cmd = {
      'OpencodePrompt',
    },
    keys = {
      { "<leader>aa", function() require("opencode").ask("@this: ", { submit = true }) end,          desc = "AI/[A]gentic/OpenCode: [A]sk OpenCode", mode = { "n", "x" } },
      { "<leader>as", function() require("opencode").select() end,                                   desc = "AI/[A]gentic/OpenCode: [S]elect OpenCode command", mode = "n", },
      { "<leader>at", function() require("opencode").toggle() end,                                   desc = "AI/[A]gentic/OpenCode: [T]oggle OpenCode", mode = "n", },
      { "<leader>al", function() require("opencode").command("session.list") end,                    desc = "AI/[A]gentic/OpenCode: [L]ist OpenCode sessions", mode = "n", },
      { "<leader>an", function() require("opencode").command("session.new") end,                     desc = "AI/[A]gentic/OpenCode: [N]ew OpenCode session", mode = "n", },
      { "<leader>af", focus_opencode_window,                                                         desc = "AI/[A]gentic/OpenCode: [F]ocus OpenCode window", mode = "n", },
      { "<leader>aS", function() require("opencode").command("session.interrupt") end,               desc = "AI/[A]gentic/OpenCode: [S]top/interrupt OpenCode current session", mode = "n", },
      { "<leader>aC", function() vim.api.nvim_command('edit ~/.config/opencode/opencode.jsonc') end, desc = "AI/[A]gentic/OpenCode: edit OpenCode [C]onfig", mode = "n", },
      -- { "<S-C-u>",    function() require("opencode").command("session.half.page.up") end,            desc = "AI/[A]gentic/OpenCode: OpenCode half page up", mode = "n", },
      -- { "<S-C-d>",    function() require("opencode").command("session.half.page.down") end,          desc = "AI/[A]gentic/OpenCode: OpenCode half page down", mode = "n", },
    },
    config = function()

      ---@type opencode.Opts
      vim.g.opencode_opts = {
        reload = autoread, -- Automatically reload files changed by OpenCode
      }
      if autoread then
        vim.o.autoread = true
      end

    end,
  }
}

-- vim: sw=2 et
