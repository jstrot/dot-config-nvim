-- https://github.com/stevearc/oil.nvim
return {
  {
    'stevearc/oil.nvim',
    -- event = 'VeryLazy',  lazy-loading would break `nvim .`
    dependencies = {
      -- 'echasnovski/mini.icons',
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      keymaps = {
        -- Align keymaps with Telescope
        ["<C-?>"] = "actions.show_help", -- default: "g?"
        ["<CR>"] = "actions.select",
        ["<C-v>"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" }, -- default: "<C-s>"
        ["<C-x>"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" }, -- default: "<C-h>"
        ["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in new tab" },
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = "actions.close",
        ["<C-l>"] = "actions.refresh",
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory", mode = "n" },
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["g."] = "actions.toggle_hidden",
        ["g\\"] = "actions.toggle_trash",
      },
    },
  },
}

-- vim: sw=2 et
