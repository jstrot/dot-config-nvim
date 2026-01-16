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
      { '<leader>a',   icon='󰵰', group = 'AI/[A]gentic' },
      { '<leader>aD',   icon='', group = 'AI/[A]gentic: [D]ebug' },
      { '<leader>a]',   icon='', group = 'AI/[A]gentic: navigate forward' },
      { '<leader>a[',   icon='', group = 'AI/[A]gentic: navigate backward' },
      { '<leader>ar',   icon='󰕌', group = 'AI/[A]gentic: [R]evert' },
      { '<leader>ap',   icon='󰌾', group = 'AI/[A]gentic: [P]ermission' },
      { '<leader>cc',  icon='󱜸', group = 'AI/[C]hat: [C]hat' },
      { '<leader>ccp', icon='󰭺', group = 'AI/[C]hat: [C]hat [P]rompt' },
      { '<leader>d',   icon='󰱼', group = '[D]ocument' },
      { '<leader>f',   icon='󰛖', group = '[F]ormat' },
      { '<leader>g',   icon='', group = '[G]it' },
      { '<leader>i',   icon='', group = '[I]inspect' },
      { '<leader>o',   icon='', group = '[O]pen/[O]bsidian' },
      { '<leader>r',   icon='', group = '[R]ename' },
      { '<leader>s',   icon='', group = '[S]earch (pickers)' },
      { '<leader>sl',  icon='', group = '[S]earch [L]SP' },
      { '<leader>so',  icon='', group = '[S]earch [O]bsidian' },
      { '<leader>t',   icon='', group = '[T]oggle' },
      { '<leader>td',  icon='', group = '[T]oggle [D]iff' },
      { '<leader>tg',  icon='', group = '[T]oggle [G]it' },
      { '<leader>tk',  icon='󰌌', group = '[T]oggle [K]eymaps' },
      { '<leader>tl',  icon='', group = '[T]oggle [L]SP' },
      { '<leader>ts',  icon='󰈿', group = '[T]oggle [S]ign' },
      { '<leader>tt',  icon='󰐅', group = '[T]oggle [T]reesitter' },
      { '<leader>w',   icon='󱝩', group = '[W]orkspace' },
      { '<leader>x',   icon='', group = '[T]oggle Trouble' },
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
