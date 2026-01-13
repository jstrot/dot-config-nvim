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
      { '<Leader>c',   icon='', group = '[C]ode & [C]ompletion', mode = { "n", "v" } },
      { '<Leader>a',   icon='󰵰', group = 'AI/[A]gentic', mode = { "n", "x" } },
      { '<Leader>aD',  icon='', group = 'AI/[A]gentic: [D]ebug' },
      { '<Leader>a]',  icon='', group = 'AI/[A]gentic: navigate forward' },
      { '<Leader>a[',  icon='', group = 'AI/[A]gentic: navigate backward' },
      { '<Leader>ar',  icon='󰕌', group = 'AI/[A]gentic: [R]evert' },
      { '<Leader>ap',  icon='󰌾', group = 'AI/[A]gentic: [P]ermission' },
      { '<Leader>cc',  icon='󱜸', group = 'AI/[C]hat: [C]hat', mode = { "n", "v" } },
      { '<Leader>ccp', icon='󰭺', group = 'AI/[C]hat: [C]hat [P]rompt' },
      { '<Leader>d',   icon='󰱼', group = '[D]ocument' },
      { '<Leader>f',   icon='󰛖', group = '[F]ormat' },
      { '<Leader>g',   icon='', group = '[G]it' },
      { '<Leader>gh',  icon='', group = '[G]it[H]ub' },
      { '<Leader>i',   icon='', group = '[I]inspect' },
      { '<Leader>o',   icon='', group = '[O]pen/[O]bsidian' },
      { '<Leader>p',   icon='󰈈', group = '[P]review' },
      { '<Leader>r',   icon='', group = '[R]ename' },
      { '<Leader>s',   icon='', group = '[S]earch (pickers)', mode = { "n", "x" } },
      { '<Leader>sl',  icon='', group = '[S]earch [L]SP' },
      { '<Leader>so',  icon='', group = '[S]earch [O]bsidian' },
      { '<Leader>t',   icon='', group = '[T]oggle' },
      { '<Leader>td',  icon='', group = '[T]oggle [D]iff' },
      { '<Leader>tg',  icon='', group = '[T]oggle [G]it' },
      { '<Leader>tk',  icon='󰌌', group = '[T]oggle [K]eymaps' },
      { '<Leader>tl',  icon='', group = '[T]oggle [L]SP' },
      { '<Leader>tld', icon='', group = '[T]oggle [L]SP [D]iagnostics' },
      { '<Leader>ts',  icon='󰈿', group = '[T]oggle [S]ign' },
      { '<Leader>tt',  icon='󰐅', group = '[T]oggle [T]reesitter' },
      { '<Leader>w',   icon='󱝩', group = '[W]orkspace' },
      { '<Leader>x',   icon='', group = '[T]oggle Trouble' },
    },
  },
  keys = {
    {
      "<Leader>?",
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
