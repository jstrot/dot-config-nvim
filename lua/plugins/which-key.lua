-- https://github.com/folke/which-key.nvim
return {
  "folke/which-key.nvim",
  enabled = true,  -- If you disable, you may want to consider a longer `timeoutlen` in init.lua
  event = "VeryLazy",
  opts = {
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Show buffer local keymaps (which-key)",
    },
  },
}

-- vim: sw=2 et
