-- https://github.com/folke/which-key.nvim
return {
  "folke/which-key.nvim",
  enabled = vim.fn.has('nvim-0.9.4') == 1,
  event = "VeryLazy",
  opts = {
    -- Document existing key chains
    spec = {
      { '[',           icon='', group = 'Navigate backward' },
      { ']',           icon='', group = 'Navigate forward' },
      { '<leader>c',   icon='', group = '[C]ode & [C]ompletion' },
      { '<leader>cc',  icon='󱜸', group = 'AI/[C]opilot [C]hat' },
      { '<leader>d',   icon='󰱼', group = '[D]ocument' },
      { '<leader>f',   icon='󰛖', group = '[F]ormat' },
      { '<leader>g',   icon='', group = '[G]it' },
      { '<leader>i',   icon='', group = '[I]inspect' },
      { '<leader>r',   icon='', group = '[R]ename' },
      { '<leader>s',   icon='', group = '[S]earch (pickers)' },
      { '<leader>sl',  icon='', group = '[S]earch [L]SP' },
      { '<leader>t',   icon='', group = '[T]oggle' },
      { '<leader>td',  icon='', group = '[T]oggle [D]iff' },
      { '<leader>w',   icon='󱝩', group = '[W]orkspace' },
    },
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
