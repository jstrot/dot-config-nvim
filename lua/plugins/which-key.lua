-- https://github.com/folke/which-key.nvim
return {
  "folke/which-key.nvim",
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
  init = function()
    -- Decrease mapped sequence wait time to display which-key popup sooner
    vim.o.timeoutlen = 300
  end,
}

-- vim: sw=2 et
