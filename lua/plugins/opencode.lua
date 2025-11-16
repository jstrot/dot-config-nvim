-- https://github.com/NickvanDyke/opencode.nvim
--
-- Context markers, like @this: `:help opencode.nvim-contexts`
--
-- Your opencode configuration here: ~/.config/opencode/opencode.jsonc
--
require('jst.ai.config')

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
    enabled = vim.g.agentic_mode_plugin == 'opencode',
    dependencies = {
      "folke/snacks.nvim", -- opts = { input = {}, picker = {}, terminal = {} }
    },
    cmd = {
      'OpencodePrompt',
    },
    keys = {
      { "<leader>aa", function() require("opencode").ask("@this: ", { submit = true }) end,          desc = "[A]gentic: [A]sk opencode", mode = { "n", "x" } },
      { "<leader>as", function() require("opencode").select() end,                                   desc = "[A]gentic: [S]elect opencode command", mode = "n", },
      { "<leader>at", function() require("opencode").toggle() end,                                   desc = "[A]gentic: [T]oggle opencode", mode = "n", },
      { "<leader>al", function() require("opencode").command("session.list") end,                    desc = "[A]gentic: [L]ist opencode sessions", mode = "n", },
      { "<leader>an", function() require("opencode").command("session.new") end,                     desc = "[A]gentic: [N]ew opencode session", mode = "n", },
      { "<leader>af", focus_opencode_window,                                                         desc = "[A]gentic: [F]ocus opencode window", mode = "n", },
      { "<leader>aS", function() require("opencode").command("session.interrupt") end,               desc = "[A]gentic: [S]top/interrupt opencode current session", mode = "n", },
      { "<leader>aC", function() vim.api.nvim_command('edit ~/.config/opencode/opencode.jsonc') end, desc = "[A]gentic: edit opencode [C]onfig", mode = "n", },
      -- { "<S-C-u>",    function() require("opencode").command("session.half.page.up") end,            desc = "[A]gentic: opencode half page up", mode = "n", },
      -- { "<S-C-d>",    function() require("opencode").command("session.half.page.down") end,          desc = "[A]gentic: opencode half page down", mode = "n", },
    },
    config = function()
      local auto_reload = true -- Disable if you find this annoying

      ---@type opencode.Opts
      vim.g.opencode_opts = {
        auto_reload = auto_reload,
      }

      if auto_reload then
        vim.o.autoread = true
      end
    end,
  }
}

-- vim: sw=2 et
